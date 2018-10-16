--WIDOKI

CREATE or REPLACE VIEW "DBA"."bestCarCustomers"()
AS
SELECT K.Nazwisko, K.Imie, count(S.IdSamochodu) 
AS LiczbaKupionychS, sum(S.CenaSamochodu) AS KwotaKupionychS
FROM Klient K
INNER JOIN Faktura F ON K.IdKlienta=F.IdKlienta
INNER JOIN Poz_Faktury PF ON (F.IdFaktury=PF.IdFaktury
AND PF.IdSalonu=F.IdSalonu
AND PF.IdKlienta=F.IdKlienta)
Inner JOIN Samochód S on S.IdSamochodu=PF.IdSamochodu
AND S.IdSalonu=PF.IdSalonu
GROUP BY K.Nazwisko, K.Imie
ORDER BY KwotaKupionychS DESC

CREATE or REPLACE VIEW "DBA"."bestCarProducents"()
AS
SELECT P.NazwaProducenta, K.NazwaKraju, 
sum(S.CenaSamochodu) AS LacznyPrzychod, 
count(S.IdSamochodu) AS LiczbaSprzedanych
FROM Producent P
INNER JOIN Kraj K ON P.IdKraju=K.IdKraju
INNER JOIN Samochód S ON S.IdProducenta=P.IdProducenta
INNER JOIN Poz_Faktury PF ON PF.IdSamochodu=S.IdSamochodu
AND PF.IdSalonu=S.IdSalonu
GROUP BY P.NazwaProducenta, K.NazwaKraju
ORDER BY LacznyPrzychod DESC

CREATE or REPLACE VIEW "DBA"."bestsell"()
AS
SELECT TY.NazwaTypu, A.NazwaAkcesorii, 
count(A.IdAkcesorii) AS LiczbaSprzedanych, 
sum(A.CenaAkcesorii) AS LacznyPrzychod
FROM Akcesoria A
INNER JOIN Poz_Faktury PF ON PF.IdAkcesorii=A.IdAkcesorii
AND PF.Akc_IdSalonu=A.IdSalonu
INNER JOIN Typ TY ON A.IdTypu=TY.IdTypu
GROUP BY A.NazwaAkcesorii, TY.NazwaTypu
ORDER BY LiczbaSprzedanych DESC

CREATE MATERIALIZED VIEW "DBA"."Laczna_wartosc_akcesoriow"
AS
SELECT S.IdSalonu,S.NazwaSalonu,Sum(A.CenaAkcesorii) as Laczna_Wartosc
FROM SalonSamochodowy S INNER JOIN Akcesoria A 
on S.IdSalonu = A.IdSalonu 
GROUP BY S.IdSalonu,S.NazwaSalonu 
ORDER BY Laczna_Wartosc DESC


