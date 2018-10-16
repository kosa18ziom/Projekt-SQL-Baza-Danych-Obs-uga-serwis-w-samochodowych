--KRAJ
insert into Kraj (NazwaKraju) values ('Niemcy');
insert into Kraj (NazwaKraju) values ('Japonia');
insert into Kraj (NazwaKraju) values ('Francja');
insert into Kraj (NazwaKraju) values ('Wielka Brytania');
insert into Kraj (NazwaKraju) values ('USA');

--Producenci Samochodow
insert into Producent (IdKraju, NazwaProducenta) values (1, 'Mercedes');
insert into Producent (IdKraju, NazwaProducenta) values (1, 'Audi');
insert into Producent (IdKraju, NazwaProducenta) values (1, 'BMW');
insert into Producent (IdKraju, NazwaProducenta) values (2, 'Mazda');
insert into Producent (IdKraju, NazwaProducenta) values (2, 'Honda');
insert into Producent (IdKraju, NazwaProducenta) values (2, 'Mitsubishi');
insert into Producent (IdKraju, NazwaProducenta) values (3, 'Citroen');
insert into Producent (IdKraju, NazwaProducenta) values (3, 'Peugeot');
insert into Producent (IdKraju, NazwaProducenta) values (3, 'Renault');
insert into Producent (IdKraju, NazwaProducenta) values (4, 'Aston Martin');
insert into Producent (IdKraju, NazwaProducenta) values (4, 'Bentley');
insert into Producent (IdKraju, NazwaProducenta) values (4, 'Jaguar');
insert into Producent (IdKraju, NazwaProducenta) values (5, 'Ford');
insert into Producent (IdKraju, NazwaProducenta) values (5, 'Chevrolet');

--Producenci Akcesoriow
insert into Producent (IdKraju, NazwaProducenta) 
values
(1,'Bosch'),
(2,'Ashika'),
(4,'Garmin'),
(2,'Bridgestone'),
(1,'Continental');


--SALONY
insert into SalonSamochodowy (IdSalonu,NazwaSalonu,Miejscowosc,KodPocztowy,Ulica)
VALUES
(1,'Salon A','Warszawa','00-102','Marszałkowska'),
(2,'Salon B','Białystok','15-002','Sienkiewicza'),
(3,'Salon C','Łódź','90-004','Piotrkowska');

--TYPY AKCESORIÓW
INSERT into TYP (IdTypu,NazwaTypu)
VALUES
(1,'Wycieraczki'),
(2,'Opony'),
(3,'Nawigacja');

--AKCESORIA
insert into Akcesoria (IdSalonu,IdAkcesorii,IdTypu,IdProducenta,NazwaAkcesorii,CenaAkcesorii)
VALUES
(1,1,1,15,'Wycieraczki BOSCH Aerotwin','110.95'),
(1,2,1,16,'Pióro Wycieraczki Ashika','35.00'),
(1,3,2,18,'Blizzak 205/55 R16 Zimowe','169.00'),
(1,4,2,18,'Blizzak 205/55 R16 Letnie','149.00'),
(1,5,3,17,'GARMIN Drive 50 LM Centralna Europa','499.99'),
(2,1,1,15,'Wycieraczki BOSCH Aerotwin','110.95'),
(2,2,1,16,'Pióro Wycieraczki Ashika','35.00'),
(2,3,2,18,'Blizzak 205/55 R16 Zimowe','169.00'),
(2,4,2,18,'Blizzak 205/55 R16 Letnie','149.00'),
(2,5,3,17,'GARMIN Drive 50 LM Centralna Europa','499.99'),
(3,1,1,15,'Wycieraczki BOSCH Aerotwin','110.95'),
(3,2,1,16,'Pióro Wycieraczki Ashika','35.00'),
(3,3,2,18,'WinterContact 155/70 R19 Zimowe','667.00'),
(3,4,2,18,'ContiEcoContact 205/55 R16 Letnie','286.00'),
(3,5,3,17,'GARMIN Drive 50 LM Centralna Europa','499.99');

--SAMOCHODY
INSERT into Samochod (IdSalonu,IdSamochodu,IdProducenta,Model,Kolor,RokProdukcji,TypSilnika,MocSilnika,CenaSamochodu)
VALUES
(1,1,1,'Klasa S','srebrny','2017','Diesel','258','379000.00'),
(1,2,2,'Q5','Czarny','2017','Diesel','190','195000.00'),
(1,3,11,'Bentayga','srebrny','2016','Benzyna','608','729000.00'),
(1,4,13,'S-Max','czarny','2016','Benzyna','160','115900.00'),
(2,1,4,'6','niebieski','2016','Benzyna','165','112005.00'),
(2,2,6,'Outlander','brązowy metalik','2016','Diesel','150','150099.00'),
(3,1,12,'XF','czarny','2016','Benzyna','240','270920.00'),
(3,2,9,'Talisman','czerwony','2016','Benzyna','150','97082.00');

