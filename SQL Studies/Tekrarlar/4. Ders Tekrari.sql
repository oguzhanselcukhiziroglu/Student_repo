-- Günümüzde yüksek seviye diller ile
-- sorgulama yapmak cok yaygindir.
-- yani python yada java gibi dillerle
-- sorgulama yapmak. Burada arada
-- bir cevirici bulunur ve bizim kodlarimizi
-- sql diline cevirir


-- bizim ögrenmedigimiz konular
-- triger
-- prosedürler
-- exceptionlar
-- func'lar


-- cross join kartezyen carpimi return eder

-- full join birlesim kümesi
-- inner da kesisim


-- Not: vs code da ekranin altinda db yazan yere
-- tiklarsak baska bir db secebiliriz


SELECT *
FROM siparisler;

-- 1001 ve 1003  id li arabalardan ikiser adet siparis 
-- verilmistir

-- 1004 den ise sadece 1 tane


-- Bizim alacagimiz verilerin hepsi tek bior tabloda ise o zaman
-- join kullanmamiza gerek yoktur


--- select satirinda sütunlari yazarken birden cok tablo
-- kullandigimiz icin, önce tablo ismi sonra sütun ismi
-- yaziyoruz. eger sütun isimleri tamamen farkli olursa iki
-- tabloda da o zaman yazmasak da olur. ama 
-- best practice de yazmamiz gerekir


-- yazma kolayligi saglamasi icin join islemlerinde
-- tablo isimleri kisaltilabilir

-- Bu islemde, önce kisaltmalari tanimlamak zorundayiz
-- tanimlama islemi de from ve join satirlarinda olur

-- from satirinda tablo1 in kisaltmasi yapilir
-- join satirinda ise tablo2 nin

SELECT m.marka_id, s.siparis_adedi
FROM markalar m 
JOIN siparisler s 
ON m.marka_id = s.marka_id;


-- tablo adi kisaltma islemi, as ile de yapilabilir

SELECT m.marka_id, s.siparis_adedi
FROM markalar as m 
JOIN siparisler as s 
ON m.marka_id = s.marka_id;


SELECT m.marka_id, s.siparis_adedi
FROM markalar as m 
JOIN siparisler as s 
ON m.marka_id = s.marka_id;


-- git branch -m yeni branchadi
-- bu komut ile ana branch imizin adini degistiririz


-- Normalde kullanim su sekildedir.
-- markalar tablosu agirlikli:  left
-- siparisler agirlikli :  right
-- ortak noktalar:  inner
-- hepsi   : full


-- chinook veri tabaninda tracks tablosunda her bir sarkinin
-- türü genre listeleyiniz
-- yani genres tablosu ile tracks tablosu join

SELECT *
FROM genres;

SELECT *
FROM tracks;


SELECT t.Name as song_name, g.Name as song_genre
FROM tracks t 
JOIN genres g 
ON t.GenreId = g.GenreId;


-- Burada left join de yapsak ayni sonucu
-- alacagizdir. yani ilk tabloda olan hersey
-- ikinci tabloda da bulunmaktadir
-- yani null yok demektir



-- Soru:  invoice tablosunda faturalarin her birinin
-- first name lastname fatura tarihi
 -- ve fatura meblagini total
-- listeleyen sorgu yaziniz
-- diger tablo customers olmali

SELECT *
from invoices;

SELECT *
FROM customers;



SELECT c.FirstName, c.LastName, i.InvoiceDate, i.Total
FROM customers c 
JOIN invoices i 
on c.CustomerId = i.CustomerId;


-- Burada da left join yaparsak birsey degismez

-- simdi de ayni soruyu, isim ve soyisimleri gruplandirip
-- yapalim.. yani her bir isim ve soyismin toplami ne kadar
-- onu bulalim

SELECT c.FirstName, c.LastName, sum(i.Total)
FROM customers c 
JOIN invoices i 
on c.CustomerId = i.CustomerId
GROUP BY c.FirstName, c.LastName;



