/*==============================================================*/
/* DBMS name:      SAP SQL Anywhere 16                          */
/* Created on:     2017-01-19 15:13:59                          */
/*==============================================================*/
if exists(select 1 from sys.syssequence s
   where sequence_name='SEQ_PRODUCENT') then
      drop sequence SEQ_PRODUCENT
end if;
if exists(select 1 from sys.syssequence s
   where sequence_name='SEQ_Kraj') then
      drop sequence SEQ_Kraj
end if;
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

/*==============================================================*/
/* Table: Akcesoria                                             */
/*==============================================================*/
create table Akcesoria 
(
   IdSalonu             integer                        not null,
   IdAkcesorii          integer                        not null,
   IdTypu               integer                        null,
   IdProducenta         integer                        null,
   NazwaAkcesorii       varchar(50)                    not null,
   CenaAkcesorii        numeric(15,2)                  not null,
   constraint PK_AKCESORIA primary key  (IdSalonu, IdAkcesorii)
);

comment on table Akcesoria is 
'Akcesoria do samochodu np. Oleje, Wycieraczki, Ko³a
';

comment on column Akcesoria.IdSalonu is 
'Identyfikator salonu';

comment on column Akcesoria.IdAkcesorii is 
'identyfikator akcesorii';

comment on column Akcesoria.IdTypu is 
'Identyfikator Typu
';

comment on column Akcesoria.IdProducenta is 
'identyfikator producenta
';

comment on column Akcesoria.NazwaAkcesorii is 
'nazwa akcesorii nadana przez producenta. ';

comment on column Akcesoria.CenaAkcesorii is 
'cena kupna akcesorii w salonie';

/*==============================================================*/
/* Index: Akcesoria_PK                                          */
/*==============================================================*/
create unique  index Akcesoria_PK on Akcesoria (
IdSalonu ASC,
IdAkcesorii ASC
);

/*==============================================================*/
/* Index: Producent_Akcesoriów_FK                               */
/*==============================================================*/
create index Producent_Akcesoriów_FK on Akcesoria (
IdProducenta ASC
);

/*==============================================================*/
/* Index: Typ_Akcesoriów_FK                                     */
/*==============================================================*/
create index Typ_Akcesoriów_FK on Akcesoria (
IdTypu ASC
);

/*==============================================================*/
/* Index: Akcesoria_w_salonie_FK                                */
/*==============================================================*/
create index Akcesoria_w_salonie_FK on Akcesoria (
IdSalonu ASC
);

/*==============================================================*/
/* Table: Faktura                                               */
/*==============================================================*/
create table Faktura 
(
   IdKlienta            integer                        not null,
   IdFaktury            integer                        not null,
   IdSalonu             integer                        not null,
   IdPracownika         integer                        not null,
   DataWystawienia      date                           null,
   constraint PK_FAKTURA primary key  (IdKlienta, IdFaktury)
);

comment on table Faktura is 
'jest to dokument zakupu towaru lub towarów w salonie';

comment on column Faktura.IdKlienta is 
'identyfikator klienta';

comment on column Faktura.IdFaktury is 
'identyfikator faktury';

comment on column Faktura.IdSalonu is 
'Identyfikator salonu';

comment on column Faktura.IdPracownika is 
'identyfikator pracownika';

comment on column Faktura.DataWystawienia is 
'data wystawienia faktury';

/*==============================================================*/
/* Index: Faktura_PK                                            */
/*==============================================================*/
create unique  index Faktura_PK on Faktura (
IdKlienta ASC,
IdFaktury ASC
);

/*==============================================================*/
/* Index: Odbierajacy_fakture_FK                                */
/*==============================================================*/
create index Odbierajacy_fakture_FK on Faktura (
IdKlienta ASC
);

/*==============================================================*/
/* Index: Wystawiajacy_Fakture_FK                               */
/*==============================================================*/
create index Wystawiajacy_Fakture_FK on Faktura (
IdSalonu ASC,
IdPracownika ASC
);

/*==============================================================*/
/* Table: Klient                                                */
/*==============================================================*/
create table Klient 
(
   IdKlienta            integer                        not null,
   Imie                 varchar(30)                    not null,
   Nazwisko             varchar(30)                    not null,
   KodPocztowy          varchar(6)                     null,
   Poczta               varchar(40)                    null,
   Ulica                varchar(40)                    null,
   NrDomu               varchar(10)                    null,
   constraint PK_KLIENT primary key  (IdKlienta)
);

comment on table Klient is 
'jest to osoba kupuj¹ca towary w salonie';

comment on column Klient.IdKlienta is 
'identyfikator klienta';

comment on column Klient.Imie is 
'imie danej osoby';

comment on column Klient.Nazwisko is 
'nazwisko danej osoby';

