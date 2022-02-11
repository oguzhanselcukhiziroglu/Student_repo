SELECT t1.x, t2.y, ....
FROM TABLO1 t1
FULL JOIN TABLO2 t2
ON t1.FK = t2.PK;

SELECT m.marka_id,m.marka_adi,
s.siparis_adedi, s.siparis_tarihi
FROM markalar m
INNER JOIN siparisler s
ON m.marka_id = s.marka_id;

SELECT m.marka_id,m.marka_adi,
s.siparis_adedi, s.siparis_tarihi
FROM markalar m
LEFT JOIN siparisler s
ON m.marka_id = s.marka_id;

/* ÖDEV: Chinook veritabanındaki tracks tablosunda bulunan her bir şarkının türü
(genre) listeleyiniz.*/

SELECT * FROM tracks;
SELECT * FROM genres;

SELECT t.name as Song_Name, g.name as Song_Genre
FROM tracks t
JOIN genres g
ON t.GenreId = g.GenreId;

SELECT t.name as Song_Name, g.name as Song_Genre
FROM tracks t
LEFT JOIN genres g
ON t.GenreId = g.GenreId;

 /* ÖDEV: invoice tablosundaki faturaların her birinin müşteri adını (FirstName),
 soyadını (lastName), fatura tarihi (InvoiceDate) ve fatura meblağını (total) 
 listeleyen sorguyu yazınız */
 
SELECT * FROM invoices;
SELECT * FROM customers;

SELECT c.FirstName, c.LastName, i.InvoiceDate, i.total
FROM invoices i
JOIN customers c
ON i.CustomerId = c.CustomerId;

SELECT c.FirstName, c.LastName, i.InvoiceDate, i.total
FROM invoices i
LEFT JOIN customers c
ON i.CustomerId = c.CustomerId;

/* ÖDEV: artists tablosunda bulunan her bir kişinin albums tablosunda bulunan tüm
albümlerinin listeleyen sorguyu yazınız. Sorguda ArtistId, Name, Title ve AlbumId
olmalıdır */

SELECT * FROM artists;
SELECT * FROM albums;

SELECT ar.ArtistId, ar.name, al.Title,al.AlbumId
FROM artists ar
JOIN albums al
ON ar.ArtistId = al.ArtistId;

SELECT ar.ArtistId, ar.name, al.Title,al.AlbumId
FROM artists ar
LEFT JOIN albums al
ON ar.ArtistId = al.ArtistId;

/*================================================================================
				                    SUBQUERIES
================================================================================*/

/* albums tablosundaki Title sutunu 'Faceless' olan kaydın albumid'si elde ederek 
tracks tablosunda bu değere eşit olan kayıtların bilgilerini SUBQUERY yazarak
listeyiniz. Listelemede trackid, name ve albumid bilgilerini bulunmalıdır. */

SELECT * FROM albums;

SELECT TrackId, name, AlbumId
FROM tracks
WHERE AlbumId = (SELECT AlbumId
				 FROM albums
				 WHERE Title = "Faceless");
				 
/* albums tablosundaki Title sutunu 'Faceless' olan kaydın albumid'si elde ederek 
tracks tablosunda bu değere eşit olan kayıtların bilgilerini JOIN kullanarak
listeyiniz. Listelemede trackid, name ve albumid bilgileri bulunmalıdır. */		
				 
SELECT t.TrackId,t.name,t.AlbumId
FROM tracks t
JOIN albums a
ON t.AlbumId = a.AlbumId
WHERE a.Title = 'Faceless';

SELECT t.TrackId,t.name,t.AlbumId
FROM tracks t
JOIN albums a
ON t.AlbumId = a.AlbumId AND a.Title = 'Faceless';
--WHERE a.Title = 'Faceless';

/* albums tablosundaki Title sutunu Faceless veya Let There Be Rock olan
kayıtların albumid'lerini elde ederek tracks tablosunda bu id'lere eşit olan
kayıtların bilgilerini SUBQUERY kullanarak listeyiniz. Listelemede trackid,
name ve albumid bilgileri bulunmalıdır. */	