--- Soru: artists tablosunda bulunan  her bir kisinin
-- albums tablosundaki tüm albümlerini listeleyen sorgu.
-- sorgu da artistid, name, title ve albumid olmali

SELECT *
FROM artists;


SELECT ar.ArtistId, ar.Name, al.Title, al.AlbumId
FROM artists ar 
JOIN albums al 
ON ar.ArtistId = al.ArtistId;


-- left yaparsak sayi artar

SELECT ar.ArtistId, ar.Name, al.Title, al.AlbumId
FROM artists ar 
LEFT JOIN albums al 
ON ar.ArtistId = al.ArtistId;


-- simdi artist isimlerini gruplandirarak her bir sarkiciya 
-- ait kac tane albüm oldugunu hesaplayalim

SELECT ar.ArtistId, ar.Name, count(al.AlbumId)
FROM artists ar 
JOIN albums al 
ON ar.ArtistId = al.ArtistId
GROUP BY ar.ArtistId, ar.Name;


-- title lari da count yapabiliriz

SELECT ar.ArtistId, ar.Name, count(al.Title)
FROM artists ar 
JOIN albums al 
ON ar.ArtistId = al.ArtistId
GROUP BY ar.ArtistId, ar.Name;



--- not: eger soldaki tablo ile sagdaki tablonun
-- sorgudaki yerlerini degistirirsek ve daha sonra left 
-- join yaparsak bu durumda zorlama ile right join
-- yapmis oluruz


--  SQLite'in sorguyu calistirma sirasi:

-- from + join
-- where
-- group by
-- having
-- select
-- order by
-- limit



-- subquery = nested query = inner query

-- önce icteki sorgu calisir

-- ic ice sorgularda icteki ve distaki sorgular 
-- farkli tablolardan olabilir


-- icteki sorgu tek deger döndürüyorsa bu single row dur

-- birden cok deger döndürüyorsa multiple row dur


-- Soru:  Albums tablosunda, "Minha Historia"
-- isimli Title'in ait oldugu artistin artist id sinden
-- daha büyük olan artist id lere ait id lerin
-- artists tablosundaki namelerini yazalim
-- Bu isme ait id 17
-- yani 17 den büyük olanlar gelecek

SELECT ar.Name, al.ArtistId
FROM artists ar 
JOIN albums al 
ON ar.ArtistId = al.ArtistId
WHERE ar.ArtistId > (SELECT albums.ArtistId
                     FROM albums
                     WHERE Title = "Minha Historia");




-- ic ice 3 sorgu da olabilir

-- single row alt sorgularda genellikle > < = gibi
-- operatörler kullanilir



SELECT ar.Name, al.ArtistId
FROM artists ar 
JOIN albums al 
ON ar.ArtistId = al.ArtistId
WHERE ar.ArtistId > (SELECT albums.ArtistId
                     FROM albums);


-- mülakatta cikabilir
-- aggregate func'lar nelerdir?





------------ subquery



-- Soru: album title'i faceless olan
-- sarkilarin track id, track name ve album id 
-- sini gösteren sorguyu yazalim


-- simdi join ile cözelim
-- join de sart kullanacagiz

SELECT t.TrackId, t.Name, a.AlbumId, a.Title
FROM tracks t 
JOIN albums a 
ON t.AlbumId = a.AlbumId
WHERE a.Title = "Faceless";



-- eger tek bir kosulumuz varsa bu durumda where kullanmak yerine
-- on icerisinde and de kullanabiliriz

SELECT t.TrackId, t.Name, a.AlbumId, a.Title
FROM tracks t 
JOIN albums a 
ON t.AlbumId = a.AlbumId AND a.Title = "Faceless";




-- simdi ise subquery ile
-- önce albums tablosunda title'i faceless olan  album id lerini bulacagiz
-- bunu kullanarak subquery kullanarak, bu degere esit olan
-- kayitlari bulacagiz: 

