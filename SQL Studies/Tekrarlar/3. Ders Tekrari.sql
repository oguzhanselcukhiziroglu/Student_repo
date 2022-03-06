------ Soru:

-- ilk ismi 3 harfli olanlar

SELECT FirstName, LastName, City
FROM customers
WHERE FirstName like "___";



--- Soru:
-- soyismi "Go" veya  "Sch"  ile baslayanlar

SELECT FirstName, LastName, City
FROM customers
WHERE LastName like "Sch%" or LastName like "Go%";







------------------------   Aggregate Functions

-- büyük miktarda veriyi alip bunlardan tek bir veri
-- return eden func 'lara denir

--  SQLite da 5 adet aggregate func vardir:
-- avg
-- sum
-- count
-- max
-- min

-- ortalama, toplam gibi tek bir deger

--- Count:

-- bir tabloda kac adet satir oldugunu sorgulamada kullanabiliriz

-- invoices tablosunda kac adet fatura vardir:


SELECT count(InvoiceId)
FROM invoices;

--- yada

SELECT count(*)
FROM invoices;


----- sonucumuzun anlasilir birsey olmasi icin 
-- as ile baska bir isim verebiliriz


SELECT count(FirstName) as "number of FirstName"
FROM customers;

-- as yazmasak da as mantigi calisir ancak best practice de 
-- tablo isimleri kisaltilirken join islemlerinde
-- as kullanmayiz ancak sütun isimlerini kisaltirken kullaniriz

SELECT count(FirstName) "number of FirstName"
FROM customers;


-- count func null olan degerleri saymaz


-- eger amacimiz satir sayisini saymaksa, bu durumda 
-- * kullanabiliriz

-- birde primary key null olamayacagindan ve unique olmak 
-- zorunda oldugundan sayim islemlerinde bunu da kullanabiliriz


-- Company sütununda 49 tane Null olan satir vardir
-- Bunlari sayabilmek icin asagidaki sorguyu kullaniriz
-- ancak null olan satirlarda company' yi say dersek 
-- deger Null oldugundan bunu saymaz.
-- mesela Bu satirlarin customer id sini sayabiliriz 

SELECT count(Company)		-- bu sorguda sonuc 0 cikar
FROM customers
WHERE Company is NULL;



SELECT count(CustomerId)
FROM customers
WHERE Company is NULL;


-- yada diger bir secenek:

SELECT count(*)
FROM customers
WHERE Company is NULL;


-- Null undefined bir degerdir yani tanimlanmamistir

-- null kendisine de esit degildir

-- null bir veri tipi olmadigi icin kiyaslamalarda 
-- kullanilamaz


-- invoices tablosunda kac adet fatura vardir??

SELECT count(*)
FROM invoices;

-- Burada * degil de herhangi bir sütun ismi koysaydik
-- Bu durumda bu sütun icerisindeki null lar sayilmayacakti
-- cözüm * yada primary key kullanmaktir

--- peki bir sütunun primary key oldugunu nasil anlariz.
-- database structure butonuna tikladigimizda, burada 
-- invoices tablosunu secersek, InvoiceId nin üzerinde
-- sari anahtar oldugunu görecegizdir
-- gri anahtar ise foreign key dir 

-- database structure da tablo ismi üzerine gelip sag 
-- tikladigimizda modify table secenegi cikar.
-- bu secenek ile tablomuz olusturulurken yazilan kodlarini
-- görebilir ve bu kodlari degistirebiliriz


SELECT count(BillingState)
FROM invoices;


--- Soru:  tracks tablosunda kac farkli composer vardir?


----------- Distinct count

SELECT count(DISTINCT Composer) as number_of_composer
FROM tracks;


-- Soru: invoices tablosunda kac farkli yil vardir?

SELECT count(DISTINCT InvoiceDate) as farkli_yil_sayisi
FROM invoices;






-------------------   min  and  max 


--- bu func'larda tüm sütunu almak zorunda degiliz
-- yine burada da where kullanarak bir aralik alabiliriz


SELECT max(total)
FROM invoices
WHERE InvoiceId BETWEEN 20 and 30;