SELECT TrackId,name,AlbumId
FROM tracks
WHERE AlbumId IN (SELECT AlbumId
				  FROM albums
				  WHERE Title = "Faceless" OR Title = "Let There Be Rock");
				  
SELECT TrackId,name,AlbumId
FROM tracks
WHERE AlbumId IN (SELECT AlbumId
				  FROM albums
				  WHERE Title IN("Faceless", "Let There Be Rock"));

/*================================================================================
				  DDL COMMANDS (CREATE TABLE, DROP TABLE,ALTER TABLE)
================================================================================*/	

/*================================================================================
									CREATE TABLE
================================================================================*/	
	
/*personel adinda bir tablo oluşturunuz.  Tabloda first_name, last_name 
age(INT) ve hire_date (Date) sutunuları bulunmalıdır.*/

CREATE TABLE personel (
	first_name VARCHAR(20),
	last_name TEXT,
	age INT,
	hire_date DATE
);

/* Aynı isimle yeniden bir veritabanı oluşturulmak istenirse hata verir. Bu
hatayı almamak için IF NOT EXISTS keywordu kullanılabilir */

CREATE TABLE IF NOT EXISTS  personel (
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	age INT,
	hire_date DATE
);

/*Veritabanında vacation_plan adında yeni bir tablo oluşturunuz.  Sutun isimleri
place_id, country, hotel_name, employee_id, vacation_length, budget */

CREATE TABLE vacation_plan (
	place_id INTEGER,
	country TEXT,
	hotel_name TEXT,
	employee_id INTEGER,
	vacation_length INT,
	budget REAL
);

/*================================================================================
									DROP TABLE
================================================================================*/

/* personel tablosunu siliniz */

DROP TABLE personel;

/* Bir tabloyu silerken tablo bulunmazsa hata verir. Bu hatayı görmemek için
IF EXISTS keyword'ü kullanılabilir. */

DROP TABLE IF EXISTS personel;

-- NOT: SQL'de TRUNCATE TABLE komutu bulunmasına karşın SQLite bu komutu 
-- desteklememektedir. Truncate komutu  bir tabloyu değil içindeki tüm verileri 
-- silmek için kullanılır.

/*================================================================================
									INSERT INTO
================================================================================*/

/* vacation_plan tablosuna 2 kayıt gerçekletiriniz.*/
	
INSERT INTO vacation_plan VALUES(48,'TR','HAPPY HOTEL', 1, 7, 4500);
INSERT INTO vacation_plan VALUES(34, 'TR', 'Beach Hotel',2, 10, 5000);
INSERT INTO vacation_plan VALUES(12, 'NL', 'COMFORT Hotel',3, 4, 3000);
INSERT INTO vacation_plan VALUES(NULL,NULL,NULL,4,5,NULL);

	
-- NOT: Aynı komut tekrar çalıştırılırsa herhangi bir kısıt yoksa ise aynı veriler
-- tekrar tabloya girilmiş olur. 
	
/*vacation_plan tablosuna vacation_lenght ve budget sutunlarını eksik olarak veri
girişi yapınız*/

INSERT INTO vacation_plan (place_id,country,hotel_name,employee_id) VALUES(35, 'TR', 'İZMİR HOTEL', 6);

/*================================================================================
							CONSTRAINTS - KISITLAMALAR 
================================================================================*/
/*
NOT NULL - Bir Sütunun NULL içermemesini garanti eder. 

UNIQUE - Bir sütundaki tüm değerlerin BENZERSİZ olmasını garanti eder.  

PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin 
BENZERSİZ olmasını garanti eder.(NOT NULL ve UNIQUE birleşimi gibi)

FOREIGN KEY - Başka bir tablodaki Primary Key'i referans göstermek için kullanılır. 
Böylelikle, tablolar arasında ilişki kurulmuş olur. 

DEFAULT - Herhangi bir değer atanmadığında Başlangıç değerinin atanmasını sağlar.
*/
/*------------------------------------------------------------------------------*/