-- Faceless in albumid si 88


SELECT TrackId, Name, AlbumId
FROM tracks
WHERE AlbumId = (SELECT AlbumId
                 FROM albums
                 WHERE Title = "Faceless");




-- Not: eger group by kullandigimizda sartimiz varsa
-- bu durumda having kullaniriz. ve syntax'i group by dan sonra gelir
-- group by da sart icin where kullanilirsa hata verir



SELECT Name, AlbumId
FROM tracks
GROUP BY AlbumId
HAVING AlbumId > 3;






-------  multiply row subquery


-- bu tipteki alt sorgu birden cok output return ettigi icin
-- = kullanmak mümkün olmayacaktir


-- in, not in, all, any kullanilir





--- soru:  albums tablosundaki title sütunu Faceless
-- yada "Let There Be Rock" olan kayitlarin
-- albumidlerini elde ederek tracks tablosunda bu id lere 
-- esit olan kayitlarin bilgilerini subquery
-- kullanarak listeleyiniz. trackid, name ve albumid
-- bilgileri olmali



SELECT TrackId, Name, AlbumId
FROM tracks
WHERE AlbumId in (SELECT AlbumId
                 FROM albums
                 where Title = "Faceless" or Title = "Let There Be Rock");



--- ikinci bir secenek olarak, alt query de de in kullanabiliriz


SELECT TrackId, Name, AlbumId
FROM tracks
WHERE AlbumId in (SELECT AlbumId
                 FROM albums
                 where Title in("Faceless", "Let There Be Rock"));


-- in kullandigimizda birden cok secenek oldugu icin
-- burada parantez kullanmak zorundayiz





--- Önemli: from satirinda birden cok tablo kullanabiliriz
-- mesela ciktidaki sütunlarimiza bir de title ekleyelim


-- Önemli: bu islem mümkün ama biraz karisik. 
-- eger where deki = olan ilk sart kullanilmazz ise bu durumda
-- yaklasik 6000 tane sonuc return eder

-- ve where deki iki sart arasinda and kullanilir

-- yani burada su ortaya cikiyor: 
-- join siz ve subquery siz iki tablodan veri alinabiliyor


SELECT tracks.TrackId, Name, tracks.AlbumId, albums.Title 
FROM tracks, albums
WHERE tracks.AlbumId = albums.AlbumId AND
                 tracks.AlbumId in(SELECT AlbumId
                 FROM albums
                 where Title in("Faceless", "Let There Be Rock"));










---------------------  SQL Statements

--- DDL: Data definition language
--- DML: Data manipulation Language
--- DCL: Data control language
--- TCL: Transaction Control Language


--- select DML kismina girer

--- DML tablodaki verilerle ugrasir

-- DDL arabanin kaportasi, DML ise ic aksan


--- Mesela bir kullaniciya yetki verme, kullanici ekleme
-- privilage lar DCL e girer


-- transaction komutlari:
-- mesela iki tane tablo olusturuyoruz bunlardan bir tanesi
-- calsimiyor. bu nedenle rollback komutu ile 
-- tüm islemleri geri aliyoruz. Bu transaction a 
-- bir örnektr



-- DCL i daha cok database adminler kullanir. mesela
-- ekipe yeni bir adam katildi buna yetki verecegiz







-------------------- DDL

-- DB shemasini belirler

-- create, alter, drop gibi komutlar kullanilir

-- DDL statements lar, daha cok bir database kurulurken
-- yada configure edilirken yani veri yerlestirmeden
-- önce kullanilir


-- alter var olan bir tablonun verilerini degistirir
-- tablo adini degistir, bir tabloyu tamamen sil gibi

-- create ise sifirdan bir tablo olusturur

-- mesela bir tablonun bir sütununun veri tipi text olmus
-- biz bunu string yapmak istiyoruz. Burada alter table
-- ile degistiriyoruz


