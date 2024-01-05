CREATE TABLE inwestycje
(
	inwestycja_id BIGSERIAL,
	inwestycja_nazwa TEXT,
	ostatnia_aktualizacja TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stylistyka
(
	stylistyka_id BIGSERIAL,
	stylistyka_nazwa TEXT,
	ostatnia_aktualizacja TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE zakresy_pakietow
(
	zakres_pakietu_id BIGSERIAL,
	zakres_pakietu_inwentaryzacja BOOLEAN,
	zakres_pakietu_funkcja BOOLEAN,
	zakres_pakietu_koncepcja BOOLEAN,
	zakres_pakietu_wizualizacje BOOLEAN,
	zakres_pakietu_lista_zakupow BOOLEAN,
	zakres_pakietu_dokumentacja BOOLEAN,
	zakres_pakietu_nadzor BOOLEAN,
	zakres_pakietu_home_staging BOOLEAN,
	ostatnia_aktualizacja TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pakiety
(
	pakiet_id BIGSERIAL,
	pakiet_nazwa TEXT,
	pakiet_cena_bazowa DECIMAL(10,2),
	pakiet_kategoria TEXT,
	zakres_pakietu_id BIGINT,
	ostatnia_aktualizacja TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE adresy
(
	adres_id BIGSERIAL,
	adres_ulica TEXT,
	adres_nr_ulicy INT,
	adres_nr_lokalu INT,
	adres_kod_pocztowy VARCHAR(6),
	adres_miasto TEXT,
	ostatnia_aktualizacja TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE projekty
(
	projekt_id BIGSERIAL,
	projekt_data_umowa DATE,
	projekt_cena_umowa DECIMAL(10,2),
	projekt_data_rozpoczecia DATE,
	projekt_data_zakonczenia DATE,
	projekt_tryb TEXT,
	projekt_rynek TEXT,
	projekt_metraz DECIMAL(10,2),
	projekt_budzet_planowany INT,
	projekt_budzet_zrealizowany INT,
	stylistyka_id BIGINT,
	inwestycja_id BIGINT,
	adres_id BIGINT,
	pakiet_id BIGINT,
	ostatnia_aktualizacja TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE inwestorzy
(
	inwestor_id BIGSERIAL,
	inwestor_imie TEXT,
	inwestor_nazwisko TEXT,
	inwestor_plec CHAR(1),
	inwestor_data_urodzenia DATE,
	inwestor_sposob_dotarcia TEXT,
	adres_id BIGINT,
	ostatnia_aktualizacja TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE projekty_inwestorzy
(
	projekty_inwestorzy_id BIGSERIAL,
	projekt_id BIGINT,
	inwestor_id BIGINT,
	ostatnia_aktualizacja TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pracownicy
(
	pracownik_id BIGSERIAL,
	pracownik_imie TEXT,
	pracownik_nazwisko TEXT,
	pracownik_plec CHAR(1),
	pracownik_data_urodzenia DATE,
	pracownik_data_zatrudnienia DATE,
	pracownik_data_zwolnienia DATE,
	pracownik_typ_umowy TEXT,
	adres_id BIGINT,
	ostatnia_aktualizacja TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE projekty_pracownicy
(
	projekt_pracownik_id BIGSERIAL,
	projekt_id BIGINT,
	pracownik_id BIGINT,
	ostatnia_aktualizacja TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
