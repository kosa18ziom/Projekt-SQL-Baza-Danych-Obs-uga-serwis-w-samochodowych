-- View: public."bestCarProducents"

-- DROP VIEW public."bestCarProducents";

CREATE OR REPLACE VIEW public."bestCarProducents" AS 
 SELECT p.nazwaproducenta,
    k.nazwakraju,
    sum(s.cenasamochodu) AS lacznyprzychod,
    count(s.idsamochodu) AS liczbasprzedanych
   FROM producent p
     JOIN kraj k ON p.idkraju = k.idkraju
     JOIN "samochód" s ON s.idproducenta = p.idproducenta
     JOIN poz_faktury pf ON pf.idsamochodu = s.idsamochodu AND pf.idsalonu = s.idsalonu
  GROUP BY p.nazwaproducenta, k.nazwakraju
  ORDER BY (sum(s.cenasamochodu)) DESC;

ALTER TABLE public."bestCarProducents"
  OWNER TO postgres;
