;            (load "./ontologiaKBS.clp")
;            (load "./kbs.clp")

;(defrule imprimir_exercicis
;    (declare (salience 10))
;    ?instancia <- (object (is-a Ejercicio-Fisico))
;    =>
;    (printout t "Exercici " (instance-name ?instancia)
;    " con intensitat " (send ?instancia get-intensitat) crlf)
;)

(deftemplate programa-exercici
  (slot exercici)
  (slot repeticions)
  (slot duracio)
)

(deftemplate programa
  (multislot llista-exercicis)
)

(defrule preguntar
  (declare (salience 20))
  ?x <- (object(is-a Persona))
  =>
  (printout t "" crlf crlf)
  (printout t "Hola! Benvingut al programa d'inclusió a l'esport per les persones grans." crlf)
  (printout t "Primer de tot rebrà algunes preguntes, per tal d'obtenir un programa d'exercicis personalitzat especialment per a vostè." crlf)
  (printout t "Parlem primer una mica de les seves dades generals." crlf crlf)
  
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
  
  (printout t "Per últim, vostè és una persona fumadora?."crlf)
  (printout t "En cas afirmatiu inserti un 1, en cas contrari un 0." crlf)
  (printout t ">")
  (bind ?fuma (read))
  (send ?x put-fumador ?fuma)
  (if (eq ?fuma 1)
  then
  (printout t "Vostè és fumador." crlf crlf)
  else
  (printout t "Vostè és NO fumador." crlf crlf))
  (printout t "Ara rebrà algunes preguntes referents a les possibles malalties que poden inferir en la creació del programa personalitzat."crlf crlf)
  
  (printout t "Pateix vostè d'alguna malaltia cardiovascular? (Y/N)" crlf)
  (printout t ">")
  (bind ?cv (read))
  (if (eq ?cv Y)
  then
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
  ;tercer grup
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
  ;altres
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

  ;problemes de mobilitat a alguna part del cos
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
; )

    ;iterem per les parts immobils
  (bind ?parts (send ?p get-te_immobil))
    (loop-for-count (?i 1 (length$ $?parts)) do
      ; For every part immobil [me] has
      (bind ?par (nth$ ?i $?parts))
      (printout t crlf "Exercicis incompatibles amb la part del cos: " ?par crlf)
      (bind ?list-exs (send ?par get-incompatible_amb))
      (loop-for-count (?j 1 (length$ ?list-exs)) do
        (bind ?var (nth$ ?j ?list-exs))
        (printout t ?var crlf))
    )
)