-- max ve min stringlerde ascii koda göre calisir

SELECT max(BillingCity)
FROM invoices;



-- Soru:  tracks tablosunda, süresi en kisa olan 
-- sarkinin ismini print ediniz


SELECT name as sarki_ismi, min(Milliseconds) as en_kisa_süre
FROM tracks;

-- milisaniye saniyenin 1000 de biridir.
-- bu nedenle su sekilde yazilabilir 


SELECT name, min(Milliseconds)/1000.0
FROM tracks;



-- students tablosunda en düsük ve en yüksek notu print 
-- eden sorguyu yaziniz


SELECT min(Grade) as lowest, max(Grade) as highest
FROM students;





-----------------------  sum and avg

-- sum bir sütunun yada bir araligin toplamini alir
-- avg de ortalama alir


-- invoices tablosunda total in toplami:

SELECT sum(total)
FROM invoices;



-- süresi ortalama süreden uzun olan sarkilari bulalim:

SELECT name, Milliseconds				-- dinamic method  subquery
FROM tracks								-- önce alt sorgu calisir daha sonra üst sorgu
WHERE Milliseconds > (SELECT avg(Milliseconds)
					  FROM tracks);
					  
					  

--- static yöntem  (hard coded)

SELECT round(avg(Milliseconds), 3)
FROM tracks;


SELECT name, Milliseconds
FROM tracks
WHERE Milliseconds > 393599.212;




-- invoices tablosunda 2009 ile 2013 arasindaki toplam faturalar:

SELECT sum(total) as total_invoices
FROM invoices
WHERE InvoiceDate BETWEEN "2009-01-01" and "2013-12-31";



-- Not: sql de de variable atama ve kendi func'imizi yazma 
-- özellikleri mevcuttur




-----------------------  GROUP BY

-- bu bir func degildir clause dur

-- row lari bir row lar grubu icerisine toplar ve
-- her bir grup icin sadece bir deger döndürür

-- tipik olarak aggregate func'lar ile kullanilir


-- syntax su sekildedir:

SELECT column_1, aggregate_func(column2)
from table name
GROUP by column1;

-- Not: grupladigimiz sütunu select kismina koymazsak
-- bu durumda sorgumuz anlamsiz olacaktir

-- Soru: her bir ülkenin supportid toplamini hesaplayalim

SELECT country, sum(SupportRepId)
FROM customers
GROUP by country;


-- group by where den sonra gelir
-- ama order by var ise bundan önce gelir


-- group lamada eger sart yazmaz isek 
-- ascii coda göre siralama yapar


 ---  her bir sanatcinin sarki sayisini bulan sorgu yazalim
 
 SELECT Composer, count(name) as total_track
 FROM tracks
 GROUP by Composer;
 
 
 -- simdi Null olan degerleri haric tutalim:
 
 
 SELECT Composer, count(name) as total_track
 FROM tracks
 WHERE name is NOT NULL and Composer is NOT NULL
 GROUP by Composer;
 
 
 
 -- customer tablosundaki müsterilerin sayilarini ülkelerine göre 
-- gruplandirarak ve müsteri sayisini azalan sekilde 
-- yazdiriniz:


SELECT country, count(FirstName) as total_number
FROM customers
GROUP by country
ORDER by total_number DESC;


-- as kullanmaz isek:

SELECT country, count(FirstName)
FROM customers
GROUP by country
ORDER by count(FirstName) DESC;


-- Not: sayisi 1 olanlara bakarsak, esitlik durumunda
-- ascii koda göre siralama yapti



-- simdi de ayni soruyu sehir ve ülkelerine göre
-- gruplandirarak yapalim:

SELECT country, City, count(FirstName) as total
FROM customers
GROUP by country, City;
 


 
 -- invoices tablosunda herbir ülkenin (BillingCountry)
 -- fatura ortalamalarini hesaplayan ve ülke bilgileri
-- ile listeleyen sorguyu yaziniz


SELECT BillingCountry, round(avg(total), 3)
FROM invoices
GROUP by BillingCountry;



-- ayni soruyu kosul ile yapalim:
-- fatura tarihleri 2009 ila 2011 arasi yapalim


