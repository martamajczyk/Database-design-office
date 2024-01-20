INSERT INTO inwestycje (inwestycja_nazwa)
VALUES  ('Zielone Ogrody'),
		('Nowe Polesie'),
		('Osiedle Grunwaldzkie'),
		('Apartamenty Zbiorcza'),
		('Apartamenty Senatorska'),
		('Nowe Młociny'),
		('Wiszące Ogrody'),
		('Apartamenty przy lesie'),
		('Nad Wisłą'),
		('Art. Modern'),
		('Osiedle Bosmańskie'),
		('Poleskie Ogrody'),
		('Apartamenty Żubrowej'),
		('Osiedle Nadodrze'),
		('NeoTeo'),
		('Nowe Bałuty'),
		('Oaza nad Łódką'),
		('Rezydencja Międzylesie'),
		('Osiedle Zastawna');

INSERT INTO stylistyka (stylistyka_nazwa)
VALUES	('kamieniczny'),
		('loftowy'),
		('glamour'),
		('minimalizm'),
		('eklektyczny'),
		('modernistyczny'),
		('nowoczesny'),
		('skandynawski');
		
INSERT INTO zakresy_pakietow (zakres_pakietu_inwentaryzacja, zakres_pakietu_funkcja, zakres_pakietu_koncepcja, zakres_pakietu_wizualizacje, zakres_pakietu_lista_zakupow, zakres_pakietu_dokumentacja, zakres_pakietu_nadzor, zakres_pakietu_home_staging)
VALUES	(FALSE, TRUE, TRUE, FALSE, TRUE, FALSE, FALSE, FALSE),
		(TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE),
		(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE),
		(FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE),
		(TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, FALSE, FALSE),
		(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE),
		(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE);
		
INSERT INTO pakiety (pakiet_nazwa, pakiet_cena_bazowa, pakiet_kategoria, zakres_pakietu_id)
VALUES	('silver basic', 3000.00, 'inwestycyjny', 1),
		('silver medium', 4000.00, 'inwestycyjny', 2),
		('silver premium', 7000.00, 'inwestycyjny', 3),
		('gold basic', 6000.00, 'prywatny', 4),
		('gold medium', 10000.00, 'prywatny', 5),
		('gold premium', 15000.00, 'prywatny', 6),
		('single', 3000.00, 'prywatny', 7);
		
COPY adresy (adres_ulica, adres_nr_ulicy, adres_nr_lokalu, adres_kod_pocztowy, adres_miasto)
FROM 'your_path\Adresy.csv'
DELIMITER ';' CSV HEADER;

COPY adresy (adres_ulica, adres_nr_ulicy, adres_nr_lokalu, adres_kod_pocztowy, adres_miasto)
FROM 'your_path\Adresy_projekty.csv'
DELIMITER ';' CSV HEADER;

COPY inwestorzy (inwestor_imie, inwestor_nazwisko, inwestor_plec, inwestor_data_urodzenia, inwestor_sposob_dotarcia, adres_id)
FROM 'your_path\Inwestorzy.csv'
DELIMITER ';' CSV HEADER; 

COPY pracownicy (pracownik_imie, pracownik_nazwisko, pracownik_plec, pracownik_data_urodzenia, pracownik_data_zatrudnienia, pracownik_data_zwolnienia, pracownik_typ_umowy, adres_id)
FROM 'your_path\Pracownicy.csv'
DELIMITER ';' CSV HEADER; 

COPY projekty (projekt_data_umowa, projekt_cena_umowa, projekt_data_rozpoczecia, projekt_data_zakonczenia, projekt_tryb, projekt_rynek, projekt_metraz, projekt_budzet_planowany, projekt_budzet_zrealizowany, stylistyka_id, inwestycja_id, adres_id, pakiet_id)
FROM 'your_path\Projekty.csv'
DELIMITER ';' CSV HEADER;

COPY projekty_inwestorzy (projekt_id, inwestor_id)
FROM 'your_path\Projekty_inwestorzy.csv'
DELIMITER ';' CSV HEADER;

COPY projekty_pracownicy (projekt_id, pracownik_id)
FROM 'your_path\Projekty_pracownicy.csv'
DELIMITER ';' CSV HEADER;