-- mesela bir tabloya yeni bir sütun eklemek istiyoruz
-- bu durumda alter table add diyoruz


-- drop ise tabloyu siler.
-- tablo silmenin bir diger yolu ise;
-- database structure da tablo ismine sag tiklayip
-- delete table demektir


-- Önemli: tablo ismine sag tikladigimizda, karsimiza bir de
-- copy create statements secenekleri cikar. 
-- buradaki komutlari kopyalayip baska bir tablo 
-- olusturmak icin de kullanabilirz




-- DML:

-- Burada artik tablo icerisinde var olan veri ile 
-- ilgileniyoruz. 

-- Dml komutlarinda tablo ayni kalir

-- Insert: tablo icerisine veri yerlestirir

-- Update: var olan veriyi günceller

-- Delete: tablo icerisinde bir veri siler
-- Tablo ise drop ile silinir

-- Select: secer

-- Bazi kaynaklarda select ayri bir kategoride tutulur.
-- cünkü select manipule yapmaz.

-- select e Data Query language derler



-- Data Control Language:

--- Buradaki ifadeler:

-- Revoke: yetkiyi geri almak

-- Grant: yetki vermek






------ Transaction Control Language:

-- Buradaki bazi ifadeler:

--- commit: birkac islemden sonra commit yapmakta fayda var
-- rollback
-- savepoint: calisma yaptigimiz belirli bir noktaya 
-- kadar kaydet. eger silinirse geri getirebilelim




--- sql de tablo olustururken her bir sütunun veri tipini
-- secmek zorundayiz. 

-- sql de bircok veri tipi vardir ancak 3 kategoride 
-- siniflandirilir


-- string
-- Date and Time
-- Numeric (int, float)


-- string data types ise sunlardir:

-- char
-- varchar
-- binary
-- varbinary
-- blob
-- enum
-- set




-- varchar ile char arasinda ne fark vardir?

-- kullanim su sekildedir:

-- isim char(20)
-- isim varchar(20)

-- char kullandigimizda "ali" yazdigimizda bellekte
-- yine 20 byte lik yer kaplar
-- varchar da ise 3 byte lik yer kaplar
--
-- char da, parantez icerisinde yazdigimiz rakam 
-- kadar allocate yapar yani yer ayirir

-- ancak ikisi de string icin kullanilir

-- varchar daki var  variable dan gelir


-- varchar veri tipinde maximum  65535 karakter girilebilri

-- char da bu aralik 255 e kadar dir. klasik ascii modeli

-- SQLite da ise text adinda bir veri tipi vardir

-- parantez kullanmamiza gerek yoktur sadece text yazmamiz yeterli



-- Date and Time Data Types:

-- Date:  2019-05-03

-- Datetime:  2019-05-03  23:59

-- Timestamp: 2019-05-03  23:59 buranin devami da gelir

-- Year:      2019





--- Numeric Data Types:

------------- Integer Types:

-- Integer or Int
-- smallint
-- tinyint
-- mediumint
-- bigint

-- SQL bunlarin tamamina integer der. 
-- ama bunlarin hepsini destekler , problemsiz calistirir




------------- Fixed- Point Types

-- Decimal
-- Numeric




--------------- Floating Point Types:

-- Float
-- Double

-- SQL bunlara Real der ve ikisini de destekler











-----------------------  Create Table


-- syntax su sekildedir:

CREATE TABLE table_name
    (column_name1 data_type
    column_name2 data_type);



--- örnek:


CREATE TABLE employee 
    (first_name varchar(15),
    last_name varchar(20),
    age INT,
    hire_date DATE);

-- Dikkat: tablo isminden sonra parantez
-- burada varchar yerine text de yazabilirdik


SELECT *
from employee;


-- sqlite varchar i  da kabul eder

