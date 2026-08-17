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
carnet          VARCHAR(15)     NOT NULL UNIQUE
);

CREATE TABLE docentes (
--al igual que con los estudiantes, los docentes tienen un id aparte de su codigo de docente
id_docentes     SERIAL  PRIMARY KEY,
codigo_docente	VARCHAR(9)		NOT NULL UNIQUE,
nombre_completo VARCHAR(120)    NOT NULL,
correo          VARCHAR(120)    NOT NULL UNIQUE,
contrasena      VARCHAR(255)    NOT NULL
);

CREATE TABLE asignaturas(
id_asignatura   SERIAL  PRIMARY KEY,
codigo_materia  VARCHAR(20)     NOT NULL UNIQUE,
nombre_materia  VARCHAR(120)    NOT NULL
);

CREATE TABLE grupos(
id_grupo        SERIAL  PRIMARY KEY,
--se usa RESTRICT porque los grupos dependen de una asignatura y de un docente
id_asignatura   INTEGER         NOT NULL REFERENCES asignaturas(id_asignatura) ON DELETE RESTRICT,
id_docentes     INTEGER         NOT NULL REFERENCES docentes(id_docentes) ON DELETE RESTRICT,
codigo_grupo	VARCHAR(10)		NOT NULL,
ciclo         VARCHAR(10)     NOT NULL,
horario         VARCHAR(60)    
);

CREATE TABLE evaluaciones(
--se usa CASCADE para que se elimine en caso se elimine el grupo, tambien la evaluacion
id_evaluacion   SERIAL PRIMARY KEY,
id_grupo    INTEGER     NOT NULL REFERENCES grupos(id_grupo) ON DELETE CASCADE,
nombre_evaluacion   VARCHAR(120)    NOT NULL,
--en NUMERIC los numeros 5,2 son de la cantidad de digitos y cantidad de decimales que puede tener el valor respectivamente
ponderacion     NUMERIC(5,2)    NOT NULL CHECK (ponderacion > 0 AND ponderacion <=100)
);

CREATE TABLE matriculas (
--RESTRICT en estudiante ya que la matricula depende del estudiante
--Cascade en grupo ya que no depende del grupo, si no existe se elimina la matricula relacionada al grupo
id_matricula    SERIAL  PRIMARY KEY,
id_estudiante   INTEGER         NOT NULL REFERENCES estudiantes(id_estudiante) ON DELETE RESTRICT,
id_grupo        INTEGER         NOT NULL REFERENCES grupos(id_grupo) ON DELETE CASCADE,
fecha_matricula TIMESTAMP      NOT NULL DEFAULT NOW()
);

CREATE TABLE calificaciones (
--se usa CASCADE en ambos porque si no hay evaluacion ni matricula no hay calificacion
id_calificacion SERIAL	PRIMARY KEY,
id_matricula	INTEGER NOT NULL REFERENCES matriculas(id_matricula) ON DELETE CASCADE,
id_evaluacion	INTEGER NOT NULL REFERENCES evaluaciones(id_evaluacion) ON DELETE CASCADE,
nota			NUMERIC(4,2) NOT NULL CHECK (nota >= 0 AND nota <= 10.00),
registrado		TIMESTAMP	NOT NULL DEFAULT NOW(),
--se usa unique para que no se asigne otra calificacion para la misma matricula
UNIQUE	(id_matricula, id_evaluacion)
);


INSERT INTO estudiantes (nombre_completo, correo, carnet) VALUES
('Pablo Alberto Castillo Martinez', '2025010206@cvirtualuees.edu.sv', '2025010206'),
('Jose Mariano Argueta Bonilla', '2025010517@cvirtualuees.edu.sv', '2025010517'),
('Marco Alejandro Reyes Torres', '2025010359@cvirtualuees.edu.sv', '2025010359');

INSERT INTO docentes (codigo_docente, nombre_completo, correo, contrasena) VALUES
('053505130', 'Ricardo Ernesto Alvarado Martinez', 'correoprueba@cvirtualuees.edu.sv', 'prueba_123');

INSERT INTO asignaturas (codigo_materia, nombre_materia) VALUES
('PWEB', 'Programacion Web');

INSERT INTO grupos (id_asignatura, id_docentes, codigo_grupo, ciclo, horario) VALUES
(1, 1, 'GP1', 'II-2026', 'Lunes 6:00-8:00 PM');

INSERT INTO evaluaciones(id_grupo, nombre_evaluacion, ponderacion) VALUES
(1, 'Examen primer periodo', 30.00);

INSERT INTO matriculas(id_estudiante, id_grupo) VALUES
(1, 1),
(2, 1),
(3, 1);

INSERT INTO calificaciones (id_matricula, id_evaluacion, nota) VALUES
(1, 1, 0.20),
(2, 1, 7.43),
(3, 1, 9.82);