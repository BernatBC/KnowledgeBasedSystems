;;; ---------------------------------------------------------
;;; ontologiaKBS.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologiaKBS.owl
;;; :Date 26/11/2022 11:23:19

(defclass Ejercicio-Fisico
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot intensitat
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

(defclass Persona
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot pateix
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

(definstances instances
    ([Andar-rápido] of Fortalecimiento
         (intensitat  2)
    )

    ([Artritis] of Locomotiva
         (recomenable_amb  [Andar-rápido] [Baile] [Caminar] [Gimnasia] [Ir-en-bici] [Natación] [Pesas])
    )

    ([Baile] of Flexibilización
         (intensitat  2)
    )

    ([Caminar] of Flexibilización
         (intensitat  1)
    )

    ([Cancer] of Otros
         (recomenable_amb  [Caminar] [Correr] [Gimnasia] [Ir-en-bici] [Natación] [Pesas] [Sentadillas])
    )

    ([Correr] of Resistencia
         (intensitat  4)
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

    ([Fibrosis-quistica] of Respiratoria
         (recomenable_amb  [Correr] [Ir-en-bici] [Natación] [Pesas])
    )

    ([Gimnasia] of Resistencia
         (intensitat  3)
    )

    ([Hipertension] of Cardiovascular
         (recomenable_amb  [Andar-rápido] [Caminar] [Gimnasia] [Ir-en-bici] [Natación] [Pesas] [Sentadillas])
    )

    ([Ir-en-bici] of Resistencia
         (intensitat  4)
    )

    ([Natación] of Resistencia
         (intensitat  3)
    )

    ([Obesidad] of Otros
         (recomenable_amb  [Andar-rápido] [Caminar] [Gimnasia] [Ir-en-bici] [Pesas] [Sentadillas])
    )

    ([Osteoporosis] of Locomotiva
         (recomenable_amb  [Caminar] [Gimnasia] [Subir-escaleras])
    )

    ([Pesas] of Fortalecimiento
         (intensitat  2)
    )

    ([Sentadillas] of Fortalecimiento
         (intensitat  3)
    )

    ([Subir-escaleras] of Fortalecimiento
         (intensitat  1)
    )

    ([Trastorno-de-ansiedad] of Otros
         (recomenable_amb  [Baile] [Caminar] [Correr] [Gimnasia] [Ir-en-bici])
    )

    ([me] of Persona
    )

)