-- Not: normalde tablo olusturma komutunda veri tabani da yazariz
-- burada sartimiz sudur:
-- yazmis oldugumuz veri tabani attach yapilmis olmalidir
CREATE TABLE "chinook"."calisanlar"
    (erkekler text
    kadinlar text);

-- ancak veri tabani yazmaz isek bu durumda acik olan
-- veri tabaninda tablo olusturur


-- Soru: personel adinda bir tablo olusturalim. 
-- tabloda first_name, last_name, age INT ve hire_date Date
-- sütunlari bulunmali


CREATE TABLE calisanlar
    (first_name text,
    last_name text,
    age INT,
    hire_date Date);



-- simdi sqlite da database structure diyerek tabloyu inceleyelim

-- Not: Tablo olusturmak icin kod yazmak zorunda degiliz
-- database structure da modify diyerek orada tabloyu 
-- sekillendirebilir yeni sütunlar satirlar ekleyebiliriz



-- sqlite da modify dedigimizde, burada tablonun sütunlari
-- üzerinde ayarlama yapabiliriz
-- Burada bulunan ifadelerin anlamlari

-- NN:  Not null
-- PK:  Primary key
-- AI:  Autoincrement
-- U :  Unique

-- Add tusu ile yeni sütun eklenir

-- Burada bir sütunu foreign key yapma sansimiz da vardir

-- sari renk: primary key
-- gri renk: foreign key


-- Database structure a tikladigimizda, ekranin sol üstünde
-- create table tusu bulunur. Bu tus ile yeni bir tablo
-- sifirdan olusturulabilir (kod yazmadan)

-- Burada tablo olusturdugumuzda, yine buradaki arayüz de 
-- otomatik olarak bizim olusturdugumuz tablonun kodlari da
-- yazilacaktir. eger kod yazmayi unutursak, arayüz vasitasi ile
-- bir tablo olustururuz ve burada cikan kodlara bakarak
-- baska bir tablo olusturabiliriz

-- vs code da ise sadece kod ile yapma secenegimiz vardir


-- tablo olusturduktna sonra ayni kodu bir daha calistirirsak
-- bu durumda hata aliriz. ayni tabloyu birdaha olusturmamasi
-- aslinda güzel bir seydir


-- var olan bir tabloya satir yani row ekleme:

-- browse data secenegine tiklariz
-- Burada tablomuzu seceriz
-- printer isaretinin sagindaki "insert a new row"
--secenegine tiklayarak yeni bir row ekleriz

-- eklenen bu row a ister iki kez tiklayarak sagda acilan
-- pencerede degerleri gireriz. yada tek tiklayarak 
-- direkt yazabiliriz


-- eger tablo olusturdugumuz kodu tekrar calistirdigimizda hata
-- almak istemiyorsak bu durumda su kod kullanilabilir:

CREATE TABLE IF NOT EXISTS calisanlar
    (first_name text,
    last_name text,
    age INT,
    hire_date Date);





--- Soru: vacation_plan adinda bir tablo olusturalim
-- sütun isimleri su sekilde olsun:

-- place_id, country,  hotel_name, employee_id, 
-- vacation_length, budget



CREATE TABLE IF NOT EXISTS vacation_plan
    (place_id integer,
    country varchar(20),
    hotel_name text,
    employee_id integer,
    vacation_length integer,
    budget integer);








----------------  Tablo silme:


DROP TABLE personel;

-- simdi alttaki komut hata verir

SELECT *
FROM personel ;


-- eger silme komutu tekrar calistiginda hata almak istemezsek
-- If Exists komutu kullanilabilir


DROP TABLE IF EXISTS personel;

-- dikkat: if existy hemen table dan sonra kullanilir






-- Tabloya kod ile veri girme:



--- Truncate komutu SQLite da bulunmasina ragmen 
-- bu komutu desteklemez. Peki bu komut ne ise yarar
-- TRUNCATE TABLE tablename komutu ile bir tablo icerisindeki
-- tüm verileri sileriz ancak tablo kalir


