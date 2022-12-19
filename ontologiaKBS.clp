;;; ---------------------------------------------------------
;;; ontologiaKBS.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologiaKBS.owl
;;; :Date 19/12/2022 10:53:14

(defclass Malaltia "Taxonomia de malaltia."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot recomenable_amb
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Cardiovascular
    (is-a Malaltia)
    (role concrete)
    (pattern-match reactive)
)

(defclass Locomotiva
    (is-a Malaltia)
    (role concrete)
    (pattern-match reactive)
)

(defclass Otros "Otros tipos de enfermedades, como pueden ser la diabetes, las enfermedades neurológicas, etc"
    (is-a Malaltia)
    (role concrete)
    (pattern-match reactive)
)

(defclass Respiratoria
    (is-a Malaltia)
    (role concrete)
    (pattern-match reactive)
)

(defclass Ejercicio-Fisico
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot necessita_estirar
        (type INSTANCE)
        (create-accessor read-write))
    (multislot duracio
        (type SYMBOL)
        (create-accessor read-write))
    (slot intensitat
        (type SYMBOL)
        (create-accessor read-write))
    (multislot repeticions
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Equilibrio
    (is-a Ejercicio-Fisico)
    (role concrete)
    (pattern-match reactive)
)

(defclass Flexibilización
    (is-a Ejercicio-Fisico)
    (role concrete)
    (pattern-match reactive)
)

(defclass Fortalecimiento
    (is-a Ejercicio-Fisico)
    (role concrete)
    (pattern-match reactive)
)

(defclass Resistencia
    (is-a Ejercicio-Fisico)
    (role concrete)
    (pattern-match reactive)
)

(defclass Part-del-cos
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot incompatible_amb
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Persona
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot pateix
        (type INSTANCE)
        (create-accessor read-write))
    (multislot te_immobil
        (type INSTANCE)
        (create-accessor read-write))
    (slot alçada
        (type FLOAT)
        (create-accessor read-write))
    (slot edat
        (type SYMBOL)
        (create-accessor read-write))
    (slot fumador
        (type SYMBOL)
        (create-accessor read-write))
    (slot genere
        (type SYMBOL)
        (create-accessor read-write))
    (slot grau_sedentarisme
        (type SYMBOL)
        (create-accessor read-write))
    (slot nom
        (type STRING)
        (create-accessor read-write))
    (slot pes
        (type FLOAT)
        (create-accessor read-write))
    (slot ritme_cardiac_repos
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Programa
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot conte_exercici
        (type INSTANCE)
        (create-accessor read-write))
)

