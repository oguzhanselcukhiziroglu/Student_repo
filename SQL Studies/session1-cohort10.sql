/*================================================================================
										SELECT
================================================================================*/
/*tracks tablosundaki track isimlerini (name) sorgulayınız*/
SELECT name FROM tracks;

/*tracks tablosundaki besteci (composer) ve şarkı isimlerini (name) sorgulayınız*/
SELECT Composer, name FROM tracks;

/*tracks tablosundaki tüm bilgileri sorgulayınız*/
SELECT * FROM tracks;

/*================================================================================
										DISTINCT
================================================================================*/
/*tracks tablosundaki composer bilgilerini sorgulayınız (TEKRARLI OLABİLİR)*/
SELECT Composer FROM tracks;

/*tracks tablosundaki composer bilgilerini sorgulayınız (TEKRARSIZ)*/
SELECT DISTINCT Composer FROM tracks;

/*tracks tablosundaki AlbumId ve MedyaTypeId bilgilerini TEKRARSIZ olarak
sorgulayınız*/
SELECT DISTINCT AlbumId, MediaTypeId FROM tracks;
/*================================================================================
										WHERE
================================================================================*/
/*Composer'ı Jimi Hendrix olan şarkıları sorgulayınız*/
SELECT Name FROM tracks WHERE Composer = 'Jimi Hendrix';

SELECT Name
FROM tracks
WHERE Composer = 'Jimi Hendrix';

/*invoices tablosunda Total değeri 10$'dan büyük olan faturaların tüm bilgilerini
sorgulayınız*/

SELECT *
FROM invoices
WHERE Total > 10;

SELECT CustomerId, InvoiceDate, total
FROM invoices
WHERE Total > 10;