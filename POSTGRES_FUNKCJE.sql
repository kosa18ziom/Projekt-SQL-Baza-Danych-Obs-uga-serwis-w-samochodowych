

-- Function: public.przychod(integer)

-- DROP FUNCTION public.przychod(integer);

CREATE OR REPLACE FUNCTION public.przychod(ids integer)
  RETURNS double precision AS
$BODY$

    DECLARE "wynik" DOUBLE PRECISION;
    "zmienna1" DOUBLE PRECISION;
    "zmienna2" DOUBLE PRECISION;
BEGIN
      SELECT sum(A.CenaAkcesorii)
                    FROM Poz_Faktury PF JOIN Akcesoria A 
                    ON A.IdSalonu=PF.Akc_IdSalonu 
                    AND A.IdAkcesorii=PF.IdAkcesorii
                    WHERE PF.Akc_IdSalonu=ids into "zmienna1";
     SELECT sum(S.CenaSamochodu)
                    FROM Poz_Faktury PF JOIN Samochód S  
                    ON S.IdSamochodu=PF.IdSamochodu
                    AND S.IdSalonu=PF.IdSalonu
                    WHERE PF.IdSalonu=ids into "zmienna2";       
wynik := coalesce("zmienna1" + "zmienna2", "zmienna1","zmienna2");
RETURN "wynik";
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.przychod(integer)
  OWNER TO postgres;


  -- Function: public."towaryKlienta"(character varying, character varying)

-- DROP FUNCTION public."towaryKlienta"(character varying, character varying);

CREATE OR REPLACE FUNCTION public."towaryKlienta"(
    imiek character varying,
    nazwiskok character varying)
  RETURNS void AS
$BODY$
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
    WHERE K.Imie=imieK AND K.Nazwisko=nazwiskoK;
END;
--$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public."towaryKlienta"(character varying, character varying)
  OWNER TO postgres;