-- Biz bu komut yerine delete kullaniyoruz






----------------------  Insert into

--- Bir tabloya komut ile veri girme
-- syntax su sekildedir

INSERT INTO table_name
VALUES();

-- bu kodu kullanirken dikkatli olmamiz gerekir:

-- tablo olustururken hangi siralama ile verileri yazdiysak
-- o siralama ile verileri girmemiz gerekir. eger yanlis siralama
-- ile girersek veri tipi uyusmayabilir

-- veri sayisi da tablodaki ile ayni olmalidir
-- yani sütun sayisi kadar veri  girilir

-- ve her bir veri virgül ile ayrilir


-- simdi vacation tablosuna veri girelim:
-- tablo su sekilde idi:
CREATE TABLE IF NOT EXISTS vacation_plan
    (place_id integer,
    country varchar(20),
    hotel_name text,
    employee_id integer,
    vacation_length integer,
    budget integer);


-- Not: degerler girilirken degerlerin ait oldugu sütun isimleri
-- yazilmaz.... sadece girmek istedigimiz degerler sira ile yazilir

INSERT INTO vacation_plan
VALUES ("1234",
        "Holland",
        "marriott",
        "1234",
        "10",
        12345);


SELECT *
FROM vacation_plan;


-- Not: Biz tablomuza henüz bir primary key veya foreign key koymadik.
-- dolayisi ile herhangi bir kisitlamamiz yok. Bu nedenle yukaridaki 
-- veri girme kodunu kac kez yazarsak o kadar row yerlestirmis oluruz. 




-- veri girerken herhangi bir row icin null girebiliriz ancak
-- hicbir degeri bos birakamyiz hata verir


-- kisitlama koymadigimiz sürece null girilebilir

-- not null olsaydi giremezdik



-- Bir tabloda sadece istedigimiz satirlara veri girme sansimiz da vardir
-- mesela ayni tabloda son iki satir haric digerlerine veri girelim:
-- tablo su sekilde idi:

CREATE TABLE IF NOT EXISTS vacation_plan
    (place_id integer,
    country varchar(20),
    hotel_name text,
    employee_id integer,
    vacation_length integer,
    budget integer);


INSERT INTO vacation_plan(place_id,country,hotel_name,employee_id)
VALUES ("abcde", "USA", "hilton", "123");


SELECT *
FROM vacation_plan;


-- Bu kodu calistirdigimizda, veri girmedigimiz satirlar yerine
-- Null girilecektir

-- Bu yöntemin güzelligi, ilk parantez icerisinde sütun isimlerini
-- yazarken siralama ile yazmak zorunda degiliz


-- isimlerin dogru olmasina ve ikinci parantezde siralamanin
-- dogru olmasina dikkat etmeliyiz



------------- Primary key

CREATE TABLE workers (
    id int PRIMARY KEY,
    id_nummer varchar(11) UNIQUE NOT NULL);

-- bu kod da 3 farkli keyword gördük.
-- primary key
-- unique: tekrari olmasin istiyoruz
-- not null: tc kimlik no gibi

-- primary key hem unique hem de not null'i barindirir
-- bu nedenle ayri olarak yazmiyoruz



CREATE TABLE workers (
    id int PRIMARY KEY,
    id_nummer varchar(11) UNIQUE NOT NULL,
    name text DEFAULT "isimsiz");


-- burada ise default'u kullandik. eger bos birakilirsa
-- o zaman default atansin deriz



------------ Primary key (farkli kullanim)

CREATE TABLE workers (
    id int ,
    id_nummer varchar(11) UNIQUE NOT NULL,
    PRIMARY KEY("id"));

-- Burada id'i yukarida tanimladik ancak PK oldugunu
-- en altta yazdik. 



---------- simdi bu tabloya veri girelim:


INSERT INTO workers(1, "12345", "Ahmet", 7000);


