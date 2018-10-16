CREATE or REPLACE TRIGGER "trigger1" BEFORE DELETE
ORDER 1 ON "DBA"."Producent"
REFERENCING OLD AS old_name NEW AS new_name 
FOR EACH ROW
BEGIN
IF(EXISTS(SELECT P.IdProducenta FROM Producent P 
              INNER JOIN Samochód S ON S.IdProducenta=P.IdProducenta
                WHERE P.IdProducenta=new_name.IdProducenta))
    THEN
        RAISERROR 30002 'Nie mozna usunac producenta gdy znajduje sie samochód tego producenta w bazie!';
        MESSAGE 'Nie mozna usunac producenta gdy znajduje sie samochód tego producenta w bazie!' TO client
    END IF
END;

CREATE or REPLACE TRIGGER "trigger2" BEFORE DELETE
ORDER 1 ON "DBA"."Typ"
REFERENCING OLD AS old_name NEW AS new_name 
FOR EACH ROW
BEGIN
IF(EXISTS(SELECT TY.IdTypu FROM Typ TY 
              INNER JOIN Akcesoria A ON A.IdTypu=TY.IdTypu
                WHERE TY.IdTypu=new_name.IdTypu))
    THEN
        RAISERROR 30002 'Nie mozna usunac typu gdy znajduje sie akcesoria tego typu w bazie!';
        MESSAGE 'Nie mozna usunac typu gdy znajduje sie akcesoria tego typu w bazie!' TO client
    END IF
END;

CREATE or REPLACE TRIGGER "trigger3" BEFORE DELETE
ORDER 1 ON "DBA"."Samochód"
REFERENCING OLD AS old_name NEW AS new_name 
FOR EACH ROW
BEGIN
IF(EXISTS(SELECT P.IdPozFaktury FROM Poz_Faktury P 
              INNER JOIN Samochód S ON S.IdSamochodu=P.IdSamochodu and S.IdSalonu = p.IdSalonu
                WHERE S.IdSamochodu=new_name.IdProducenta))
    THEN
        RAISERROR 30002 'Nie mozna usunac samochodu gdyż ten samochód jest na pozycji faktury!';
        MESSAGE 'Nie mozna usunac samochodu gdyż ten samochód jest na pozycji faktury!' TO client
    END IF
END;

CREATE or REPLACE TRIGGER "trigger4" Before UPDATE
ORDER 1 ON "DBA"."Poz_Faktury"
/* REFERENCING OLD AS old_name NEW AS new_name */
FOR EACH ROW /* WHEN( search_condition ) */
BEGIN
	IF EXISTS (SELECT P.IdPozFaktury FROM Poz_Faktury P 
              INNER JOIN Samochód S ON S.IdSamochodu=P.IdSamochodu and S.IdSalonu = p.IdSalonu
)
    THEN
        RAISERROR 30002 'Nie mozna zmienić IdSamochodu na fakturze gdyż faktura została wystawiona!';
        MESSAGE 'Samochód sprzedany. Faktura jest już wystawiona!' TO client
    END IF
END;