comment on column Klient.KodPocztowy is 
'kod pocztowy miejsca zamieszkania danej osoby lub po³o¿enia salonu samochodowego';

comment on column Klient.Poczta is 
'nazwa miejscowoœci w ktorej znajduje sie poczta do ktorej nalezy dana osoba';

comment on column Klient.Ulica is 
'ulica na ktorej znajduje sie salon lub mieszka osoba';

comment on column Klient.NrDomu is 
'numerr domu w którym mieszka dana osoba';

/*==============================================================*/
/* Index: Klient_PK                                             */
/*==============================================================*/
create unique  index Klient_PK on Klient (
IdKlienta ASC
);
/*==============================================================*/
/* Sequence: SEQ_Kraj										*/
/*==============================================================*/
CREATE SEQUENCE SEQ_Kraj START WITH 1 INCREMENT BY 1 MINVALUE 1 ;
/*==============================================================*/
/* Table: Kraj                                                  */
/*==============================================================*/
create table Kraj 
(
   IdKraju              integer DEFAULT (SEQ_Kraj.nextval)  not null,
   NazwaKraju           varchar(30)                    not null,
   constraint PK_KRAJ primary key  (IdKraju)
);

comment on table Kraj is 
'Kraj pochodzenia producenta
';

comment on column Kraj.IdKraju is 
'identyfikator kraju';

comment on column Kraj.NazwaKraju is 
'U¿ywana nazwa kraju';

/*==============================================================*/
/* Index: Kraj_PK                                               */
/*==============================================================*/
create unique  index Kraj_PK on Kraj (
IdKraju ASC
);

/*==============================================================*/
/* Table: Poz_Faktury                                           */
/*==============================================================*/
create table Poz_Faktury 
(
   IdKlienta            integer                        not null,
   IdFaktury            integer                        not null,
   IdPozFaktury         integer                        not null,
   IdSalonu             integer                        null,
   IdSamochodu          integer                        null,
   Akc_IdSalonu         integer                        null,
   IdAkcesorii          integer                        null,
   constraint PK_POZ_FAKTURY primary key  (IdKlienta, IdFaktury, IdPozFaktury)
);

comment on table Poz_Faktury is 
'jest to pozycja faktury oznaczajace jeden z akcesoriów lub samochodów znajduj¹cych sie na fakturze';

comment on column Poz_Faktury.IdKlienta is 
'identyfikator klienta';

comment on column Poz_Faktury.IdFaktury is 
'identyfikator faktury';

comment on column Poz_Faktury.IdPozFaktury is 
'identyfikator pozycji faktury';

comment on column Poz_Faktury.IdSalonu is 
'Identyfikator salonu';

comment on column Poz_Faktury.IdSamochodu is 
'identyfikator samochodu';

comment on column Poz_Faktury.Akc_IdSalonu is 
'Identyfikator salonu';

comment on column Poz_Faktury.IdAkcesorii is 
'identyfikator akcesorii';

/*==============================================================*/
/* Index: Poz_Faktury_PK                                        */
/*==============================================================*/
create unique  index Poz_Faktury_PK on Poz_Faktury (
IdKlienta ASC,
IdFaktury ASC,
IdPozFaktury ASC
);

/*==============================================================*/
/* Index: Akcesoria_pozycji_faktury_FK                          */
/*==============================================================*/
create index Akcesoria_pozycji_faktury_FK on Poz_Faktury (
Akc_IdSalonu ASC,
IdAkcesorii ASC
);

/*==============================================================*/
/* Index: Pozycja_na_fakturze_FK                                */
/*==============================================================*/
create index Pozycja_na_fakturze_FK on Poz_Faktury (
IdKlienta ASC,
IdFaktury ASC
);

/*==============================================================*/
/* Index: Samochod_Pozycji_Faktury_FK                           */
/*==============================================================*/
create index Samochod_Pozycji_Faktury_FK on Poz_Faktury (
IdSalonu ASC,
IdSamochodu ASC
);

/*==============================================================*/
/* Table: Pracownik                                             */
/*==============================================================*/
create table Pracownik 
(
   IdSalonu             integer                        not null,
   IdPracownika         integer                        not null,
   Imie                 varchar(30)                    not null,
   Nazwisko             varchar(30)                    not null,
   KodPocztowy          varchar(6)                     null,
   Poczta               varchar(40)                    null,
   Ulica                varchar(40)                    null,
   NrDomu               varchar(10)                    null,
   Stanowisko           varchar(30)                    null,
   constraint PK_PRACOWNIK primary key  (IdSalonu, IdPracownika)
);

comment on table Pracownik is 
'jest to osoba pracuj¹ca w salonie';

comment on column Pracownik.IdSalonu is 
'Identyfikator salonu';

