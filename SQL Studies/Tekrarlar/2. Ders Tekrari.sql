-- foreign key ler veya primary keyler, kullandigimiz tablodan
-- bir sütun ve bu sütunun degerleri olmak zorunda degildir.
-- kendimiz haricten de numara verebiliriz


-- RDBMS: relational database managemnet system


-- NoSQL: not only SQL 
-- python veya diger programlama dilleri ile entegre bir sekilde
-- calisabilir

-- unstrucktured veriler ile iyi bir sekilde calisir


-- CRUD operations
-- CREATE
-- retrieve(read)
-- update 
-- delete 


-- BNF notation kullanilir

-- keyword ler büyük identifier lar ise kücük


--  normal de tek tirnak, SQLite da ikisi de olur


-- DISTINCT

-- SELECT DISTINCT sütunadi from ..........

SELECT DISTINCT name
FROM tracks;

-- DISTINCT de birden fazla sütun koydugumuzda
-- iki sütununda ayni olmasini ister


-- Not: execute gibi herhangi bir tusu kaybedersek
-- view seceneginden geri acabiliriz

SELECT name, Composer
FROM tracks
WHERE Composer = "Jimi Hendrix";


SELECT *
FROM invoices
WHERE total > 10;



----------------------------- LIMIT clause

-- limit where'in ve order by'in altinda olmak zorundadir

SELECT *
FROM invoices
WHERE total > 10
ORDER by total DESC
LIMIT 5;

--------------------------  order by

-- sütunlari siralamak icin kullandigimiz bir komuttur

-- default u ascending(ASC)
-- tersten siralamak ise DESC(desc)

------------   kayiz tarihi en yeni olan 10 kayit

SELECT *
FROM invoices
WHERE total > 10
ORDER by InvoiceDate DESC
LIMIT 10;

----- 
-- oreder by ile birden cok sütun kullanmamiz mümkündür:
-- ve bunlardan birisi artan digeri azalan olabilir

SELECT *
FROM invoices
WHERE total > 10
ORDER by InvoiceDate DESC, total ASC  -- 3 ve daha fazla da olabili
LIMIT 10;



--------------  logic statements

------------  and,  or,  NOT

-- Birden cok sorguyu birlestirmek icin bu ifadeler kullanilir

-- ve bunlar sart ifadesi oldugu icin where ile kullanmak
-- durumundayiz

-- AND:

-- iki kosulda dogru ise calisir

-- OR da ayni python daki or gibi calisir


-- NOT ise condition'in tersi icin kullanilir


SELECT *
FROM invoices
WHERE NOT BillingCountry = "USA"
order by total DESC;

--- alternatif

SELECT *
FROM invoices
WHERE BillingCountry <> "USA"
order by total DESC;




SELECT *
FROM invoices
WHERE BillingCountry = "USA" or BillingCountry = "Germany"
ORDER by InvoiceId ASC;

-- Not: burada iki kez BillingCountry  yazmamiz gerekir
-- sqlite da hata vermiyor ama diger sql lerde hata verir


-- Not: iki tane where kullanamiyoruz
--SELECT *
--FROM invoices
--WHERE BillingCountry = "USA"
--WHERE BillingCountry = "Germany"
--ORDER by InvoiceId ASC;



SELECT *
FROM invoices
WHERE InvoiceDate >= "2012-01-01" and InvoiceDate <= "2012-03-01 00:00:00"    -- dikkat >= kullaniyoruz
ORDER by InvoiceDate DESC;											          -- saat de bu sekilde kullanilabilir


-- tablomuzda zaman formatimizda hem tarih hem de saat varsa
-- bu durumda sorgulamada ikisini de dikkate almamiz gerekir
-- eger saati dikkate almazsak, bu durumda sorgulamamiz bazi durumlarda
-- eksik sonuc verebilir






------------------------------  BETWEEN

-- and operatörü ile iki tane yanyana sorgu yapiyorduk
-- between ile ayni islemi yapiyoruz ve daha kisa bir sekilde


-- az önceki sorgumuzu between ile yapalim:

SELECT *
FROM invoices
WHERE InvoiceDate BETWEEN "2012-01-01" and "2012-03-01 00:00:00"   
ORDER by InvoiceDate DESC;											

-- Not: between de sagdaki ve soldaki degerler dahil



--------------------- Not BETWEEN:


SELECT *
FROM invoices
WHERE InvoiceDate NOT BETWEEN "2012-01-01" and "2012-03-01 00:00:00"   
ORDER by InvoiceDate DESC;	



-- en yeni tarih
SELECT InvoiceDate
FROM invoices
WHERE InvoiceDate BETWEEN "2009-01-01" AND "2011-12-31"
ORDER by InvoiceDate DESC
LIMIT 1;



--  en yeni tarihin alternatif yazilimi
SELECT max(InvoiceDate)
FROM invoices
WHERE InvoiceDate BETWEEN "2009-01-01" AND "2011-12-31";
			          


			
----------------------------  in

-- Between and gibi calisir

-- in ise or gibi calisir

-- birden fazla kosulumuz varsa, bu durumda cok kullanislidir


-- birden cok and'i between kisaltir
-- birden cok or'u da in kisaltir


SELECT FirstName, LastName, country
FROM customers
WHERE country in("Belgium", "Norway", "Canada", "USA");

-- dikkat:  in kullaniminda parantez kullanilir.
-- her bir isim ayri bir string icerisinde




----------------------------  Like operator

-- bir sorgu icerisinde specific birsey cekmek istiyorsak

-- mesela ismi "g" ile baslayanlar


-- sayisal degerler ile like kullanilamaz
-- string ile kullanmamiz gerekir


-- %   birden cok karakterin yerini tutar
-- linux deki * gibi


--  "_" ise tek bir karakterin yerini tutar
-- linux deki ? ile aynidir


-- like operatöründe kullanimlar case sensitiv dir

-- yada upper lower lar ile kendimize göre uyarlayabiliriz




SELECT name, Composer
FROM tracks
WHERE Composer like "%Bach";

			

--- Not: Yukarida edit pragmas butonuna tiklayip,
-- like'in case sensitive olup olmamasi gerektigini secebiliriz
-- eger case sensitive yaparsak, ""  icerisinde girdigimiz
-- tüm degerleri dogru girmemiz gerekir


SELECT *
FROM albums
WHERE Title like "%Greatest%";	



-- 2010 dan 2019 a kadar sadece subattaki invoices lari listeleyin
SELECT *
FROM invoices
WHERE InvoiceDate like "201_-02%";
	  