INSERT INTO workers(2, "12345", "Mehmet", 8000); -- 2. deger unique olmali Hata


INSERT INTO workers(id, id_nummer, salary)   -- ismi default olarak atar
VALUES (3, "1234567", "Ali", 5000);





---- Soru: vacation_plan tablosunu place_id sütunu
-- PK ve employee_id sütununu ise FK olarak degistirerek
-- vacation_plan2 adinda yeni bir tablo olusturalim. 
-- Bu tablo, employees tablosu ile iliskili olmalidir


CREATE TABLE IF NOT EXISTS vacation_plan2
    (place_id integer,
    country varchar(20),
    hotel_name text,
    employee_id integer,    
    vacation_length integer,
    budget integer,
    PRIMARY KEY("place_id"),
    FOREIGN KEY("employee_id") REFERENCES employees(EmployeeId));  -- dikkat: burada sadece 
                                                                    -- iliskilendirecegimiz tablonun
                                                                    -- ismi degil. sütun adi da yazilir


-- employees tablosunda, employee_id integer oldugu icin bizde integer yapiyoruz
-- yani refere ettigimiz tablo ile bizim verimiz ayni tip de olmak zorundadir


-- asagidaki kod da, ekstradan id adinda bir sütun belirledik ve bunu primary key yaptik. 
-- ve bu otomatik olarak kendisi artan bir deger olacaktir. Bu durumda biz tabloya her veri
-- girdigimizde, bu sütun kismini bos birakacagiz, o kendisi girecektir. Bu demek oluyor ki
-- Biz her seferinde parcali veri girisi yapacagizdir


-- Not: FK ve PK girerken bir tabloda employee_id
-- diger tabloda ise EmployeeId olarak girdik.
-- Ancak bu veriler FK ve PK olarak birbiri ile iliskili
-- Bu nedenle sikinti olmaz. 

CREATE TABLE IF NOT EXISTS vacation_plan2
    (id integer
    place_id integer,
    country varchar(20),
    hotel_name text,
    employee_id integer,    
    vacation_length integer,
    budget integer,
    PRIMARY KEY("id" AUTOINCREMENT),
    FOREIGN KEY("employee_id") REFERENCES employees);


--- foreign key ile baglanan tablolarda, veri girisi veya degisikliklerde
-- dikkatli olmamiz gerekir. Bu tablolar arasinda parent child iliskisi 
-- vardir. eger biz parent'i silmek istersek izin vermez. önce parent'i
-- sil daha sonra child'i sil der


-- Soru: employees tablosundaki EmployeeId'si
-- 1 olan kisi icin bir tatil plani giriniz:


--- tablomuz su sekilde idi:

CREATE TABLE IF NOT EXISTS vacation_plan2
    (place_id integer,
    country varchar(20),
    hotel_name text,
    employee_id integer,    
    vacation_length integer,
    budget integer,
    PRIMARY KEY("place_id"),
    FOREIGN KEY("employee_id") REFERENCES employees(EmployeeId));


INSERT INTO vacation_plan2
VALUES(3, "TR", "Happy Hotel",1, 5, 5660);



-- Employees tablosunda toplam da 8 tane employeeId vardir.
-- ve bu sütun bizim PK mizdir. Eger biz kendi tablomuzdaki FK
-- yani employee_id sütununa 9 kisiyi girmek istersek hata aliriz. 
-- fk ve pk sütunundaki sayi adedi farkli olamaz
-- yani asagidaki kod hata verir

INSERT INTO vacation_plan2
VALUES(4, "TR", "Happy Hotel",9, 5, 5660);


---- önemli: Bizim buradaki place_id miz sadece
-- bizim tablomudaki verinin siralamasini gösteren
-- bir sayidir. yani diger tablolar ile bir iliskisi yoktur. 
-- ancak unique olmak zorundadir. 


