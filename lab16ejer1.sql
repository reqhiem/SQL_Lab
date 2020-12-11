USE sistema_hotel;

/*Reciba el código de un departamento y muestre el nombre del departamento y nombre de los hoteles que se encuentren
en ese departamento.*/

DELIMITER //
DROP PROCEDURE IF EXISTS mostrar_departamento //
CREATE PROCEDURE mostrar_departamento (IN cod_dep INTEGER)
BEGIN
	SELECT d.nombre 'Nombre Departamento', h.nombre 'Nombre Hotel'
    FROM departamento d
    INNER JOIN hotel h ON d.id_departamento = h.departamento
    WHERE d.id_departamento = cod_dep;
END; //
DELIMITER //

CALL mostrar_departamento(3);

/*Reciba el DNI de un cliente nacional y  muestre
nombre del cliente, hotel(es) y cuarto(s) que reservó.*/

DELIMITER //
DROP PROCEDURE IF EXISTS mostrar_nacional //
CREATE PROCEDURE mostrar_nacional(IN dni_cliente VARCHAR(45))
BEGIN
	SELECT CONCAT(cli.nombres, ' ', cli.apell_pat, ' ', cli.apell_mat) 'Huesped', hot.nombre 'Hotel', 
    CONCAT(cua.piso,cua.numero) 'Cuarto'
    FROM huesped cli
    INNER JOIN nacional na ON cli.cod_huesped = na.cod_huesped
    INNER JOIN huesped_reserva hr ON hr.cod_huesped = cli.cod_huesped
    INNER JOIN reserva res ON hr.cod_reserva = res.cod_reserva
    INNER JOIN reserva_cuarto rc ON rc.cod_reserva = res.cod_reserva
    INNER JOIN cuarto cua ON (rc.cuarto_piso = cua.piso AND rc.cuarto_numero = cua.numero)
    INNER JOIN hotel hot ON cua.cod_hotel = hot.cod_hotel
    WHERE na.DNI = dni_cliente;
END; //
DELIMITER //

CALL mostrar_nacional(78923423)

/*Reciba el pasaporte de un cliente internacional y nombre del cliente, hotel(es) y cuarto(s) que alquiló.*/
DELIMITER //
DROP PROCEDURE IF EXISTS mostrar_extranjero //
CREATE PROCEDURE mostrar_extranjero(IN pasaporte VARCHAR(45))
BEGIN
	SELECT CONCAT(cli.nombres, ' ', cli.apell_pat, ' ', cli.apell_mat) 'Huesped', hot.nombre 'Hotel', 
    CONCAT(cua.piso,cua.numero) 'Cuarto'
    FROM huesped cli
    INNER JOIN extranjero ex ON cli.cod_huesped = ex.cod_huesped
    INNER JOIN huesped_reserva hr ON hr.cod_huesped = cli.cod_huesped
    INNER JOIN reserva res ON hr.cod_reserva = res.cod_reserva
    INNER JOIN reserva_cuarto rc ON rc.cod_reserva = res.cod_reserva
    INNER JOIN cuarto cua ON (rc.cuarto_piso = cua.piso AND rc.cuarto_numero = cua.numero)
    INNER JOIN hotel hot ON cua.cod_hotel = hot.cod_hotel
    WHERE ex.pasaporte = pasaporte;
END; //
DELIMITER //

CALL mostrar_extranjero(65463456);

SELECT * FROM nacional;