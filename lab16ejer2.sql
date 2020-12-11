USE uni_proyectos;

/*Reciba el código de un profesor y muestre, el nombre del profesor, código(s) del(os) alumno(s) y nombre(s)
del(os) alumno(s) del cual el profesor es tutor.*/

DELIMITER //
DROP PROCEDURE IF EXISTS mostrar_profesor //
CREATE PROCEDURE mostrar_profesor(IN cod_prof INTEGER)
BEGIN
	SELECT CONCAT(per1.nombres, ' ', per1.apell_pat, ' ', per1.apell_mat) 'Profesor',  per2.DNI 'Cód, Alumno',
    CONCAT(per2.nombres,' ', per2.apell_pat,' ', per2.apell_mat) 'Alumno'
    FROM profesor pro
    INNER JOIN persona per1 ON per1.DNI = pro.DNI
    INNER JOIN becario bec ON bec.tutor_DNI = pro.DNI
    INNER JOIN alumno al ON al.DNI = bec.DNI
    INNER JOIN persona per2 on per2.DNI = al.DNI
    WHERE pro.DNI  = cod_prof;
END;//
DELIMITER //;

CALL mostrar_profesor(29889537);

/*Reciba el código del proyecto y muestre, el código y nombre del profesor que es investigador principal.*/
DELIMITER //
DROP PROCEDURE IF EXISTS mostrar_proyecto //
CREATE PROCEDURE mostrar_proyecto(IN cod_proy INTEGER)
BEGIN
	SELECT pro.cod_proyecto 'Cod. Proyecto', prof.DNI 'Cod. Investigador',
    CONCAT(per.nombres, ' ', per.apell_pat, ' ', per.apell_mat) 'Nombre Investigador'
    FROM proyecto pro
    INNER JOIN profesor prof ON prof.DNI = pro.inv_princ_DNI
    INNER JOIN persona per ON per.DNI = prof.DNI
    WHERE pro.cod_proyecto = cod_proy;
END;//
DELIMITER //;

CALL mostrar_proyecto(2);

/*Reciba el código del alumno no becario y muestre, la pensión que debe pagar.*/
DELIMITER //
DROP PROCEDURE IF EXISTS mostrar_no_becario //
CREATE PROCEDURE mostrar_no_becario(IN cod_no_bec INTEGER)
BEGIN
	SELECT nb.DNI 'Cód. No becario', nb.pension 'Pensión'
    FROM no_becario nb
    WHERE nb.DNI  = cod_no_bec;
END;//
DELIMITER //;

CALL mostrar_no_becario(37863238);