

CREATE DATABASE bdSIA
USE bdSIA
CREATE TABLE  tblFacultad
(
  Codigo INT PRIMARY KEY NOT NULL,
  Nombre VARCHAR (50) NOT NULL,
  Activo BIT DEFAULT 1
)

CREATE TABLE tblPrograma
(
  Codigo INT PRIMARY KEY NOT NULL,
  idFAC INT NOT NULL,
  Nombre VARCHAR (50) NOT NULL,
  Activo BIT DEFAULT 1 NOT NULL
)

CREATE TABLE tblAsignatura
(
  Codigo INT PRIMARY KEY NOT NULL,
  idPRO INT NOT NULL,
  Nombre VARCHAR (50) NOT NULL,
  Activo BIT DEFAULT 1 NOT NULL
)

CREATE TABLE tblEstudiante
(
  Codigo INT PRIMARY KEY NOT NULL,
  NroDoc INT NOT NULL,
  idTDOC INT NOT NULL,
  Nombre VARCHAR (90) NOT NULL,
  idPRO INT NOT NULL,
  idJOR INT CHECK (idJOR = 1 OR
    idJOR = 2 OR idJOR = 3 OR
	idJOR = 4 OR idJOR = 5) DEFAULT 1,
	Observac VARCHAR (500) NULL,
  Activo BIT DEFAULT 1 NOT NULL
)

CREATE TABLE tblTipoDoc
(
  Codigo INT PRIMARY KEY NOT NULL,
  Nombre VARCHAR (30) NOT NULL,
  Activo BIT DEFAULT 1
)

CREATE TABLE tblJornada
(
  Codigo INT PRIMARY KEY NOT NULL,
  Nombre VARCHAR (15) NOT NULL,
  Activo BIT DEFAULT 1
)

CREATE TABLE tblMatricula
(
  Codigo INT PRIMARY KEY NOT NULL,
  Fecha VARCHAR (12) DEFAULT FORMAT(GETDATE(),'d', 'en-gb'),
  idPER INT NOT NULL,
  idEST INT NOT NULL
)

CREATE TABLE tblDetMat
(
  Codigo INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
  Fecha VARCHAR (12) DEFAULT FORMAT (GETDATE (), 'd', 'en-gb'),
  idMat INT NOT NULL,
  idASI INT NOT NULL
)

CREATE TABLE tblPeriodo
(
  Codigo INT PRIMARY KEY NOT NULL,
  Nombre VARCHAR (30) NOT NULL,
  Activo BIT DEFAULT 1 NOT NULL
)
 

ALTER TABLE tblPrograma ADD FOREIGN KEY (idFAC) REFERENCES tblFacultad (Codigo)
ALTER TABLE tblAsignatura ADD FOREIGN KEY (idPRO) REFERENCES tblPrograma (Codigo)
ALTER TABLE tblEstudiante ADD FOREIGN KEY (idPRO) REFERENCES tblPrograma (Codigo)
ALTER TABLE tblEstudiante ADD FOREIGN KEY (idJOR) REFERENCES tblJornada (Codigo)
ALTER TABLE tblEstudiante ADD FOREIGN KEY (idTDoc) REFERENCES tblTipoDoc(Codigo)
ALTER TABLE tblMatricula ADD FOREIGN KEY (idPER) REFERENCES tblPeriodo (Codigo)
ALTER TABLE tblMatricula ADD FOREIGN KEY (idEST) REFERENCES tblEstudiante (Codigo)
ALTER TABLE tblDetMat ADD FOREIGN KEY (idMat) REFERENCES tblMatricula (Codigo)
ALTER TABLE tblDetMat ADD FOREIGN KEY (idASI) REFERENCES tblAsignatura (Codigo)
  
INSERT INTO tblFacultad VALUES
(1, 'Facultad de Artes y Humanidades', 1 ),
(2, 'Ciencias Económicas y Administraticas',1), (3, 'Ciencias Exactas y Aplicadas', 1),
(4, 'Ingenieras',1);

INSERT INTO tblPrograma VALUES 
(10,1, 'Tecnología en Informática Musical', 1),
(40,2, 'Tecnología en Gestión Administrativa', 1),
(70,3, 'Química Industrial', 1),
(100,4, 'Tecn. Desarrollo de Software', 1),
(11,1, 'Ingeniería en Diseño Industrial', 1),
(41,2, 'Ingeniería Financiera', 1),
(71,3, 'Ingeniería Biomédica', 1),
(101,4, 'Ing. de Sistemas', 1);

