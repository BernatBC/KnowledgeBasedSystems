;            (load "./ontologiaKBS.clp")
;            (load "./kbs.clp")

;(defrule imprimir_exercicis
;    (declare (salience 10))
;    ?instancia <- (object (is-a Ejercicio-Fisico))
;    =>
;    (printout t "Exercici " (instance-name ?instancia)
;    " con intensitat " (send ?instancia get-intensitat) crlf)
;)

; Set de preguntes que ens permetran classificar a la persona
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
  
  (printout t "Quant medeix? (en centímetres) " crlf)
  (printout t ">")
  (bind ?alcada (read))
  (send ?x put-alçada ?alcada)
  (printout t "Medeix " (send ?x get-alçada) " centímetres" crlf crlf crlf)


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
  (printout t (send ?x get-ritme_cardiac_repos) " polsacions per minut." crlf crlf)
  
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
    (printout t "Té algun tipus de diabetes? (Y/N)" crlf)
    (printout t ">")
    (bind ?ae (read))
    (if (eq ?ae Y) then (slot-insert$ [me] pateix 1 [Diabetes]))
    (printout t "Pateix d'obesitat? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (slot-insert$ [me] pateix 1 [Obesidad]))
    (printout t "Té vostè un tanstorn d'ansietat? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (slot-insert$ [me] pateix 1 [Trastorno-de-ansiedad]))
  )

  ; Preguntem ara per posibles problemes a parts del cos que puguin impossibilitar diversos exercicis.
  ; Cada pregunta va dirigida a una part del cos en concret. Cada part del cos té una sèrie de exercicis "prohibits".
  ; Si una persona selecciona 
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

;(defrule dummy
;  ?x <- (object(is-a Persona))
;  =>
;  (printout t "dummy" crlf)
;)

(defrule determine_best_exercise
  (declare (salience 10))
;   ?m <- (object (is-a Malaltia))
;   (test (pateix [me] ?m))
  ?p <- (object (is-a Persona))
;   ?m <- (pateix [me] ?me)
;  (bind ?spat (send [me] get-pateix))
  =>
  ;(bind ?pro (assert (programa p)))
  (bind ?mal (send ?p get-pateix))
  (loop-for-count (?i 1 (length$ $?mal)) do
    ; For every illness [me] has
    (bind ?m (nth$ ?i $?mal))
    (printout t crlf "Exercicis recomanats per la malaltia: " ?m crlf)

    (bind ?list-exs (send ?m get-recomenable_amb))

    (loop-for-count (?j 1 (length$ ?list-exs)) do
        ; For every recommended activity of the illness
        (bind ?var (nth$ ?j ?list-exs))
        ;(assert (fer-exercici ?var))
        (bind ?x (send [prog] get-conte_exercici))
        (if (not(member$ ?var ?x)) then
          (slot-insert$ [prog] conte_exercici 1 ?var)
        )
        (printout t ?var crlf)
        ;(bind ?exe (assert (programa-exercici pe)))
        ;(slot-insert$ ?pro llista-exercicis 1 ?exe)
    )

    

    ;(printout t ?pro crlf)
  )
;  (bind ?pro (assert (programa p)))
;  (bind ?pro (assert (programa)))
;  (printout t "Es crea el programa " ?pro crlf)
  ;(bind ?spat (send [me] get-pateix))
;  (printout t ?m crlf)
;  (if (any-factp ((?f pateix [me] ?m)) TRUE)
;    then
;    (bind ?x (send ?m get-recomenable_amb))
;    (printout t ?m crlf)
;    (loop-for-count (?i 1 (length$ ?x)) do
;      ; Per a cada exercici recomenable per a cada malaltia
;      (bind ?var (nth$ ?i ?x))
;      (bind ?temp (assert (programa-exercici)))
;      (modify ?temp (exercici ?var))
;      (printout t "S'afegeix l'exercici " ?var crlf)
;    )
;)
    ;iterem per les parts immobils
  (bind ?parts (send ?p get-te_immobil))
  (loop-for-count (?i 1 (length$ $?parts)) do
    ; For every part immobil [me] has
    (bind ?par (nth$ ?i $?parts))
    (printout t crlf "Exercicis incompatibles amb la part del cos: " ?par crlf)
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

      (printout t ?var crlf))
))