SELECT BillingCountry, round(avg(total))
FROM invoices
WHERE InvoiceDate BETWEEN "2009-01-01" and "2011-12-31"
GROUP by BillingCountry;






-----------------------------  JOINS

-- iliskisel veri tabanlarinda birden cok tabloyu
-- birbirine baglamada kullanilir

-- iki farkli tablodan veri cekme islemi iki farkli sekilde
-- yapilabilir. ya join yada subquery

-- bir tablodan birsey baska bir tablodan baska birsey
-- alip tek sorguda sorgulama islemi


-- join islemi foreign keyler ve primary keyler ile gerceklestirilir


-- Dikkat: iki tablo birbiri ile iliskilendirilirken
-- ikinci tabloda baglanilan veri primary key olmak 
-- zorundadir. yani ilk tabloda baglanti foreign KEY
-- ikinci tablodaki primary key ile baglanir
-- diger platformlarda bu bir zorunluluk degildir
-- sadece SQlite da böyledir. Bu nedenle sqlite 
-- tüm join islemlerini desteklemez

--- sqlite sadece inner join, left join ve CROSS
-- join i destekler


--  ilk tablodaki foreign key ikinci tablodaki primary 
-- key olmak zorunda oldugundan ve primary key unique 
-- oldugundan, ikinci tablodaki primary key sütununda
-- birinci tablodaki foreign key sütununda olmayan 
-- birsey mevcut olamaz. böyle bir ihtimal yoktur.
-- ve right join de sadece sagdaki tabloyu al demek oldugundan
-- sqlite da right join mümkün degildir


-- inner join kesisim
-- left join soldaki tablo
-- full hepsini al (ancak sqlite da right mümkün olmadigindan
-- full da mümkün degildir)
-- right sag tablo 

-- on ile iki tablo arasindaki baglayici etkiyi yazmazsak 
-- sorgu calismaz



-- ikiden fazla tablo da join ile birlestirilebilir
-- syntax su sekildedir

select columns
from table_a
inner JOIN TABLE_b
on conditions1 and conditions2
inner join table_c
on condition3 or condition4;
 

 
 --- join islemi bir sorgu oldugu icin ciktisi anliktir
 -- yani bir yere kaydedilmez
 
 
 -- Not: left join soldaki tabloyu alir dedigimizde;
 -- soldaki tablonun tüm sütunlarini alir olarak algilamamamiz 
 -- gerekir. Bu ifade söyle anlasilmadlidir
 -- bizim yazdigimiz sorguda, left join e ait sütunlarin 
 -- icerisinde bulunan tüm row lari getirir.
 
 -- mesela soldaki tablonun bir sütununda 5 sagdaki tablonun
 -- ayni sütununda 4 tane row var diyelim.
 -- bu durumda inner join de toplam 4 tane row gelir yani
 -- iki tablonun kesisimleri. left join de ise toplam
 -- 5 tane row gelir. bu durumda kesisim alinmaz
 -- bunun yerine soldakinin sayisi kadar row alinir
 -- karsiligi olmayanlarin row larinda NULL yazacaktir
 
 

 
-- araclar.db veritabaninda markalar ve siparisler
-- tablolarindaki marka_id si ayni olan kayitlarin marka_id
-- marka_adi, siparis_adedi ve siparis tarihi 
-- bilgilerini listeleyen sorgu yaziniz


SELECT markalar.marka_id, markalar.marka_adi,
siparisler.siparis_adedi, siparisler.siparis_tarihi
FROM markalar
INNER JOIN siparisler
on markalar.marka_id = siparisler.marka_id;



-- Not: sadece join yazarsak default'u inner dir


-- simdi ise ayni soruyu left join ile yapalim

SELECT markalar.marka_id, markalar.marka_adi,
siparisler.siparis_adedi, siparisler.siparis_tarihi
FROM markalar
LEFT JOIN siparisler
on markalar.marka_id = siparisler.marka_id;



-- Not: calistigimiz sql dosyasini github a yüklemek icin en kolay yöntem,
-- bu dosyanin bulundugu yerde gitbash hear deriz ve git add ve commit yaparak 
-- göndeririz