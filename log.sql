
-- checking the description when the theft took place
SELECT description FROM crime_scene_reports
WHERE
year = 2021 AND
month = 7 AND
day = 28 AND
street = "Humphrey Street";

-- Checking what the witnesses said in the interviews and they are three : Ruth , Eugen , Raymond
SELECT name , transcript FROM interviews
WHERE
year = 2021 AND
month = 7 AND
day  = 28 AND
transcript LIKE "%BAKERY%";


-- searching about the names of the accounts

SELECT name FROM people
WHERE id IN
(SELECT person_id FROM bank_accounts
WHERE account_number IN
(SELECT account_number FROM atm_transactions
WHERE
year = 2021 AND
month = 7 AND
day = 28 AND
atm_location = "Leggett Street" AND
transaction_type LIKE "withdraw"));

--The name of the airport

SELECT abbreviation, full_name, city FROM airports
WHERE city = "Fiftyville";

--raymond said the thief asked about flight ticket tomorrow

SELECT flights.id, full_name, city , flights.hour, flights.minute FROM airports
JOIN flights ON airports.id = flights.destination_airport_id
WHERE flights.origin_airport_id IN
(SELECT id FROM airports
WHERE city = "Fiftyville") AND
flights.year = 2021 AND
flights.month = 7 AND
flights.day = 29
;

--Searching the names of the passport number

SELECT name , passengers.passport_number, passengers.seat , passengers.flight_id FROM people
JOIN flights ON passengers.flight_id = flights.id
JOIN passengers ON people.passport_number = passengers.passport_number
WHERE
flights.month = 7 AND
flights.day = 29 AND
flights.year = 2021 AND
flights.hour = 8 AND
flights.minute = 20;

--Raymond said : the thief called someone for less than a minute, so i'm searching the names who's call on this day


SELECT name , phone_calls.duration FROM people
JOIN phone_calls ON people.phone_number = phone_calls.caller
WHERE
phone_calls.day = 28 AND
phone_calls.year = 2021 AND
phone_calls.month = 7 AND
phone_calls.duration BETWEEN 0 AND 60;

--Searching the receiver's name and checking the call time between the thief and receiver

SELECT name , phone_calls.duration FROM people
JOIN phone_calls ON people.phone_number = phone_calls.receiver
WHERE
phone_calls.day = 28 AND
phone_calls.year = 2021 AND
phone_calls.month = 7 AND
phone_calls.duration BETWEEN 0 AND 60;

-- if I  depend on the duration of the caller and receiver
-- so then the caller is Bruce and the receiver is Robin


--Ruth said: the thief take a car after exiting a bakery, so I'm checking the names when taking a car after 10 minutes after the theft

SELECT bakery_security_logs.hour , bakery_security_logs.minute , name FROM people
JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
WHERE
bakery_security_logs.year = 2021 AND
bakery_security_logs.day = 28 AND
bakery_security_logs.month = 7 AND
bakery_security_logs.hour = 10 AND
bakery_security_logs.minute BETWEEN 15 AND 25;