(definstances instances
    ([Abductors] of Part-del-cos
    )

    ([Andar-rápido] of Fortalecimiento
         (necessita_estirar  [Abductors] [Isquiotibials] [Quadriceps])
         (duracio  20)
         (intensitat  2)
         (repeticions  0)
    )

    ([Artritis] of Locomotiva
         (recomenable_amb  [Andar-rápido] [Baile] [Caminar] [Gimnasia] [Ir-en-bici] [Natación] [Pesas])
    )

    ([Baile] of Flexibilización
         (necessita_estirar  [Cervicals] [Lumbars])
         (duracio  20)
         (intensitat  2)
         (repeticions  0)
    )

    ([Biceps] of Part-del-cos
    )

    ([Braç] of Part-del-cos
         (incompatible_amb  [Baile] [Gimnasia] [Ir-en-bici] [Natación] [Pesas])
    )

    ([Cama] of Part-del-cos
         (incompatible_amb  [Andar-rápido] [Baile] [Caminar] [Correr] [Gimnasia] [Ir-en-bici] [Natación] [Sentadillas] [Subir-escaleras])
    )

    ([Caminar] of Flexibilización
         (necessita_estirar  [Abductors] [Isquiotibials] [Quadriceps])
         (duracio  20)
         (intensitat  1)
         (repeticions  0)
    )

    ([Cancer] of Otros
         (recomenable_amb  [Caminar] [Correr] [Gimnasia] [Ir-en-bici] [Natación] [Pesas] [Sentadillas])
    )

    ([Cervicals] of Part-del-cos
         (incompatible_amb  [Baile] [Gimnasia] [Natación])
    )

    ([Correr] of Resistencia
         (necessita_estirar  [Abductors] [Isquiotibials] [Quadriceps])
         (duracio  20)
         (intensitat  4)
         (repeticions  0)
    )

    ([Diabetes] of Otros
         (recomenable_amb  [Andar-rápido] [Caminar] [Gimnasia] [Ir-en-bici] [Natación] [Pesas] [Sentadillas])
    )

    ([Enfermedad-cardiovascular-ateroesclerotica] of Cardiovascular
         (recomenable_amb  [Caminar] [Gimnasia] [Ir-en-bici] [Pesas] [Sentadillas])
    )

    ([Enfermedad-pulmonar-obstructiva-cronica] of Respiratoria
         (recomenable_amb  [Caminar] [Gimnasia] [Ir-en-bici] [Pesas] [Sentadillas])
    )

    ([Esquena] of Part-del-cos
         (incompatible_amb  [Baile] [Correr] [Gimnasia] [Ir-en-bici] [Natación] [Sentadillas])
    )

    ([Fibrosis-quistica] of Respiratoria
         (recomenable_amb  [Correr] [Ir-en-bici] [Natación] [Pesas])
    )

    ([Gimnasia] of Resistencia
         (necessita_estirar  [Cervicals] [Lumbars])
         (duracio  30)
         (intensitat  3)
         (repeticions  0)
    )

    ([Hipertension] of Cardiovascular
         (recomenable_amb  [Andar-rápido] [Caminar] [Gimnasia] [Ir-en-bici] [Natación] [Pesas] [Sentadillas])
    )

    ([Ir-en-bici] of Resistencia
         (necessita_estirar  [Abductors] [Isquiotibials] [Quadriceps])
         (duracio  20)
         (intensitat  4)
         (repeticions  0)
    )

    ([Isquiotibials] of Part-del-cos
    )

    ([Lumbars] of Part-del-cos
    )

    ([Natación] of Resistencia
         (necessita_estirar  [Biceps] [Cervicals] [Pectoral] [Quadriceps])
         (duracio  20)
         (intensitat  3)
         (repeticions  0)
    )

    ([Obesidad] of Otros
         (recomenable_amb  [Andar-rápido] [Caminar] [Gimnasia] [Ir-en-bici] [Pesas] [Sentadillas])
    )

    ([Osteoporosis] of Locomotiva
         (recomenable_amb  [Caminar] [Gimnasia] [Subir-escaleras])
    )

    ([Pectoral] of Part-del-cos
    )

    ([Pesas] of Fortalecimiento
         (necessita_estirar  [Biceps] [Triceps])
         (intensitat  2)
         (repeticions  20)
    )

    ([Quadriceps] of Part-del-cos
    )

    ([Sentadillas] of Fortalecimiento
         (necessita_estirar  [Abductors] [Isquiotibials] [Lumbars] [Quadriceps])
         (intensitat  3)
         (repeticions  20)
    )

    ([Subir-escaleras] of Fortalecimiento
         (necessita_estirar  [Abductors] [Isquiotibials] [Quadriceps])
         (duracio  20)
         (intensitat  1)
         (repeticions  0)
    )

    ([Trastorno-de-ansiedad] of Otros
         (recomenable_amb  [Baile] [Caminar] [Correr] [Gimnasia] [Ir-en-bici])
    )

    ([Triceps] of Part-del-cos
    )

    ([Tronc] of Part-del-cos
         (incompatible_amb  [Baile] [Correr] [Gimnasia] [Natación] [Sentadillas])
    )

    ([me] of Persona
    )

    ([prog] of Programa
    )

)
