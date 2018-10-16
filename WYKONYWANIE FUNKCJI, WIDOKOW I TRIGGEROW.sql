CALL "CarsSold"("idS" = 1)

CALL nowyA(17,3,'nawigacja garmin 2000',569.99)

CALL towaryKlienta('Damina','Zieliński')

CALL wysAkcesoria('nawigacja',3)

select HowManyCars('mitsubishi')

select nowyP('Porsche','Niemcy')

select przychod(1)

select wystawcy('Mariusz','Abacki')

select * from bestCarCustomers

select * from bestCarProducents

select * from bestsell

--Widok Zmaterializowany, wykonujemy call nowyA( w tej procedurze jest refresh) po czym wykonujemy:
select * from Laczna_wartosc_akcesoriow

delete from Producent where IdProducenta=1

delete from TYP where IdTypu=1

delete from Samochód where IdSamochodu=1

UPDATE Poz_Faktury SET IdSamochodu=2 where IdSamochodu = 1 