PROTOTIP INICIAL PRÀCTICA 2 IA - Bernat Borràs Civil, Òscar Ramos Núñez, Alexandre Ros Roger

Per a executar, cal obrir Clips en aquest directori i fer:

(load "ontologiaKBS.clp")
(load "kbs.clp")
(reset)
(run)


El programa farà un seguit de preguntes inicials i retornarà un conjunt d'exercicis amb unes repeticions / duració que depenen en part de
les condicions físiques de l'usuari i també de la dificultat (estrelles) de l'exercici. De les malalties que l'usuari pateix el programa, en el sistema d'emmagatzematge de coneixement, es manté una 
llista d'exercicis adequats per a aquesta malaltia. També es pregunta si l'usuari pateix alguna discapacitat que no li permeti fer algun dels
exercicis de la llista prèviament obtinguda.

<És un prototip inicial, falten alguns exercicis i malalties, s'haurà d'acabar de refinar.>

**NOTA per nosaltres: Després de regenerar ontologiaKBS.clp, cal canviar els
camps duració i repeticions de multislot a slot.**
