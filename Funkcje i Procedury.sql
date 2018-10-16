CREATE or REPLACE PROCEDURE "DBA"."CarsSold"( idS int )
RESULT( IdSalonu int, nazwa_salonu varchar(50), 
marka_samochodu varchar(50),model_samochodu varchar(50), cena_samochodu double)
BEGIN
SELECT SS.IdSalonu, SS.NazwaSalonu, P.NazwaProducenta, S.Model, S.CenaSamochodu
    FROM Samochód S INNER JOIN Producent P 
    ON P.IdProducenta=S.IdProducenta
    INNER JOIN SalonSamochodowy SS ON SS.IdSalonu=S.IdSalonu
    inner join Poz_Faktury pf on pf.IdSamochodu = S.IdSamochodu 
    and pf.IdSalonu = SS.IdSalonu
    WHERE SS.IdSalonu=idS
END;
-------------------------
CREATE or REPLACE FUNCTION "DBA"."HowManyCars"( in "nazwaMarki" varchar(30) )
RETURNS INTEGER
DETERMINISTIC
BEGIN
DECLARE "ilosc_aut" INTEGER;
SET ilosc_aut = (select count(*)  
from Producent p
inner join Samochód s on s.IdProducenta = p.IdProducenta
inner join SalonSamochodowy ss on ss.IdSalonu = s.IdSalonu
inner join Poz_Faktury pf on pf.IdSamochodu = s.IdSamochodu and pf.IdSalonu = ss.IdSalonu
where p.NazwaProducenta ="nazwaMarki"
);
RETURN "ilosc_aut";
END;
--------------------------
CREATE or REPLACE PROCEDURE "DBA"."nowyA"( IN idP int, idTy int, nazwaA varchar(50) , cenaA double
/* [IN | OUT | INOUT] parameter_name parameter_type [DEFAULT default_value], ... */ )
/* RESULT( column_name column_type, ... ) */
BEGIN
	DECLARE kursor CURSOR FOR (SELECT NazwaAkcesorii FROM Akcesoria);
    DECLARE kursorS CURSOR FOR (SELECT IdSalonu FROM SalonSamochodowy);
    DECLARE idS int;
    DECLARE j int;
    DECLARE nAkcesorii varchar(100);    
    DECLARE tmp int;
    DECLARE nrA int;
    DECLARE i int;
    SET i=1;
    SET j=1;

    SET tmp=0;

    OPEN kursor;
    petla: LOOP
        FETCH NEXT kursor INTO nAkcesorii;
        SET i=i+1;
        SET tmp=0;

        IF(nAkcesorii=nazwaA) THEN LEAVE petla;
        ELSE 
            SET tmp=1;
        END IF;

        IF(i>(SELECT count(*) FROM Akcesoria)) THEN LEAVE petla;
        END IF;
    END LOOP;
    CLOSE kursor;
    
    SET nrA=(SELECT max(IdAkcesorii) FROM Akcesoria);
    SET nrA= nrA + 1;

    OPEN kursorS;
    petla2: LOOP
        FETCH NEXT kursorS INTO idS;
        INSERT INTO Akcesoria(IdAkcesorii, IdProducenta, IdTypu, NazwaAkcesorii, CenaAkcesorii, IdSalonu)
            VALUES(nrA, idP, idTy, nazwaA , cenaA, j);
        SET j=j+1;
        IF(j>(SELECT count(*) FROM SalonSamochodowy)) THEN LEAVE petla2;
        END IF;
    END LOOP;
    CLOSE kursorS;

    IF(tmp=1) THEN 
        COMMIT;
        MESSAGE 'Towar dodany do bazy danych.' TO client
    ELSE 
        ROLLBACK;
        MESSAGE 'towar NIE dodany do bazy danych, poniewaz inny towar o takiej samej nazwie znajduje sie w bazie!' TO client
    END IF;
