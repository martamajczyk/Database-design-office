ALTER TABLE inwestycje 
ADD CONSTRAINT pk_inwestycje PRIMARY KEY (inwestycja_id),
ALTER COLUMN inwestycja_nazwa SET NOT NULL,
ADD CONSTRAINT unique_inwestycja_nazwa UNIQUE (inwestycja_nazwa),
ALTER COLUMN ostatnia_aktualizacja SET NOT NULL;

ALTER TABLE stylistyka 
ADD CONSTRAINT pk_stylistyka PRIMARY KEY (stylistyka_id),
ALTER COLUMN stylistyka_nazwa SET NOT NULL,
ADD CONSTRAINT unique_stylistyka_nazwa UNIQUE (stylistyka_nazwa),
ALTER COLUMN ostatnia_aktualizacja SET NOT NULL;

ALTER TABLE zakresy_pakietow
ADD CONSTRAINT pk_zakresy_pakietow PRIMARY KEY (zakres_pakietu_id),
ALTER COLUMN zakres_pakietu_inwentaryzacja SET NOT NULL,
ALTER COLUMN zakres_pakietu_funkcja SET NOT NULL,
ALTER COLUMN zakres_pakietu_koncepcja SET NOT NULL,
ALTER COLUMN zakres_pakietu_wizualizacje SET NOT NULL,
ALTER COLUMN zakres_pakietu_lista_zakupow SET NOT NULL,
ALTER COLUMN zakres_pakietu_dokumentacja SET NOT NULL,
ALTER COLUMN zakres_pakietu_nadzor SET NOT NULL,
ALTER COLUMN zakres_pakietu_home_staging SET NOT NULL,
ALTER COLUMN ostatnia_aktualizacja SET NOT NULL;

ALTER TABLE pakiety
ADD CONSTRAINT pk_pakiety PRIMARY KEY (pakiet_id),
ALTER COLUMN pakiet_nazwa SET NOT NULL,
ADD CONSTRAINT unique_pakiet_nazwa UNIQUE (pakiet_nazwa),
ALTER COLUMN pakiet_cena_bazowa SET NOT NULL,
ADD CONSTRAINT check_cena_bazowa CHECK (pakiet_cena_bazowa > 0),
ALTER COLUMN pakiet_kategoria SET NOT NULL,
ADD CONSTRAINT check_kategoria CHECK (pakiet_kategoria IN ('inwestycyjny', 'prywatny')),
ALTER COLUMN zakres_pakietu_id SET NOT NULL,
ADD CONSTRAINT fk_zakresy_pakietow FOREIGN KEY (zakres_pakietu_id) REFERENCES zakresy_pakietow (zakres_pakietu_id),
ALTER COLUMN ostatnia_aktualizacja SET NOT NULL;

ALTER TABLE adresy 
ADD CONSTRAINT pk_adresy PRIMARY KEY (adres_id),
ALTER COLUMN adres_ulica SET NOT NULL,
ALTER COLUMN adres_nr_ulicy SET NOT NULL,
ALTER COLUMN adres_kod_pocztowy SET NOT NULL,
ALTER COLUMN adres_miasto SET NOT NULL,
ALTER COLUMN ostatnia_aktualizacja SET NOT NULL;

ALTER TABLE projekty 
ADD CONSTRAINT pk_projekty PRIMARY KEY (projekt_id),
ALTER COLUMN projekt_data_umowa SET NOT NULL,
ADD CONSTRAINT check_data_umowa CHECK
(
    projekt_data_umowa <= projekt_data_rozpoczecia 
    AND (projekt_data_zakonczenia IS NULL OR projekt_data_umowa < projekt_data_zakonczenia)
    AND (projekt_data_zakonczenia IS NULL OR projekt_data_rozpoczecia <= projekt_data_zakonczenia)
	AND (projekt_data_umowa >= '2019-01-01')
),
ALTER COLUMN projekt_cena_umowa SET NOT NULL,
ADD CONSTRAINT check_cena_umowa CHECK (projekt_cena_umowa > 0),
ALTER COLUMN projekt_data_rozpoczecia SET NOT NULL,
ADD CONSTRAINT check_data_rozpoczecia CHECK (projekt_data_rozpoczecia >= '2019-01-01'),
ADD CONSTRAINT check_data_zakonczenia CHECK (projekt_data_zakonczenia >= '2019-01-01'),
ALTER COLUMN projekt_tryb SET NOT NULL,
ADD CONSTRAINT check_tryb CHECK (projekt_tryb IN ('zdalny', 'stacjonarny', 'hybrydowy')),
ALTER COLUMN projekt_rynek SET NOT NULL,
ADD CONSTRAINT check_rynek CHECK (projekt_rynek IN ('pierwotny', 'wtórny')),
ALTER COLUMN projekt_metraz SET NOT NULL,
ADD CONSTRAINT check_metraz CHECK (projekt_metraz > 0),
ALTER COLUMN projekt_budzet_planowany SET NOT NULL,
ADD CONSTRAINT check_budzet_planowany CHECK (projekt_budzet_planowany > 0),
ALTER COLUMN projekt_budzet_zrealizowany SET NOT NULL,
ADD CONSTRAINT check_budzet_zrealizowany CHECK (projekt_budzet_zrealizowany > 0),
ALTER COLUMN stylistyka_id SET NOT NULL,
ADD CONSTRAINT fk_stylistyka FOREIGN KEY (stylistyka_id) REFERENCES stylistyka (stylistyka_id),
ADD CONSTRAINT fk_inwestycje FOREIGN KEY (inwestycja_id) REFERENCES inwestycje (inwestycja_id),
ALTER COLUMN adres_id SET NOT NULL,
ADD CONSTRAINT fk_adresy FOREIGN KEY (adres_id) REFERENCES adresy (adres_id),
ALTER COLUMN pakiet_id SET NOT NULL,
ADD CONSTRAINT fk_pakiety FOREIGN KEY (pakiet_id) REFERENCES pakiety (pakiet_id),
ALTER COLUMN ostatnia_aktualizacja SET NOT NULL;

