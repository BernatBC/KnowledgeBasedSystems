;            (load "./ontologiaKBS.clp")
;            (load "./kbs.clp")

; Set de preguntes que ens permetran classificar a la persona.
(defrule preguntar
  (declare (salience 20))
  ?x <- (object(is-a Persona))
  =>
  (printout t "" crlf crlf)
  (printout t "Hola! Benvingut al programa d'inclusió a l'esport per les persones grans." crlf)
  (printout t "Primer de tot rebrà algunes preguntes, per tal d'obtenir un programa d'exercicis personalitzat especialment per a vostè." crlf)
  (printout t "Parlem primer una mica de les seves dades generals." crlf crlf)
  ; Preguntes introductòries
  (printout t "Amb quin gènere es sent més identificat?" crlf)
  (printout t "home" crlf)
  (printout t "dona" crlf)
  (printout t "altres" crlf crlf)
  (printout t ">")
  (bind ?genere (read))
  (send ?x put-genere ?genere)
  (printout t "Perfecte " (send ?x get-genere) ", continuem." crlf crlf)
  
  (printout t "Com es diu vostè? " crlf)
  (printout t ">")
  (bind ?nombre (read))
  (send ?x put-nom ?nombre)
  (printout t "Encantat, " (send ?x get-nom) crlf crlf)
  ; Aquesta pregunta ens servirà per dos coses:
  ; 1- Si la persona té menys de 65 anys expliquem que aquest aplicatiu està destinat a ajudar a les persones majors de 65 i que, per tant, no pot continuar.
  ; 2- Si la persona té més de 65 anys la seva edat serà utilitzada per afinar el nombre de dies setmanals del programa.
  ; Quan més gran sigui la persona menys dies a la setmana tindrà el programa d'exercicis personalitzat.
  (printout t "Quina edat té vostè? " crlf)
  (printout t ">")
  (bind ?edat (read))
  (if (>= 64 ?edat) then (printout t "Ho sentim, però aquest programa està destinat a persones majors de 65 anys. Gràcies per la seva atenció." crlf) (exit))
  (send ?x put-edat ?edat)
  (printout t "Tens " (send ?x get-edat) " anys" crlf crlf)
  
  ;Les dues preguntes següents, preguntar per l'alçada i el pes de la persona ens servirà per identificar si aquest/a pateix d'obesitat.
  ;Podem calcular el BMI (Body Mass Index, Index de Massa Corporal) amb la següent fórmula: BMI = pes/alçada^2  -> pes en quilograms, alçada en metres
  ;Segons l'Organització Mundial de la salut, una persona pateix d'obesitat quan el seu BMI és igual o superior a 30.
  (printout t "Quant medeix? (en centímetres) " crlf)
  (printout t ">")
  (bind ?alcada (read))
  (send ?x put-alçada ?alcada)
  (printout t "Medeix " (send ?x get-alçada) " centímetres" crlf crlf crlf)

  (printout t "Quant pesa? (en quilograms) " crlf)
  (printout t ">")
  (bind ?pes (read))
  (send ?x put-pes ?pes)
  (printout t "Pesa " (send ?x get-pes) " quilograms" crlf crlf crlf)
  ;(printout t "BMI: " (/ ?pes (** (/ ?alcada 100) 2)) crlf)
  (if (>= (/ ?pes (** (/ ?alcada 100) 2)) 30) then (slot-insert$ [me] pateix 1 [Obesidad]))
  


  (printout t "Parlem ara una mica de l'estil de vida." crlf crlf)
  ; El grau de sedentarisme és un aspecte clau a l'hora de decidir com serà el plan d'exercicis de la persona.
  ; Si la persona té grau 5 es considera que ja és molt activa en l'esport i que, per tant, no necessita d'un programa setmanal d'ajuda.
  ; Altrament si el grau està entre 1 i 4 aquest parametre servirà per afinar el nombre de dies setmanals del programa, igual que l'edat. 
  ; Quan més alt sigui el grau, més capacitat té la persona i per tant se li proposen més dies a la setmana d'exercicis.
  (printout t "En una escala del 1 (sedentari) al 5 (actiu), on se situaria vostè? " crlf)
  (printout t ">")
  (bind ?graused (read))
  (if (eq 5 ?graused) 
  then 
  (printout t "Ho sentim, però aquest programa està destinat per introduir a les persones grans a l'esport." crlf)
  (printout t "Considerem que vostè ja està familiaritzat amb l'àmbit esportiu." crlf)
  (printout t "Gràcies per la seva atenció." crlf) (exit))
  
  (send ?x put-grau_sedentarisme ?graused)
  (printout t "" crlf crlf)
  
  (printout t "Quin és el seu ritme cardiac? (en repòs) " crlf)
  (printout t ">")
  (bind ?ritme (read))
  (send ?x put-ritme_cardiac_repos ?ritme)
  (printout t (send ?x get-ritme_cardiac_repos) " pulsacions per minut." crlf crlf)
  
  ; El resultat d'aquesta pregunta serà l'últim paràmetre que permetrà afinar el número de dies setmanals en els quals es proposen exercicis.
  ; Si la persona és NO fumadora es considera que és més sana que una persona fumadora i, per tant, se li recomanen més dies d'exercicis a la setmana.
  (printout t "Per últim, vostè és una persona fumadora?."crlf)
  (printout t "En cas afirmatiu inserti un 0, en cas contrari un 1." crlf)
  (printout t ">")
  (bind ?fuma (read))
  (send ?x put-fumador ?fuma)
  (if (eq ?fuma 0)
  then
  (printout t "Vostè és fumador." crlf crlf)
  else
  (printout t "Vostè és NO fumador." crlf crlf))

  ; Començem ara amb les preguntes sobre les malalties de la persona.
  ; Cada malaltia té associada un grup d'exercicis recomanats (cal remarcar que aquests grups no són disjunts, un exercici pot ser recomenable per més d'una malaltia).
  ; Quan la persona respon afirmativament a la pregunta de si té una malaltia concreta el sistema afegeix a un conjunt d'exercicis potencialment recomanats els exercicis recomanats per aquesta malaltia.
  ; Això fa que si una persona no té cap malaltia de les preguntades el sistema no retorni cap exercici ja que es considera que té llibertat per fer cualsevol exercici sense restriccions.
  (printout t "Ara rebrà algunes preguntes referents a les possibles malalties que poden inferir en la creació del programa personalitzat."crlf crlf)
  
  ; Preguntem per malaties d'àmbit cardiovascular.
  (printout t "Pateix vostè d'alguna malaltia cardiovascular? (Y/N)" crlf)
  (printout t ">")
  (bind ?cv (read))
  (if (eq ?cv Y)
  then
    ; Totes les preguntes de malalties concretes segueixen el mateix patró.
    ; Si la persona té la malaltia aquesta s'insereix a un multislot.
    (printout t "Pateix d'hipertensió? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (slot-insert$ [me] pateix 1 [Hipertension]))
    (printout t "Pateix d'ateroesclerosis? (Y/N)" crlf)
    (printout t ">")
    (bind ?ae (read)) 
    (if (eq ?ae Y) then (slot-insert$ [me] pateix 1 [Enfermedad-cardiovascular-ateroesclerotica]))
  )
  (printout t "Proseguim." crlf crlf)

  ; Següent grup de malalties
  ; Preguntem per malaties d'àmbit locomotiu.
  (printout t "Pateix vostè d'alguna malaltia locomotiva? (Y/N)" crlf)
  (printout t ">")
  (bind ?cv (read))
  (if (eq ?cv Y)
  then
    (printout t "Pateix d'artritis? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (slot-insert$ [me] pateix 1 [Artritis]))
    (printout t "Pateix d'osteoporosis? (Y/N)" crlf)
    (printout t ">")
    (bind ?ae (read))
    (if (eq ?ae Y) then (slot-insert$ [me] pateix 1 [Osteoporosis]))
  )
  (printout t "Bé, continuem." crlf crlf)

  ; Preguntem per malaties respiratòries.
  (printout t "Pateix vostè d'alguna malaltia respiratoria? (Y/N)" crlf)
  (printout t ">")
  (bind ?cv (read))
  (if (eq ?cv Y)
  then
    (printout t "Pateix de fibrosis quistica? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (slot-insert$ [me] pateix 1 [Fibrosis-quistica]))
    (printout t "Pateix d'EPOC (Enfermetat Pulmonar Obstructiva Cronica)? (Y/N)" crlf)
    (printout t ">")
    (bind ?ae (read))
    (if (eq ?ae Y) then (slot-insert$ [me] pateix 1 [Enfermedad-pulmonar-obstructiva-cronica]))
  )
  (printout t "Ja casi estem." crlf crlf)
  
  ; Per últim preguntem per un grup de diverses malalties diferents.
  (printout t "Pateix d'altres enfermetats? (Y/N)" crlf)
  (printout t ">")
  (bind ?cv (read))
  (if (eq ?cv Y)
  then
    (printout t "Pateix d'algun tipus de càncer? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (slot-insert$ [me] pateix 1 [Cancer]))
    (printout t "Té algun tipus de diabetis? (Y/N)" crlf)
    (printout t ">")
    (bind ?ae (read))
    (if (eq ?ae Y) then (slot-insert$ [me] pateix 1 [Diabetes]))
    (printout t "Té vostè un trastorn d'ansietat? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (slot-insert$ [me] pateix 1 [Trastorno-de-ansiedad]))
  )

  ; Preguntem ara per posibles problemes a parts del cos que puguin impossibilitar diversos exercicis.
  ; Cada pregunta va dirigida a una part del cos en concret. Cada part del cos té una sèrie de exercicis "prohibits".
  ; Si una persona respon afirmativament a una pregunta, indicant que té un problema a una part del cos, el sistema elimina del conjunt d'exercicis potencialment recomanats,
  ; obtingut a partir de les preguntes referents a les malalties, els exercicis prohibits pel fet de tenir un problema en la part del cos.
  (printout t "Pateix problemes de mobilitat en alguna part del cos? (Y/N)" crlf)
  (printout t ">")
  (bind ?cv (read))
  (if (eq ?cv Y)
  then
    (printout t "Pateix problemes de mobilitat a un braç o ambdos braços? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (slot-insert$ [me] te_immobil 1 [Braç]))
    
    (printout t "Pateix problemes de mobilitat a una cama o ambdues cames? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (slot-insert$ [me] te_immobil 1 [Cama]))

    (printout t "Pateix problemes de mobilitat a les cervicals? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (slot-insert$ [me] te_immobil 1 [Cervicals]))

    (printout t "Pateix problemes de mobilitat a l'esquena? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (slot-insert$ [me] te_immobil 1 [Esquena]))

    (printout t "Pateix problemes de mobilitat al tronc? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (slot-insert$ [me] te_immobil 1 [Tronc]))
  )
  
  (printout t "Moltes gràcies." crlf crlf)
)

; Pasem ara a calcular quin es el conjunt d'exercicis resultant.
; Partim del conjunt de tots els exercicis recomanats d'acord amb les malalties i eliminen tots els exercicis incompatibles en tenir problemes a certes parts del cos.
(defrule determine_best_exercise
  (declare (salience 10))

  ?p <- (object (is-a Persona))
  =>
  (bind ?mal (send ?p get-pateix))
  (loop-for-count (?i 1 (length$ $?mal)) do
    ; For every illness [me] has
    (bind ?m (nth$ ?i $?mal))
    ;(printout t crlf "Exercicis recomanats per la malaltia: " ?m crlf)

    (bind ?list-exs (send ?m get-recomenable_amb))

    (loop-for-count (?j 1 (length$ ?list-exs)) do
        ; For every recommended activity of the illness
        (bind ?var (nth$ ?j ?list-exs))
        (bind ?x (send [prog] get-conte_exercici))
        (if (not(member$ ?var ?x)) then
          (slot-insert$ [prog] conte_exercici 1 ?var)
        )
        ;(printout t ?var crlf)
    )

  )

  ; Iterem per les parts immobils eliminant exercicis.
  (bind ?parts (send ?p get-te_immobil))
  (loop-for-count (?i 1 (length$ $?parts)) do
    ; For every part immobil [me] has
    (bind ?par (nth$ ?i $?parts))
    ;(printout t crlf "Exercicis incompatibles amb la part del cos: " ?par crlf)
    (bind ?list-exs (send ?par get-incompatible_amb))
    (loop-for-count (?j 1 (length$ ?list-exs)) do
      (bind ?var (nth$ ?j ?list-exs))
      (bind ?x (send [prog] get-conte_exercici))
        (if (member$ ?var ?x) then
          (loop-for-count (?k 1 (length$ ?x)) do
            (bind ?var2 (nth$ ?k ?x))
            (if (eq ?var2 ?var) then
              (slot-delete$ [prog] conte_exercici ?k ?k)
            )
          )
        )

      ;(printout t ?var crlf))
)))

; Per últim construim el pla d'exercicis d'acord amb els exercicis resultants i dels paràmetres de la persona (per ajustar el nombre de dies setmanals).
(defrule write-difference
(declare (salience 5))

?prog <- (object (is-a Programa))

=>
; Per obtenir el numero de dies setmanals partim del mínim (3) i ponderem els tres atributs esmentats a dalt (edat, grau sedentarisme i fumador) per tal d'obtenir un interval d'entre 3 i 7 dies.
; Donem més importància a l'edat (60%) després al grau de sedentarisme (30%) i per últim a si la persona és fumadora o no (10%).
; En el millor dels casos la persona tindrà pocs anys (al voltant de 65), no serà fumadora i tindrà un grau de sedentarisme 4 -> 7 dies a la setmana.
(bind ?numdays  (integer (+ 3 (* 4 ( + (+ (* 0.1 (- (send [me] get-grau_sedentarisme) 1)) (* 0.1 (send [me] get-fumador)) )  (* 0.6 (/ (- 110 (send [me] get-edat)) 45)))))))
;(printout t "Nombre de dies = " ?numdays crlf)
(bind ?x (send [prog] get-conte_exercici))
(printout t crlf)
(printout t "PROGRAMA D'EXERCICIS RECOMANATS" crlf)
(printout t crlf)

; Si el número d'exercicis en el conjunt final dels recomanats és menor que 3 (ja sigui per no tenir cap malaltia o per tenir masses "prohibicions" d'exercicis d'acord amb els problemes a parts del cos),
; llavors s'informa que no s'ha pogut desenvolupar un programa per a les seves característiques (cal remarcar que el número mínim de sesions a la setmana ha de ser 3).
(if (> 3 (length$ ?x)) then
  (printout t "Ho sentim, no hem pogut generar un programa adient per a vostè." crlf)
  (printout t "O bé no pateix de cap malaltia, o bé no li podem recomanar cap exercici físic." crlf)
  (exit)
)

; El sistema proposa un programa de 7 setmanes d'exercicis (on els dies d'exercici són els mateixos).
; Durant les primerers 4 setmanes es va incrementant l'intensitat dels exercicis (augmentant el temps o les repeticions) cada setmana.
(loop-for-count (?week 0 0) do
  (printout t "SETMANA " (+ 1 ?week) crlf crlf)
  (loop-for-count (?day_of_week 0 (- ?numdays 1)) do
    ;(printout t ?week ?day_of_week ?numdays (length$ ?x) crlf)

    (bind ?var1 (nth$ (+ 1 (mod (+ (* ?numdays ?week) ?day_of_week) (length$ ?x))) ?x))
    (bind ?var2 (nth$ (+ 1 (mod (+ 1 (+ (* ?numdays ?week) ?day_of_week)) (length$ ?x))) ?x))
    (bind ?var3 (nth$ (+ 1 (mod (+ 2 (+ (* ?numdays ?week) ?day_of_week)) (length$ ?x))) ?x))

  ; Com que no és bó agrupar tots els dies d'exercicis i després deixar un buit fins al final de la setmana hem organitzat els dies de la següent manera.
  ; Dies setmanals: 3 -> Dies d'exercici: Dilluns, Dimecres i Divendres
  ; Dies setmanals: 4 -> Dies d'exercici: Dilluns, Dimecres, Divendres i Diumenge
  ; Dies setmanals: 5 -> Dies d'exercici: Dilluns, Dimarts, Dijous, Divendres i Diumenge. (Descans: Dimecres i Dissabte)
  ; Dies setmanals: 6 -> Dies d'exercici: Tots els dies excepte el Diumenge.
  ; Dies setmanals: 7 -> Dies d'exercici: Tots els dies.

  ; A cada dia se li asignarà un exercici de la llista de recomanats final. Quan s'arriba al final de la llista s'asigna un altre cop el primer.
  (if (eq ?day_of_week 0) then (printout t "DILLUNS" crlf)
  else (if (and (eq ?day_of_week 1) (> ?numdays 4)) then (printout t "DIMARTS" crlf)
  else (if (or (and (eq ?day_of_week 1) (< ?numdays 5)) (and (eq ?day_of_week 2) (> ?numdays 5))) then (printout t "DIMECRES" crlf)
  else (if (or (and (eq ?day_of_week 2) (eq ?numdays 5)) (and (eq ?day_of_week 3) (> ?numdays 5))) then (printout t "DIJOUS" crlf)
  else (if (or (or (and (eq ?day_of_week 2) (< ?numdays 5)) (and (eq ?day_of_week 3) (eq ?numdays 5))) (and (eq ?day_of_week 4) (> ?numdays 5))) then (printout t "DIVENDRES" crlf)
  else (if (and (eq ?day_of_week 5) (> ?numdays 5)) then (printout t "DISSABTE" crlf)
  else (if (or (or (and (eq ?day_of_week 3) (eq ?numdays 4)) (and (eq ?day_of_week 4) (eq ?numdays 5))) (and (eq ?numdays 7) (eq ?day_of_week 6))) then (printout t "DIUMENGE" crlf))))))))

  (printout t crlf)

      ;Imprimir estiraments de la sessió.
      (bind ?musculs (send ?var1 get-necessita_estirar))
    (loop-for-count (?j 1 (length$ ?musculs)) do
      (bind ?var (nth$ ?j ?musculs))
      (printout t "Estirar " ?var " durant 30 segons" crlf)
        )
  (printout t crlf)
  ; S'imprimeixen ara els exercicis recomanats.
  (printout t "Recomanem que comencis amb " ?var1 " ")
  (bind ?estrelles (send ?var1 get-intensitat))
  (loop-for-count (?i 1 ?estrelles) do (printout t "★"))
  ;calcular temps/repeticions
  (bind ?repeticions (send ?var1 get-repeticions))
  (bind ?duracio (send ?var1 get-duracio))
  (printout t crlf) 

  (if (> ?repeticions 0) then
    ; Si es tracta d'un exercici amb repeticions.
   (printout t "Amb " (integer (* (** 1.07 ?week) (+ ?repeticions (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles))))) " repeticions")
  else 
  ; Si es tracta d'un exercici amb minuts.
  (printout t "Amb " (integer (/ (* (** 1.07 ?week) (+ ?duracio (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles)))) 2)) " minuts de duracio")
  )
  (printout t crlf crlf)


  (printout t "Recomanem que seguidament facis " ?var2 " ")
  (bind ?estrelles2 (send ?var2 get-intensitat))
  (loop-for-count (?i 1 ?estrelles2) do (printout t "★"))
  ;calcular temps/repeticions
  (bind ?repeticions2 (send ?var2 get-repeticions))
  (bind ?duracio2 (send ?var2 get-duracio))
  (printout t crlf) 

  (if (> ?repeticions2 0) then
    ; Si es tracta d'un exercici amb repeticions.
   (printout t "Amb " (integer (* (** 1.07 ?week) (+ ?repeticions2 (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles2))))) " repeticions")
  else 
  ; Si es tracta d'un exercici amb minuts.
  (printout t "Amb " (integer (/ (* (** 1.07 ?week) (+ ?duracio2 (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles2)))) 1)) " minuts de duracio")
  )
  (printout t crlf crlf)


  ;(printout t "DEBUG " ?var3 crlf)

  (printout t "I, finalment, recomanem " ?var3 " ")
  (bind ?estrelles3 (send ?var3 get-intensitat))
  (loop-for-count (?i 1 ?estrelles3) do (printout t "★"))
  ;calcular temps/repeticions
  (bind ?repeticions3 (send ?var3 get-repeticions))
  (bind ?duracio3 (send ?var3 get-duracio))
  (printout t crlf) 


  ; Ara es calcula el número de repeticions o de minuts de l'exercici, depenent de l'exercici.
  ; Aquest valor es calcula segons el valor base de l'exercici, el grau de sedentarisme i la dificultat (estrelles) del propi exercici.
  ; A més, aquest valor es multiplica per un factor que depèn de la setmana fent així un increment de l'intensitat segons la setmana.
  (if (> ?repeticions3 0) then
    ; Si es tracta d'un exercici amb repeticions.
   (printout t "Amb " (integer (* (** 1.07 ?week) (+ ?repeticions3 (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles3))))) " repeticions")
  else 
  ; Si es tracta d'un exercici amb minuts.
  (printout t "Amb " (integer (/ (* (** 1.07 ?week) (+ ?duracio3 (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles3)))) 3)) " minuts de duracio")
  )
  (printout t crlf crlf)

      (bind ?musculs (send ?var3 get-necessita_estirar))
    (loop-for-count (?j 1 (length$ ?musculs)) do
      (bind ?var (nth$ ?j ?musculs))
      (printout t "Estirar " ?var " durant 30 segons" crlf)
        )
  (printout t crlf)
  )
)
; Aquest bucle no s'executa. Era quan es generaven 7 setmanes.
; El procediment es idèntic al de les 4 primeres setmanes però ara el nombre de repeticions / minuts està multiplicat, a més, per 0.95 * num_setmana, fent que cada setmana sigui menys intensa.
(loop-for-count (?week 0 -1) do
  ;(printout t "SETMANA " (+ 5 ?week) crlf crlf)
  (loop-for-count (?day_of_week 0 (- ?numdays 1)) do
    (bind ?var1 (nth$ (+ 1 (mod (+ (* ?numdays ?week) ?day_of_week) (length$ ?x))) ?x))
    (bind ?var2 (nth$ (+ 1 (mod (+ 1 (+ (* ?numdays ?week) ?day_of_week)) (length$ ?x))) ?x))
    (bind ?var3 (nth$ (+ 1 (mod (+ 2 (+ (* ?numdays ?week) ?day_of_week)) (length$ ?x))) ?x))

  (if (eq ?day_of_week 0) then (printout t "DILLUNS" crlf)
  else (if (and (eq ?day_of_week 1) (> ?numdays 4)) then (printout t "DIMARTS" crlf)
  else (if (or (and (eq ?day_of_week 1) (< ?numdays 5)) (and (eq ?day_of_week 2) (> ?numdays 5))) then (printout t "DIMECRES" crlf)
  else (if (or (and (eq ?day_of_week 2) (eq ?numdays 5)) (and (eq ?day_of_week 3) (> ?numdays 5))) then (printout t "DIJOUS" crlf)
  else (if (or (or (and (eq ?day_of_week 2) (< ?numdays 5)) (and (eq ?day_of_week 3) (eq ?numdays 5))) (and (eq ?day_of_week 4) (> ?numdays 5))) then (printout t "DIVENDRES" crlf)
  else (if (and (eq ?day_of_week 5) (> ?numdays 5)) then (printout t "DISSABTE" crlf)
  else (if (or (or (and (eq ?day_of_week 3) (eq ?numdays 4)) (and (eq ?day_of_week 4) (eq ?numdays 5))) (and (eq ?numdays 7) (eq ?day_of_week 6))) then (printout t "DIUMENGE" crlf))))))))

      (bind ?musculs (send ?var1 get-necessita_estirar))
    (loop-for-count (?j 1 (length$ ?musculs)) do
      (bind ?var (nth$ ?j ?musculs))
      (printout t "Esitrar " ?var " durant 30 segons" crlf)
        )

  (printout t crlf)

  (printout t "Recomanem que comencis amb " ?var1 " ")
  (bind ?estrelles (send ?var1 get-intensitat))
  (loop-for-count (?i 1 ?estrelles) do (printout t "★"))
  ;calcular temps/repeticions
  (bind ?repeticions (send ?var1 get-repeticions))
  (bind ?duracio (send ?var1 get-duracio))
  (printout t crlf) 

  (if (> ?repeticions 0) then
    ; Si es tracta d'un exercici amb repeticions.
   (printout t "Amb " (integer (* (** 1.07 ?week) (+ ?repeticions (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles))))) " repeticions")
  else 
  ; Si es tracta d'un exercici amb minuts.
  (printout t "Amb " (integer (/ (* (** 1.07 ?week) (+ ?duracio (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles))))2 )) " minuts de duracio")
  )
  (printout t crlf crlf)


  (printout t "Recomanem que seguidament facis " ?var2 " ")
  (bind ?estrelles2 (send ?var2 get-intensitat))
  (loop-for-count (?i 1 ?estrelles2) do (printout t "★"))
  ;calcular temps/repeticions
  (bind ?repeticions2 (send ?var2 get-repeticions))
  (bind ?duracio2 (send ?var2 get-duracio))
  (printout t crlf) 

  (if (> ?repeticions2 0) then
    ; Si es tracta d'un exercici amb repeticions.
   (printout t "Amb " (integer (* (** 1.07 ?week) (+ ?repeticions2 (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles2))))) " repeticions")
  else 
  ; Si es tracta d'un exercici amb minuts.
  (printout t "Amb " (integer (/ (* (** 1.07 ?week) (+ ?duracio2 (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles2)))) 1.5)) " minuts de duracio")
  )
  (printout t crlf crlf)


  ;(printout t "DEBUG " ?var3 crlf)

  (printout t "I, finalment, recomanem " ?var3 " ")
  (bind ?estrelles3 (send ?var3 get-intensitat))
  (loop-for-count (?i 1 ?estrelles3) do (printout t "★"))
  ;calcular temps/repeticions
  (bind ?repeticions3 (send ?var3 get-repeticions))
  (bind ?duracio3 (send ?var3 get-duracio))
  (printout t crlf) 

  (if (> ?repeticions3 0) then
    ; Si es tracta d'un exercici amb repeticions.
   (printout t "Amb " (integer (* (** 1.07 ?week) (+ ?repeticions3 (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles3))))) " repeticions")
  else 
  ; Si es tracta d'un exercici amb minuts.
  (printout t "Amb " (integer (/ (* (** 1.07 ?week) (+ ?duracio3 (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles3)))) 3)) " minuts de duracio")
  )

  (printout t crlf crlf)

      (bind ?musculs (send ?var3 get-necessita_estirar))
    (loop-for-count (?j 1 (length$ ?musculs)) do
      (bind ?var (nth$ ?j ?musculs))
      (printout t "Esitrar " ?var " durant 30 segons" crlf)
        )

    (printout t crlf)

  )
)

  (printout t crlf)
  (printout t "Les estrelles simbolitzen el grau de dificultat de cada exercici" crlf)

)