comment on column Pracownik.IdPracownika is 
'identyfikator pracownika';

comment on column Pracownik.Imie is 
'imie danej osoby';

comment on column Pracownik.Nazwisko is 
'nazwisko danej osoby';

comment on column Pracownik.KodPocztowy is 
'kod pocztowy miejsca zamieszkania danej osoby lub po³o¿enia salonu samochodowego';

comment on column Pracownik.Poczta is 
'nazwa miejscowoœci w ktorej znajduje sie poczta do ktorej nalezy dana osoba';

comment on column Pracownik.Ulica is 
'ulica na ktorej znajduje sie salon lub mieszka osoba';

comment on column Pracownik.NrDomu is 
'numerr domu w którym mieszka dana osoba';

comment on column Pracownik.Stanowisko is 
'stanowisko zajmowane w salonie przez pracownika';

/*==============================================================*/
/* Index: Pracownik_PK                                          */
/*==============================================================*/
create unique  index Pracownik_PK on Pracownik (
IdSalonu ASC,
IdPracownika ASC
);

/*==============================================================*/
/* Index: Pracownik_Salonu_FK                                   */
/*==============================================================*/
create index Pracownik_Salonu_FK on Pracownik (
IdSalonu ASC
);

/*==============================================================*/
/* Sequence: SEQ_Producent										*/
/*==============================================================*/
CREATE SEQUENCE SEQ_Producent START WITH 1 INCREMENT BY 1 MINVALUE 1 ;
/*==============================================================*/
/* Table: Producent                                             */
/*==============================================================*/
create table Producent 
(
   IdProducenta         integer DEFAULT (SEQ_Producent.nextval)      not null,
   IdKraju              integer                        not null,
   NazwaProducenta      varchar(30)                    not null,
   constraint PK_PRODUCENT primary key  (IdProducenta)
);

comment on table Producent is 
'Producent sprzêtu komputerowego';

comment on column Producent.IdProducenta is 
'identyfikator producenta
';

comment on column Producent.IdKraju is 
'identyfikator kraju';

comment on column Producent.NazwaProducenta is 
'Potoczna nazwa producenta, np Lexus';

/*==============================================================*/
/* Index: Producent_PK                                          */
/*==============================================================*/
create unique  index Producent_PK on Producent (
IdProducenta ASC
);

/*==============================================================*/
/* Index: Kraj_Producenta_FK                                    */
/*==============================================================*/
create index Kraj_Producenta_FK on Producent (
IdKraju ASC
);

/*==============================================================*/
/* Table: SalonSamochodowy                                      */
/*==============================================================*/
create table SalonSamochodowy 
(
   IdSalonu             integer                        not null,
   NazwaSalonu          varchar(30)                    not null,
   Miejscowosc          varchar(30)                    not null,
   KodPocztowy          varchar(6)                     null,
   Ulica                varchar(40)                    null,
   constraint PK_SALONSAMOCHODOWY primary key  (IdSalonu)
);

comment on table SalonSamochodowy is 
'Salon Samochodowy jest to lokal, w ktorym klient mo¿e kupiæ samochód lub akcesoria do auta.';

comment on column SalonSamochodowy.IdSalonu is 
'Identyfikator salonu';

comment on column SalonSamochodowy.NazwaSalonu is 
'Jest to potoczna nazwa z jaka identyfikuje sie salon';

comment on column SalonSamochodowy.Miejscowosc is 
'Miejscowosc w jakiej znajduje sie salon';

comment on column SalonSamochodowy.KodPocztowy is 
'kod pocztowy miejsca zamieszkania danej osoby lub po³o¿enia salonu samochodowego';

comment on column SalonSamochodowy.Ulica is 
'ulica na ktorej znajduje sie salon lub mieszka osoba';

/*==============================================================*/
/* Index: SalonSamochodowy_PK                                   */
/*==============================================================*/
create unique  index SalonSamochodowy_PK on SalonSamochodowy (
IdSalonu ASC
);

/*==============================================================*/
/* Table: Samochód                                              */
/*==============================================================*/
create table Samochód 
(
   IdSalonu             integer                        not null,
   IdSamochodu          integer                        not null,
   IdProducenta         integer                        null,
   Model                varchar(50)                    null,
   Kolor                varchar(15)                    null,
   RokProdukcji         numeric(4)                     null,
   TypSilnika           varchar(30)                    null,
   MocSilnika           numeric(3)                     null,
   CenaSamochodu        numeric(15,2)                  null,
   constraint PK_SAMOCHÓD primary key  (IdSalonu, IdSamochodu)
);

comment on table Samochód is 
'Samochód dostêpny do kupienia w salonie';

comment on column Samochód.IdSalonu is 
'Identyfikator salonu';

