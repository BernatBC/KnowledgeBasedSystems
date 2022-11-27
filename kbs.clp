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
    (if (eq ?ht Y) then (assert (pateix [me] [Hipertension])))
    (printout t "Pateix d'ateroesclerosis? (Y/N)" crlf)
    (printout t ">")
    (bind ?ae (read))
    (if (eq ?ae Y) then (assert (pateix [me] [Enfermedad-cardiovascular-ateroesclerotica])))
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
    (if (eq ?ht Y) then (assert (pateix [me] [Artritis])))
    (printout t "Pateix d'osteoporosis? (Y/N)" crlf)
    (printout t ">")
    (bind ?ae (read))
    (if (eq ?ae Y) then (assert (pateix [me] [Osteoporosis])))
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
    (if (eq ?ht Y) then (assert (pateix [me] [Fibrosis-quistica])))
    (printout t "Pateix d'EPOC (Enfermetat Pulmonar Obstructiva Cronica)? (Y/N)" crlf)
    (printout t ">")
    (bind ?ae (read))
    (if (eq ?ae Y) then (assert (pateix [me] [Enfermedad-pulmonar-obstructiva-cronica])))
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
    (if (eq ?ht Y) then (assert (pateix [me] [Cancer])))
    (printout t "Té algun tipus de diabetes? (Y/N)" crlf)
    (printout t ">")
    (bind ?ae (read))
    (if (eq ?ae Y) then (assert (pateix [me] [Diabetes])))
    (printout t "Pateix d'obesitat? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (assert (pateix [me] [Obesitat	])))
    (printout t "Té vostè un tanstorn d'ansietat? (Y/N)" crlf)
    (printout t ">")
    (bind ?ht (read))
    (if (eq ?ht Y) then (assert (pateix [me] [Transtorno-de-ansiedad])))
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
  (printout t "HELLO" crlf)
;  ?m <- (object(is-a Malaltia))
  ?m <- (send [me] get-pateix)
  =>  
;  (bind ?pro (assert (programa p)))
  (bind ?pro (assert (programa)))
  (printout t "Es crea el programa " ?pro crlf)
;  (if (pateix [me] ?m)
;    then
    (bind ?x (send ?m get-recomenable_amb))
    (loop-for-count (?i 1 (length$ ?x)) do
      ; Per a cada exercici recomenable per a cada malaltia
      (bind ?var (nth$ ?i ?x))
      (bind ?temp (assert (programa-exercici)))
      (modify ?temp (exercici ?var))
      (printout t "S'afegeix l'exercici " ?var crlf)
    )
;  )
)