REFRESH MATERIALIZED VIEW Laczna_wartosc_akcesoriow;
END;
-------------------
CREATE or REPLACE FUNCTION "DBA"."nowyP"( IN nazwaP varchar(30), nazwaK varchar(30)
/* @parameter_name parameter_type [= default_value], ... */ )
RETURNS BIGINT
AS
BEGIN
DECLARE @idP BIGINT
DECLARE @kursor CURSOR FOR (SELECT NazwaProducenta FROM Producent)
    DECLARE @tmp int
    DECLARE @producentN varchar(50)
    DECLARE @idK int
    DECLARE @i integer

    BEGIN TRAN tra

    SET @i=1
    OPEN kursor
    WHILE (@i<(SELECT count(*) FROM Producent))
    BEGIN
        FETCH NEXT kursor INTO @producentN

        SET @tmp=1

        IF(@producentN=@nazwaP)
            SET @tmp=0

         IF(@producentN=@nazwaP)
            SET @i=(SELECT count(*) FROM Producent)

        SET @i=@i+1
    END

    SET @idK = (SELECT idKraju FROM Kraj K 
                WHERE K.NazwaKraju=nazwaK)

    SET @idP=(SELECT max(idProducenta) FROM Producent)
    SET @idP=@idP+1

    INSERT INTO Producent VALUES(@idP, @idK, @nazwaP)

    IF(@tmp=1) COMMIT TRAN tra
    ELSE
    BEGIN
        ROLLBACK TRAN tra
        SET @idP=0
    END
RETURN @idP
END;
--------------------------
CREATE or REPLACE FUNCTION "DBA"."przychod"( IN ids INT)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE "wynik" DOUBLE;
    DECLARE "zmienna1" DOUBLE;
    DECLARE "zmienna2" DOUBLE;
    SET zmienna1 = (SELECT sum(A.CenaAkcesorii)
                    FROM Poz_Faktury PF JOIN Akcesoria A 
                    ON A.IdSalonu=PF.Akc_IdSalonu 
                    AND A.IdAkcesorii=PF.IdAkcesorii
                    WHERE PF.Akc_IdSalonu=ids);
    SET zmienna2 = (SELECT sum(S.CenaSamochodu)
                    FROM Poz_Faktury PF JOIN Samochód S  
                    ON S.IdSamochodu=PF.IdSamochodu
                    AND S.IdSalonu=PF.IdSalonu
                    WHERE PF.IdSalonu=ids);          
SET wynik = coalesce(zmienna1 + zmienna2, zmienna1,zmienna2);
RETURN "wynik";
END;
-------------------------
CREATE or REPLACE PROCEDURE "DBA"."towaryKlienta"( IN imieK varchar(30), nazwiskoK varchar(30))
 RESULT( Marka varchar(50), nazwa_towaru varchar(50), cena_towaru double )
BEGIN
SELECT P.NazwaProducenta, A.NazwaAkcesorii, A.CenaAkcesorii
    FROM Producent P INNER JOIN Akcesoria A on P.IdProducenta=A.IdProducenta
    INNER JOIN Poz_Faktury PF
    ON PF.IdAkcesorii=A.IdAkcesorii AND PF.Akc_IdSalonu=A.IdSalonu
    INNER JOIN Klient K ON K.IdKlienta=PF.IdKlienta
    WHERE K.Imie=imieK AND K.Nazwisko=nazwiskoK
    
    UNION

    SELECT P.NazwaProducenta, S.Model, S.CenaSamochodu
    FROM Producent P INNER JOIN Samochód S on P.IdProducenta=S.IdProducenta
    INNER JOIN Poz_Faktury PF
    ON PF.IdSamochodu=S.IdSamochodu AND PF.IdSalonu=S.IdSalonu
    INNER JOIN Klient K ON K.IdKlienta=PF.IdKlienta
    WHERE K.Imie=imieK AND K.Nazwisko=nazwiskoK
END;
-----------------------
CREATE or REPLACE PROCEDURE "DBA"."wysAkcesoria"( IN typT varchar(50), idS int )
RESULT( nazwa_towaru varchar(50), producent_towaru varchar(50), cena_towaru double)
BEGIN
SELECT A.NazwaAkcesorii, P.NazwaProducenta, A.CenaAkcesorii
    FROM Akcesoria A INNER JOIN Producent P 
    ON P.IdProducenta=A.IdProducenta
    INNER JOIN Typ TY ON TY.IdTypu=A.IdTypu
    WHERE TY.NazwaTypu=typT
    AND A.IdSalonu=ids
END;
-----------------------
CREATE or REPLACE FUNCTION "DBA"."wystawcy"( IN imie varchar(30), nazwisko varchar(30))
RETURNS BIGINT
DETERMINISTIC
BEGIN
   DECLARE "wynik" BIGINT;	
    SET wynik= (SELECT count(*) FROM Faktura F 
                        INNER JOIN Pracownik P ON F.idSalonu=P.idSalonu
                        AND F.idPracownika=P.idPracownika
                        WHERE P.Imie = imie
                        AND P.Nazwisko = nazwisko);

RETURN "wynik";
END;