--KLIENCI
insert into Klient (IdKlienta, Imie, Nazwisko) values (1, 'Jan', 'Wiśniewski');
insert into Klient (IdKlienta, Imie, Nazwisko) values (2, 'Adam', 'Lewandowski');
insert into Klient (IdKlienta, Imie, Nazwisko) values (3, 'Damina', 'Zieliński');
insert into Klient (IdKlienta, Imie, Nazwisko) values (4, 'Urszula', 'Kozłowska');
insert into Klient (IdKlienta, Imie, Nazwisko) values (5, 'Michał', 'Krawczyk');
insert into Klient (IdKlienta, Imie, Nazwisko) values (6, 'Bogdan', 'Kaczmarek');
insert into Klient (IdKlienta, Imie, Nazwisko) values (7, 'Janusz', 'Piotrowski');
insert into Klient (IdKlienta, Imie, Nazwisko) values (8, 'Halina', 'Majewska');
insert into Klient (IdKlienta, Imie, Nazwisko) values (9, 'Henryk', 'Dudek');
insert into Klient (IdKlienta, Imie, Nazwisko) values (10, 'Mariusz', 'Dudek');

--PRACOWNICY
insert into Pracownik (IdPracownika, IdSalonu, Imie, Nazwisko) values (1, 1, 'Jan', 'Kowalski');
insert into Pracownik (IdPracownika, IdSalonu, Imie, Nazwisko) values (2, 1, 'Joanna', 'Nowak');
insert into Pracownik (IdPracownika, IdSalonu, Imie, Nazwisko) values (3, 1, 'Roman', 'Konarski');

insert into Pracownik (IdPracownika, IdSalonu, Imie, Nazwisko) values (1, 2, 'Marek', 'Piotrowski');
insert into Pracownik (IdPracownika, IdSalonu, Imie, Nazwisko) values (2, 2, 'Grzegorz', 'Brzydki');

insert into Pracownik (IdPracownika, IdSalonu, Imie, Nazwisko) values (1, 3, 'Mariusz', 'Abacki');
insert into Pracownik (IdPracownika, IdSalonu, Imie, Nazwisko) values (2, 3, 'Stanisław', 'Abacki');
insert into Pracownik (IdPracownika, IdSalonu, Imie, Nazwisko) values (3, 3, 'Jan', 'Pol');

--FAKTURY
insert into Faktura(IdKlienta, IdFaktury, IdPracownika, IdSalonu) values (1, 1, 1, 3);

insert into Faktura(IdKlienta, IdFaktury, IdPracownika, IdSalonu) values (2, 1, 2, 3);


insert into Faktura(IdKlienta, IdFaktury, IdPracownika, IdSalonu) values (3, 1, 2, 1);
insert into Faktura(IdKlienta, IdFaktury, IdPracownika, IdSalonu) values (3, 2, 2, 1);

insert into Faktura(IdKlienta, IdFaktury, IdPracownika, IdSalonu) values (4, 1, 2, 2);


--Pozycje na Fakturach

//1
insert into Poz_Faktury(IdKlienta, IdFaktury, IdPozFaktury, IdSamochodu, IdSalonu) values (1, 1, 1, 1, 3);
insert into Poz_Faktury(IdKlienta, IdFaktury, IdPozFaktury, IdAkcesorii, Akc_IdSalonu) values (1, 1, 2, 2, 3);



//2
insert into Poz_Faktury(IdKlienta, IdFaktury, IdPozFaktury, IdSamochodu, IdSalonu) values (2, 1, 1, 2, 3);



//3
insert into Poz_Faktury(IdKlienta, IdFaktury, IdPozFaktury, IdSamochodu, IdSalonu) values (3, 1, 1, 1, 1);
insert into Poz_Faktury(IdKlienta, IdFaktury, IdPozFaktury, IdAkcesorii, Akc_IdSalonu) values (3, 1, 2, 1, 1);

insert into Poz_Faktury(IdKlienta, IdFaktury, IdPozFaktury, IdSamochodu, IdSalonu) values (3, 2, 1, 2, 1);

//4
insert into Poz_Faktury(IdKlienta, IdFaktury, IdPozFaktury, IdSamochodu, IdSalonu) values (4, 1, 1, 2, 2);