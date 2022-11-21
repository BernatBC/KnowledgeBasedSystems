;;; ---------------------------------------------------------
;;; ontologiaKBS.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontologiaKBS.owl
;;; :Date 21/11/2022 10:21:37

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
    )

    ([Artritis] of Locomotiva
    )

    ([Asma] of Respiratoria
    )

    ([Baile] of Flexibilización
    )

    ([Caminar] of Flexibilización
    )

    ([Deporte] of Resistencia
    )

    ([Diabetes] of Otros
    )

    ([Enfermedad-pulmonar-obstructiva-cronica] of Respiratoria
    )

    ([Fibrosis-quistica] of Respiratoria
    )

    ([Gimnasia] of Resistencia
    )

    ([Infarto-agudo-miocardio] of Cardiovascular
    )

    ([Insuficiencia-cardiaca] of Cardiovascular
    )

    ([Ir-en-bici] of Resistencia
    )

    ([Joan] of Persona
         (pateix  [Asma])
         (alçada  170)
         (edat  99)
         (fumador  1)
         (genere  "home")
         (grau_sedentarisme  4)
         (nom  "Joan")
         (pes  80)
         (ritme_cardiac_repos  70)
    )

    ([Natación] of Resistencia
    )

    ([Obesidad] of Otros
    )

    ([Osteoporosis] of Locomotiva
    )

    ([Patricio] of Persona
    )

    ([Pesas] of Fortalecimiento
    )

    ([Sentadillas] of Fortalecimiento
    )

    ([Subir-escaleras] of Fortalecimiento
    )

    ([Trastorno-de-ansiedad] of Otros
    )

)
