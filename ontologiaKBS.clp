;;; ---------------------------------------------------------
;;; ontologiaKBS.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologiaKBS.owl
;;; :Date 24/11/2022 19:01:38

(defclass Malaltia "Taxonomia de malaltia."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
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
    (multislot incompatible_amb
        (type INSTANCE)
        (create-accessor read-write))
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
    )

    ([Asma] of Respiratoria
    )

    ([Baile] of Flexibilización
         (incompatible_amb  [Trastorno-de-ansiedad])
         (intensitat  2)
    )

    ([Caminar] of Flexibilización
         (intensitat  1)
    )

    ([Correr] of Resistencia
         (incompatible_amb  [Fibrosis-quistica])
         (intensitat  4)
    )

    ([Diabetes] of Otros
    )

    ([Enfermedad-pulmonar-obstructiva-cronica] of Respiratoria
    )

    ([Fibrosis-quistica] of Respiratoria
    )

    ([Gimnasia] of Resistencia
         (intensitat  3)
    )

    ([Infarto-agudo-miocardio] of Cardiovascular
    )

    ([Insuficiencia-cardiaca] of Cardiovascular
    )

    ([Ir-en-bici] of Resistencia
         (intensitat  4)
    )

    ([Natación] of Resistencia
         (intensitat  3)
    )

    ([Obesidad] of Otros
    )

    ([Osteoporosis] of Locomotiva
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
    )

    ([me] of Persona
    )

)