CREATE TABLE workers (
	id INT PRIMARY KEY,
	id_number VARCHAR(11) UNIQUE NOT NULL,
	name TEXT DEFAULT 'NONAME',
	salary INT NOT NULL
);

INSERT INTO workers VALUES(1, '12345678910','AHMET CAN', 7000 );
INSERT INTO workers VALUES( 2, '12345678910', 'MUSTAFA ALİ', 12000);  -- HATA (UNIQUE)
INSERT INTO workers  (id, id_number, salary) VALUES(3, '12345223465', 5000);
INSERT INTO workers VALUES(4, '44343323465' , 'AYHAN BAK',NULL) -- HATA (NOT NULL)

/*vacation_plan tablosunu place_id sutunu PK ve employee_id sutununu ise FK
olarak değiştirirek vacation_plan2 adinda yeni bir tablo oluşturunuz. Bu tablo,
employees tablosu ile ilişkili olmalıdır*/ 

CREATE TABLE vacation_plan2 (
	id INT,
	place_id INTEGER,
	country TEXT,
	hotel_name TEXT,
	employee_id INTEGER,
	vacation_length INT,
	budget REAL,
	PRIMARY KEY(id),
	FOREIGN KEY(employee_id) REFERENCES employees(EmployeeId)
);

/* Employees tablosundaki EmployeeId'si 1 olan kişi için bir tatil planı giriniz.*/
INSERT INTO vacation_plan2 VALUES(1, 34, 'TR', 'HAPPY HOTEL', 1, 5, 5660);
	
/* Employees tablosunda bulunmayan bir kişi için (EmployeeId=9) olan kişi için
bir tatil planı giriniz.*/
INSERT INTO vacation_plan2 VALUES(2, 48, 'TR', 'COMFORT HOTEL', 9, 10, 7000);  --HATA
INSERT INTO vacation_plan2 VALUES(3, 48, 'TR', 'COMFORT HOTEL', 8, 5, 5000);
INSERT INTO vacation_plan2 VALUES(4, 42, 'TR', 'COMFORT HOTEL', 1, 6, 4000);

/* JOIN işlemi ile 2 tablodan veri çekme */

SELECT e.FirstName, e.LastName, v.hotel_name, v.vacation_length
FROM employees e
JOIN vacation_plan2 v
ON e.EmployeeId = v.employee_id AND v.employee_id = 1;

/*--------------------------------------------------------------------------*/
/*  ALTER TABLE (ADD, RENAME TO, DROP)
/*  SQLITE MODIFY VE DELETE KOMUTLARINI DOĞRUDAN DESTEKLENMEZ
/*--------------------------------------------------------------------------*/
	
/*vacation_plan2 tablosuna name adında ve DEFAULT değeri noname olan 
yeni bir sutun ekleyelim */

ALTER TABLE vacation_plan2
ADD name TEXT DEFAULT 'isimsiz';

/*vacation_plan2 tablosundaki name sütununu siliniz.*/
ALTER TABLE vacation_plan2
DROP COLUMN name;

/* workers tablosunun adını people olarak değiştiriniz */
ALTER TABLE workers
RENAME TO people;

/*--------------------------------------------------------------------------*/
/*  UPDATE,DELETE
		-- SYNTAX
		----------
		-- UPDATE tablo_adı
		-- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...  
		-- WHERE koşul;
		
		--DELETE tablo_adı
		--WHERE koşul;
/*--------------------------------------------------------------------------*/
   
/*vacation_plan2 tablosundaki employee_id=1 olan kaydini  hotel_name'ini
Komagene Hotel olarak güncelleyiniz.*/

UPDATE vacation_plan2
SET hotel_name = 'Komagene Hotel'
WHERE employee_id = 1;

/* people tablosunda salary sutunu 5000 'den fazla olanların salary(maaşına)
%10 zam yapacak sorguyu yazınız*/

UPDATE people
SET salary = salary * 1.1
WHERE salary > 5000;