ALTER TABLE inwestorzy 
ADD CONSTRAINT pk_inwestorzy PRIMARY KEY (inwestor_id),
ALTER COLUMN inwestor_imie SET NOT NULL,
ALTER COLUMN inwestor_nazwisko SET NOT NULL,
ALTER COLUMN inwestor_plec SET NOT NULL,
ADD CONSTRAINT check_plec CHECK (inwestor_plec IN ('K', 'M')),
ALTER COLUMN inwestor_data_urodzenia SET NOT NULL,
ADD CONSTRAINT check_data_urodzenia CHECK (inwestor_data_urodzenia > '1920-01-01'),
ALTER COLUMN inwestor_sposob_dotarcia SET NOT NULL,
ALTER COLUMN adres_id SET NOT NULL,
ADD CONSTRAINT fk_adresy FOREIGN KEY (adres_id) REFERENCES adresy (adres_id),
ALTER COLUMN ostatnia_aktualizacja SET NOT NULL;

ALTER TABLE projekty_inwestorzy 
ADD CONSTRAINT pk_projekty_inwestorzy PRIMARY KEY (projekty_inwestorzy_id),
ALTER COLUMN projekt_id SET NOT NULL,
ADD CONSTRAINT fk_projekty FOREIGN KEY (projekt_id) REFERENCES projekty (projekt_id),
ALTER COLUMN inwestor_id SET NOT NULL,
ADD CONSTRAINT fk_inwestorzy FOREIGN KEY (inwestor_id) REFERENCES inwestorzy (inwestor_id),
ALTER COLUMN ostatnia_aktualizacja SET NOT NULL;

ALTER TABLE pracownicy 
ADD CONSTRAINT pk_pracownicy PRIMARY KEY (pracownik_id),
ALTER COLUMN pracownik_imie SET NOT NULL,
ALTER COLUMN pracownik_nazwisko SET NOT NULL,
ALTER COLUMN pracownik_plec SET NOT NULL,
ADD CONSTRAINT check_plec CHECK (pracownik_plec IN ('K', 'M')),
ALTER COLUMN pracownik_data_urodzenia SET NOT NULL,
ADD CONSTRAINT check_data_urodzenia CHECK (pracownik_data_urodzenia > '1920-01-01'),
ALTER COLUMN pracownik_data_zatrudnienia SET NOT NULL,
ADD CONSTRAINT pracownik_data_zatrudnienia CHECK 
(
	pracownik_data_zatrudnienia <= pracownik_data_zwolnienia
	AND (pracownik_data_zatrudnienia IS NULL OR pracownik_data_zatrudnienia > pracownik_data_urodzenia)
	AND (pracownik_data_zatrudnienia IS NULL OR pracownik_data_zatrudnienia < pracownik_data_zwolnienia)
);
ALTER COLUMN pracownik_typ_umowy SET NOT NULL,
ADD CONSTRAINT check_typ_umowy CHECK (pracownik_typ_umowy IN ('Umowa o pracę', 'Umowa zlecenie', 'Umowa o dzieło', 'Kontrakt B2B')),
ALTER COLUMN adres_id SET NOT NULL,
ADD CONSTRAINT fk_adresy FOREIGN KEY (adres_id) REFERENCES adresy (adres_id),
ALTER COLUMN ostatnia_aktualizacja SET NOT NULL;

ALTER TABLE projekty_pracownicy 
ADD CONSTRAINT pk_projekty_pracownicy PRIMARY KEY (projekt_pracownik_id),
ALTER COLUMN projekt_id SET NOT NULL,
ADD CONSTRAINT fk_projekty FOREIGN KEY (projekt_id) REFERENCES projekty (projekt_id),
ALTER COLUMN pracownik_id SET NOT NULL,
ADD CONSTRAINT fk_pracownicy FOREIGN KEY (pracownik_id) REFERENCES pracownicy (pracownik_id),
ALTER COLUMN ostatnia_aktualizacja SET NOT NULL;