comment on column Samochód.IdSamochodu is 
'identyfikator samochodu';

comment on column Samochód.IdProducenta is 
'identyfikator producenta
';

comment on column Samochód.Model is 
'Model pojazdu danej marki';

comment on column Samochód.Kolor is 
'Kolor samochodu';

comment on column Samochód.RokProdukcji is 
'Rok w jakim dane auto zosta³o wyprodukowane';

comment on column Samochód.TypSilnika is 
'Typ silnika mówi¹cy nam o tym czym jest napêdzany samochód';

comment on column Samochód.MocSilnika is 
'Iloœæ koni mechanicznych';

comment on column Samochód.CenaSamochodu is 
'Koszt zakupu danego pojazdu';

/*==============================================================*/
/* Index: Samochód_PK                                           */
/*==============================================================*/
create unique  index Samochód_PK on Samochód (
IdSalonu ASC,
IdSamochodu ASC
);

/*==============================================================*/
/* Index: Producent_Pojazdu_FK                                  */
/*==============================================================*/
create index Producent_Pojazdu_FK on Samochód (
IdProducenta ASC
);

/*==============================================================*/
/* Index: Samochody_W_Salonie_FK                                */
/*==============================================================*/
create index Samochody_W_Salonie_FK on Samochód (
IdSalonu ASC
);

/*==============================================================*/
/* Table: Typ                                                   */
/*==============================================================*/
create table Typ 
(
   IdTypu               integer                        not null,
   NazwaTypu            varchar(30)                    not null,
   constraint PK_TYP primary key  (IdTypu)
);

comment on table Typ is 
'Typ to dana kategoria akcesoriów sprzedawanych w salonie np. Wycieraczki, Olej
';

comment on column Typ.IdTypu is 
'Identyfikator Typu
';

comment on column Typ.NazwaTypu is 
'Potoczna nazwa danego typu towaru';

/*==============================================================*/
/* Index: Typ_PK                                                */
/*==============================================================*/
create unique  index Typ_PK on Typ (
IdTypu ASC
);

alter table Akcesoria
   add constraint FK_AKCESORI_AKCESORIA_SALONSAM foreign key (IdSalonu)
      references SalonSamochodowy (IdSalonu)
      on update restrict
      on delete restrict;

alter table Akcesoria
   add constraint FK_AKCESORI_PRODUCENT_PRODUCEN foreign key (IdProducenta)
      references Producent (IdProducenta)
      on update restrict
      on delete restrict;

alter table Akcesoria
   add constraint FK_AKCESORI_TYP_AKCES_TYP foreign key (IdTypu)
      references Typ (IdTypu)
      on update restrict
      on delete restrict;

alter table Faktura
   add constraint FK_FAKTURA_ODBIERAJA_KLIENT foreign key (IdKlienta)
      references Klient (IdKlienta)
      on update restrict
      on delete restrict;

alter table Faktura
   add constraint FK_FAKTURA_WYSTAWIAJ_PRACOWNI foreign key (IdSalonu, IdPracownika)
      references Pracownik (IdSalonu, IdPracownika)
      on update restrict
      on delete restrict;

alter table Poz_Faktury
   add constraint FK_POZ_FAKT_AKCESORIA_AKCESORI foreign key (Akc_IdSalonu, IdAkcesorii)
      references Akcesoria (IdSalonu, IdAkcesorii)
      on update restrict
      on delete restrict;

alter table Poz_Faktury
   add constraint FK_POZ_FAKT_POZYCJA_N_FAKTURA foreign key (IdKlienta, IdFaktury)
      references Faktura (IdKlienta, IdFaktury)
      on update restrict
      on delete restrict;

alter table Poz_Faktury
   add constraint FK_POZ_FAKT_SAMOCHOD__SAMOCHÓD foreign key (IdSalonu, IdSamochodu)
      references Samochód (IdSalonu, IdSamochodu)
      on update restrict
      on delete restrict;

alter table Pracownik
   add constraint FK_PRACOWNI_PRACOWNIK_SALONSAM foreign key (IdSalonu)
      references SalonSamochodowy (IdSalonu)
      on update restrict
      on delete restrict;

alter table Producent
   add constraint FK_PRODUCEN_KRAJ_PROD_KRAJ foreign key (IdKraju)
      references Kraj (IdKraju)
      on update restrict
      on delete restrict;

alter table Samochód
   add constraint FK_SAMOCHÓD_PRODUCENT_PRODUCEN foreign key (IdProducenta)
      references Producent (IdProducenta)
      on update restrict
      on delete restrict;

alter table Samochód
   add constraint FK_SAMOCHÓD_SAMOCHODY_SALONSAM foreign key (IdSalonu)
      references SalonSamochodowy (IdSalonu)
      on update restrict
      on delete restrict;

