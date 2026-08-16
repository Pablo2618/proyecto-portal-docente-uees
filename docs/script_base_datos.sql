=========================================================================== 
-- BASE DE DATOS: portal_docente_uees 
-- MOTOR: PostgreSQL 14+ 
-- PROYECTO: Examen Primer Periodo 
-- Programación Web (Ciclo II-2026) -- 
===========================================================================


DROP TABLE IF EXISTS calificaciones CASCADE; 
DROP TABLE IF EXISTS matriculas CASCADE; 
DROP TABLE IF EXISTS evaluaciones CASCADE; 
DROP TABLE IF EXISTS grupos CASCADE; 
DROP TABLE IF EXISTS asignaturas CASCADE; 
DROP TABLE IF EXISTS estudiantes CASCADE; 
DROP TABLE IF EXISTS docentes CASCADE; 

CREATE TABLE estudiantes (
--se crea un id para cada alumno aparte del carnet
id_estudiante   SERIAL PRIMARY KEY,
nombre_completo VARCHAR(120)    NOT NULL,
correo          VARCHAR(120)    NOT NULL UNIQUE,
carnet          VARCHAR(15)     NOT NULL UNIQUE,
);

CREATE TABLE docentes (
id_docentes     SERIAL  PRIMARY KEY,
nombre_completo VARCHAR(120)    NOT NULL,
correo          VARCHAR(120)    NOT NULL UNIQUE,
contraseña      VARCHAR(255)    NOT NULL
);

CREATE TABLE asignaturas(
id_asignatura   SERIAL  PRIMARY KEY,
codigo_materia  VARCHAR(20)     NOT NULL UNIQUE,
nombre_materia  VARCHAR(120)    NOT NULL,
);

CREATE TABLE grupos(
id_grupo        SERIAL  PRIMARY KEY,
id_asignatura   INTEGER         NOT NULL REFERENCES asignaturas(id_asignatura) ON DELETE RESTRICT,
id_docentes     INTEGER         NOT NULL REFERENCES docentes(id_docentes) ON DELETE RESTRICT,
periodo         VARCHAR(10)     NOT NULL,
horario         VARCHAR(60),     
);

CREATE TABLE matricula (
id_matricula    SERIAL  PRIMARY KEY,
id_estudiante   INTEGER         NOT NULL REFERENCES estudiantes(id_estudiante) ON DELETE RESTRICT,
id_asignatura   INTEGER         NOT NULL REFERENCES asignaturas(id_asignatura) ON DELETE CASCADE,
id_grupo        INTEGER         NOT NULL REFERENCES grupos(id_grupo) ON DELETE CASCADE,
fecha_matricula TIMESTAMP      NOT NULL DEFAULT NOW(),
);