-- employee_id ise bizim tablomuzun diger tablolar ile 
-- iliskisini saglayan veridir. Bu nedenle veri girerken
-- eger place_id yi unique olarak giriyorsak, employee_id yi
-- birden cok kez ayni rakam girebiliriz. cünkü bir kisi 
--- birden cok kez farkli farkli yerlere tatile gitmis olabilir. 


--- yani su kod calisir

INSERT INTO vacation_plan2
VALUES(5, "TR", "Happy Hotel",1, 5, 5660);



--- sql genel ekraninin sol üstünde "new database" butonu bulunur. 
-- Bu butona tiklayarak yeni bir database olsuturup burada yeni
-- tablolar olusturabiliirz



-- simdi join ile iki tablodan veri cekelim

SELECT vacation_plan2.employee_id, vacation_plan2.place_id, employees.FirstName, employees.LastName
FROM vacation_plan2
JOIN employees
on vacation_plan2.employee_id = employees.EmployeeId;


--- Burada sart da kullanabilirdik:

SELECT vacation_plan2.employee_id, vacation_plan2.place_id, employees.FirstName, employees.LastName
FROM vacation_plan2
JOIN employees
on vacation_plan2.employee_id = employees.EmployeeId and vacation_plan2.employee_id = 1;


--- create islemi, CRUD operasyonlarindaki create islemidir





------------------ Alter Table: (ADD; RENAME TO; DROP)

-- ADD komutu ile tablomuza yeni bir sütun ekleriz

ALTER TABLE vacation_plan2
ADD Name DEFAULT "isimsiz";




-----------  eklenmis bir sütunu silme
--- DROP COLUMN 

-- Bu komut bazi pc lerde calismiyor

ALTER TABLE vacation_plan2 -- tablo adi
DROP COLUMN name;          -- column name


--- Not: diger sql platformlarinda alter islemleri cok
-- genistir. mesela foreign key ler bile degistirilebilir

-- ancak sqlite da bu islemler cok kisitlidir


--- workers tablosunun adini people olarak degistirelim



------------- tablo ismi degistirme


ALTER TABLE workers
RENAME to "people";   -- burada parantezli de olur parantezsiz de

-- burada to önemli
-- dikkat rename ile tablonun ismini degistiririz




---------------  Update, Delete (Bu komutlar, tablo icerisindeki bir veya birkac veri ile ilgilidir
                                -- Komple tabloyu silme islemi degildir)


UPDATE tablo_adi
SET sütun1 = yeni_deger1, sütun2 = yeni_deger2, ..... 
WHERE kosul 


-- Eger burada where ile kosul girmezsek, bu durumda
-- sütundaki tüm verileri degistirecektir




-------------------------  Delete:

DELETE tablo_name
WHERE Kosul;                --- ayni sekilde burada da kosul kullanmazsak tüm veriler silinir



-- Not: mesela önceden tablomuda bir Foreign key vardi ve biz
-- su an bunu degistirmek yada tamamen kaldirmak istiyoruz
-- bu durum alter'in kapsamina girer. 
-- Cünkü burada tablonun ana yapisini degistiriyoruz ana kaporta degisir
-- bu islem update degildir
-- update de ise sadece birkac veri degisir


-- mesela foreign key sütununda 1 olan bir degeri 2 yapmak istiyorsak
-- bu durumda update kullanilabilir
-- ancak foreign key sütununu komple degistirmek istiyorsak,
-- bu durumda alter kullanilir



UPDATE vacation_plan2
SET hotel_name = "komagene hotel"
WHERE employee_id = 1;



-- people tablosunda salary sütunu 5000 den fazla olanlarin
-- maasina 10% zam yapacak sorguyu yazalim


UPDATE people
SET salary = salary * 1.1
WHERE salary > 5000;


--------------------------  delete

--- asagidaki kodu yazdigimizda, sartin saglandigi
-- row u komple siler



DELETE FROM vacation_plan2
WHERE employee_id = 1;






