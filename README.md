# PBD - projekt systemu zarządzania konferencjami

Baza danych stworzona w dialekcie MS SQL do zarządzania firmą organizującą konferencje.

## Diagram bazy danych

![Diagram](https://image.ibb.co/f3U3qc/Diagram.png)

## Generator danych

Dostępny [tutaj](https://github.com/pzal/projekt-bazy-danych-generator).


## Zawartość projektu

* Skrypt tworzący bazę danych wraz z warunkami integralnościowymi
* Skrypt z funkcjami, procedurami i triggerami 
* Widoki użytkowników
* Indeksy i role
* Przykładowe dane stworzone przez generator

## Użycie

1. Stworzenie lokalnie nowej bazy danych poartej na MS SQL

2. Uruchuchomienie `All_in_one_creator.sql`

3. Wprowadzenie rekordów z `mock_data.sql`

4. Przykładowe komendy w `example_usage.sql
`