INSERT INTO tblAsignatura VALUES 
(10100, 10, 'Lenguaje musical ', 1),
(10102, 10, 'Negocios en la industria musical', 1),
(10101, 10, 'Entrenamiento Auditivo y Armonía I', 1),
(11100, 11, 'Planimetría Dibujo Técnico', 1),
(11102, 11, 'Representación CAD 3D', 1),
(11101, 11, 'Materiales Industriales', 1),
(40100, 40, 'Fundamentos de Administración', 1),
(40101, 40, 'Costos y Presupuestos', 1),
(40102, 40, 'Administración Financiera', 1),
(41100, 41, 'Fundamentos de Costos', 1),
(41102, 41, 'Hacienda y Presupuesto Público', 1),
(41101, 41, 'Sistemas de Costeo Tradicional', 1),
(70100, 70, 'Química General', 1),
(70101, 70, 'Química Orgánica', 1),
(70102, 70, 'Fisicoquímica', 1),
(71100, 71, 'Anatomía y Fisiología I', 1),
(71101, 71, 'Señales y Sistemas', 1),
(71102, 71, 'Fisiopatología Clínica', 1),
(100100, 100, 'Lógica de Programación y lab I', 1),
(100101, 100, 'Estructura de Datos y lab', 1),
(101100, 101, 'Programación Distribuida', 1),
(100102, 100, 'Desarrollo Software', 1),
(101101, 101, 'Arquitectura de Computadores', 1),
(101102, 101, 'Visión Artificial', 1);

INSERT INTO tblTipoDoc VALUES 
(1, 'Cédula de Ciudadanía', 1), 
(3, 'Cédula de Extranjería', 1), 
(6, 'Pasaporte', 1), 
(7, 'Tarjeta de Identidad', 1), 
(8, 'Registro Civil', 1);

INSERT INTO tblPeriodo VALUES 
(58, '2025-1', 1),
(59, '2025-2', 1),
(60, '2026-1', 0),
(61, '2026-2', 0);

INSERT INTO tblJornada VALUES 
(1, 'Mañana', 1),
(2, 'Tarde', 1),
(3, 'Noche', 1),
(4, 'Única', 1),
(5, 'Virtual', 1);

INSERT INTO tblEstudiante VALUES
(30001, 10001000, 7, 'Juan P. Aristizábal', 10, 1, 'Ppto Particip', 1),
(30002, 10001001, 8, 'Mario A. Martínez', 10, 4, 'Fondo EPM', 1),
(30003, 10001002, 1, 'Natalia Castrillón', 11, 3, '', 1),
(30004, 10001003, 1, 'Rubén Soto.', 11, 1, 'Pruebas de todo', 1),
(30005, 10001004, 6, 'Scott Ragun', 40, 1, 'Reserva', 1),
(30006, 10001005, 8, 'Jazmín Angarita', 40, 4, 'Ppto Particip.', 1),
(30007, 10001006, 7, 'José Soto Diaz', 41, 1, 'Suspend Matric', 1),
(30008, 10001007, 1, 'Juan Toro L', 41, 3, 'Beca Sapiencia', 1),
(30009, 10001008, 1, 'María A. Zapata Rico', 70, 2, '', 1),
(30010, 10001009, 8, 'Ana M. Cardona A.', 70, 5, 'Hija Docente', 1),
(30011, 10001010, 1, 'Gloria Aguirre', 71, 2, 'Sordo', 1),
(30012, 10001011, 1, 'Rut Hernandez', 71, 4, '', 1),
(30013, 10001012, 7, 'Pedro Gómez', 100, 1, 'Matricula Cero', 1),
(30014, 10001013, 3, 'Helmond Strauss', 100, 3, 'Ppto. Particip.', 1),
(30015, 10001014, 8, 'Cristina Zapata', 101, 2, '', 1),
(30016, 10001015, 1, 'Yuliana Cardona', 101, 5, '', 1);

INSERT INTO tblMatricula VALUES 
(1, FORMAT(GETDATE(), 'd', 'en-gb'), 59, 30001);

INSERT INTO tblDetMat VALUES 
(FORMAT(GETDATE(), 'd', 'en-gb'), 1, 10101);

SELECT * FROM tblFacultad
SELECT * FROM tblPrograma
SELECT * FROM tblAsignatura
SELECT * FROM tblPeriodo
SELECT * FROM tblJornada
SELECT * FROM tblTipoDoc
SELECT * FROM tblEstudiante
SELECT * FROM tblMatricula
SELECT * FROM tblDetMat








