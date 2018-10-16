DROP VIEW if exists "DBA"."bestCarCustomers";
DROP VIEW if exists "DBA"."bestCarProducents";
DROP VIEW if exists "DBA"."bestsell";
DROP MATERIALIZED VIEW if exists "DBA"."Laczna_wartosc_akcesoriow"
DROP TRIGGER if exists "trigger1";
DROP TRIGGER if exists "trigger2";
DROP TRIGGER if exists "trigger3";
DROP TRIGGER if exists "trigger4";
DROP PROCEDURE if exists "DBA"."CarsSold";
DROP PROCEDURE if exists "DBA"."nowyA";
DROP PROCEDURE if exists "DBA"."towaryKlienta";
DROP PROCEDURE if exists "DBA"."wysAkcesoria";
DROP FUNCTION if exists "DBA"."HowManyCars";
DROP FUNCTION if exists "DBA"."nowyP";
DROP FUNCTION if exists "DBA"."przychod";
DROP FUNCTION if exists "DBA"."wystawcy";
if exists(select 1 from sys.sysforeignkey where role='FK_AKCESORI_AKCESORIA_SALONSAM') then
    alter table Akcesoria
       delete foreign key FK_AKCESORI_AKCESORIA_SALONSAM
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_AKCESORI_PRODUCENT_PRODUCEN') then
    alter table Akcesoria
       delete foreign key FK_AKCESORI_PRODUCENT_PRODUCEN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_AKCESORI_TYP_AKCES_TYP') then
    alter table Akcesoria
       delete foreign key FK_AKCESORI_TYP_AKCES_TYP
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_FAKTURA_ODBIERAJA_KLIENT') then
    alter table Faktura
       delete foreign key FK_FAKTURA_ODBIERAJA_KLIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_FAKTURA_WYSTAWIAJ_PRACOWNI') then
    alter table Faktura
       delete foreign key FK_FAKTURA_WYSTAWIAJ_PRACOWNI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_POZ_FAKT_AKCESORIA_AKCESORI') then
    alter table Poz_Faktury
       delete foreign key FK_POZ_FAKT_AKCESORIA_AKCESORI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_POZ_FAKT_POZYCJA_N_FAKTURA') then
    alter table Poz_Faktury
       delete foreign key FK_POZ_FAKT_POZYCJA_N_FAKTURA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_POZ_FAKT_SAMOCHOD__SAMOCHÓD') then
    alter table Poz_Faktury
       delete foreign key FK_POZ_FAKT_SAMOCHOD__SAMOCHÓD
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PRACOWNI_PRACOWNIK_SALONSAM') then
    alter table Pracownik
       delete foreign key FK_PRACOWNI_PRACOWNIK_SALONSAM
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PRODUCEN_KRAJ_PROD_KRAJ') then
    alter table Producent
       delete foreign key FK_PRODUCEN_KRAJ_PROD_KRAJ
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SAMOCHÓD_PRODUCENT_PRODUCEN') then
    alter table Samochód
       delete foreign key FK_SAMOCHÓD_PRODUCENT_PRODUCEN
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SAMOCHÓD_SAMOCHODY_SALONSAM') then
    alter table Samochód
       delete foreign key FK_SAMOCHÓD_SAMOCHODY_SALONSAM
end if;

drop index if exists Akcesoria.Akcesoria_w_salonie_FK;

drop index if exists Akcesoria.Typ_Akcesoriów_FK;

drop index if exists Akcesoria.Producent_Akcesoriów_FK;

drop index if exists Akcesoria.Akcesoria_PK;

drop table if exists Akcesoria;

drop index if exists Faktura.Wystawiajacy_Fakture_FK;

drop index if exists Faktura.Odbierajacy_fakture_FK;

drop index if exists Faktura.Faktura_PK;

drop table if exists Faktura;

drop index if exists Klient.Klient_PK;

drop table if exists Klient;

drop index if exists Kraj.Kraj_PK;

drop table if exists Kraj;

drop index if exists Poz_Faktury.Samochod_Pozycji_Faktury_FK;

drop index if exists Poz_Faktury.Pozycja_na_fakturze_FK;

drop index if exists Poz_Faktury.Akcesoria_pozycji_faktury_FK;

drop index if exists Poz_Faktury.Poz_Faktury_PK;

drop table if exists Poz_Faktury;

drop index if exists Pracownik.Pracownik_Salonu_FK;

drop index if exists Pracownik.Pracownik_PK;

drop table if exists Pracownik;

drop index if exists Producent.Kraj_Producenta_FK;

drop index if exists Producent.Producent_PK;

drop table if exists Producent;

drop index if exists SalonSamochodowy.SalonSamochodowy_PK;

drop table if exists SalonSamochodowy;

drop index if exists Samochód.Samochody_W_Salonie_FK;

drop index if exists Samochód.Producent_Pojazdu_FK;

drop index if exists Samochód.Samochód_PK;

drop table if exists Samochód;

drop index if exists Typ.Typ_PK;

drop table if exists Typ;