(defrule write-difference
(declare (salience 5))
;(fer-exercici $? ?v $?)
;?d <- (fer-exercici ?d)
;(test (any-factp ((?d ))))
?prog <- (object (is-a Programa))
;(test (any-factp ((?d incompatible)) TRUE))
;(test (not (member$ ?v ?u))) ;?v in ?u
=>
(bind ?numdays  (integer (+ 3 (* 4 ( + (+ (* 0.1 (- (send [me] get-grau_sedentarisme) 1)) (* 0.1 (send [me] get-fumador)) )  (* 0.6 (/ (- 110 (send [me] get-edat)) 45)))))))
(printout t "Nombre de dies = " ?numdays crlf)
(bind ?x (send [prog] get-conte_exercici))
(printout t crlf)
(printout t "PROGRAMA D'EXERCICIS RECOMENATS" crlf)
(printout t crlf)
(if (> 3 (length$ ?x)) then
  (printout t "Ho sentim, no hem pogut generar un programa adient per a vostè." crlf)
  (printout t "O bé no pateix de cap malaltia, o bé no li podem recomenar cap exercici físic." crlf)
  (exit)
)
; loop de les setmanes on s'incrementes les repeticions/duració
(loop-for-count (?week 0 3) do
  (printout t "SETMANA " (+ 1 ?week) crlf crlf)
  (loop-for-count (?day_of_week 0 (- ?numdays 1)) do
    (bind ?var (nth$ (+ 1 (mod (+ (* ?numdays ?week) ?day_of_week) (length$ ?x))) ?x))

  (if (eq ?day_of_week 0) then (printout t "DILLUNS" crlf)
  else (if (and (eq ?day_of_week 1) (> ?numdays 4)) then (printout t "DIMARTS" crlf)
  else (if (or (and (eq ?day_of_week 1) (< ?numdays 5)) (and (eq ?day_of_week 2) (> ?numdays 5))) then (printout t "DIMECRES" crlf)
  else (if (or (and (eq ?day_of_week 2) (eq ?numdays 5)) (and (eq ?day_of_week 3) (> ?numdays 5))) then (printout t "DIJOUS" crlf)
  else (if (or (or (and (eq ?day_of_week 2) (< ?numdays 5)) (and (eq ?day_of_week 3) (eq ?numdays 5))) (and (eq ?day_of_week 4) (> ?numdays 5))) then (printout t "DIVENDRES" crlf)
  else (if (and (eq ?day_of_week 5) (> ?numdays 5)) then (printout t "DISSABTE" crlf)
  else (if (or (or (and (eq ?day_of_week 3) (eq ?numdays 4)) (and (eq ?day_of_week 4) (eq ?numdays 5))) (and (eq ?numdays 7) (eq ?day_of_week 6))) then (printout t "DIUMENGE" crlf))))))))


  (printout t "Recomanem que facis " ?var " ")
  (bind ?estrelles (send ?var get-intensitat))
  (loop-for-count (?i 1 ?estrelles) do (printout t "★"))
  ;calcular temps/repeticions
  (bind ?repeticions (send ?var get-repeticions))
  (bind ?duracio (send ?var get-duracio))
  (printout t crlf) 
  (if (> ?repeticions 0) then
   (printout t "Amb " (integer (* (** 1.07 ?week) (+ ?repeticions (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles))))) " repeticions")
  else 
  (printout t "Amb " (integer (* (** 1.07 ?week) (+ ?duracio (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles))))) " minuts de duracio")
  )
  (printout t crlf crlf)

  )
)
; loop de les setmanes on es decrementa les repeticions/ dureació
(loop-for-count (?week 0 2) do
  (printout t "SETMANA " (+ 5 ?week) crlf crlf)
  (loop-for-count (?day_of_week 0 (- ?numdays 1)) do
    (bind ?var (nth$ (+ 1 (mod (+ (* ?numdays ?week) ?day_of_week) (length$ ?x))) ?x))

  (if (eq ?day_of_week 0) then (printout t "DILLUNS" crlf)
  else (if (and (eq ?day_of_week 1) (> ?numdays 4)) then (printout t "DIMARTS" crlf)
  else (if (or (and (eq ?day_of_week 1) (< ?numdays 5)) (and (eq ?day_of_week 2) (> ?numdays 5))) then (printout t "DIMECRES" crlf)
  else (if (or (and (eq ?day_of_week 2) (eq ?numdays 5)) (and (eq ?day_of_week 3) (> ?numdays 5))) then (printout t "DIJOUS" crlf)
  else (if (or (or (and (eq ?day_of_week 2) (< ?numdays 5)) (and (eq ?day_of_week 3) (eq ?numdays 5))) (and (eq ?day_of_week 4) (> ?numdays 5))) then (printout t "DIVENDRES" crlf)
  else (if (and (eq ?day_of_week 5) (> ?numdays 5)) then (printout t "DISSABTE" crlf)
  else (if (or (or (and (eq ?day_of_week 3) (eq ?numdays 4)) (and (eq ?day_of_week 4) (eq ?numdays 5))) (and (eq ?numdays 7) (eq ?day_of_week 6))) then (printout t "DIUMENGE" crlf))))))))


  (printout t "Recomanem que facis " ?var " ")
  (bind ?estrelles (send ?var get-intensitat))
  (loop-for-count (?i 1 ?estrelles) do (printout t "★"))
  ;calcular temps/repeticions
  (bind ?repeticions (send ?var get-repeticions))
  (bind ?duracio (send ?var get-duracio))
  (printout t crlf) 
  (if (> ?repeticions 0) then
   (printout t "Amb " (integer (* (** 0.95 ?week) (* (** 1.07 3) (+ ?repeticions (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles)))))) " repeticions")
  else 
  (printout t "Amb " (integer (* (** 0.95 ?week) (* (** 1.07 3) (+ ?duracio (* 10 (/ (send [me] get-grau_sedentarisme) ?estrelles)))))) " minuts de duracio")
  )
  (printout t crlf crlf)

  )
)

  (printout t crlf)
  (printout t "Les estrelles simbolitzen el grau de dificultat de cada exercici" crlf)

)

