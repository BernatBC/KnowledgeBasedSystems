;(load "./ontologiaKBS.clp")
;(load "./kbs.clp")

;(defrule imprimir_exercicis
;    (declare (salience 10))
;    ?instancia <- (object (is-a Ejercicio-Fisico))
;    =>
;    (printout t "Exercici " (instance-name ?instancia)
;    " con intensitat " (send ?instancia get-intensitat) crlf)
;)

(defrule preguntar
  (declare (salience 20))
  ?x <- (object(is-a Persona))
  =>
  (printout t "Com es diu vostè? ")
  (bind ?nombre (read))
  (send ?x put-nom ?nombre)
  (printout t "Encantat, " (send ?x get-nom) crlf crlf)

  (printout t "Quina edat té vostè? ")
  (bind ?edat (read))
  (send ?x put-edat ?edat)
  (printout t "Tens " (send ?x get-edat) " anys" crlf crlf)

  (printout t "En una escala del 1 (sedentari) al 5 (actiu), on se situaria vostè? ")
  (bind ?graused (read))
  (send ?x put-grau_sedentarisme ?graused)

)
