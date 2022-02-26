/* araclar.db adındaki veritabanını kullanarak Markalar ve Siparisler tablolarındaki 
 marka_id'si ayni olan kayıtların marka_id, marka_adi, siparis_adedi ve siparis_tarihi   
 bilgilerini  listeleyen bir sorgu yaziniz.*/
 
	 SELECT * FROM markalar;
	 SELECT * FROM siparisler;
	 
	 SELECT m.marka_id,m.marka_adi, s.siparis_adedi, s.siparis_tarihi
	 FROM markalar m
	 JOIN siparisler s
	 ON m.marka_id = s.marka_id;
 
 /* ÖDEV: Chinook veritabanındaki tracks tablosunda bulunan her bir şarkının türü (genre)
listeleyiniz.*/

	SELECT * FROM tracks;
	SELECT * from genres;
	
	SELECT t.Name as song_name, g.Name as song_genre
	FROM tracks t
	JOIN genres g
	ON t.GenreId = g.GenreId;
	
	SELECT t.Name as song_name, g.Name as song_genre
	FROM tracks t
	LEFT JOIN genres g /* tabloda ortak olan sutunların iki tabloda da karşılığı varsa ister LEFT join isteer inner JOIN aynı sonucu verir */
	ON t.GenreId = g.GenreId;

	 
 /* ÖDEV: invoice tablosundaki faturaların her birinin müşteri adını (FirstName),
 soyadını (lastName), fatura tarihi (InvoiceDate) ve fatura meblağını (total) 
 listeleyen sorguyu yazınız */
 
	SELECT * From invoices;
	SELECT * FROM customers;
 
	SELECT c.FirstName,c.LastName, i.InvoiceDate, i.total
	FROM invoices i
	JOIN customers c
	on i.CustomerId = c.CustomerId
	
  
	SELECT c.FirstName,c.LastName, i.InvoiceDate, i.total
	FROM invoices i
	LEFT JOIN customers c
	on i.CustomerId = c.CustomerId
	
	/* ÖDEV: artists tablosunda bulunan her bir kişinin albums tablosunda 
	bulunan tüm albümlerinin listeleyen sorguyu yazınız. 
	Sorguda ArtistId, Name, Title ve AlbumId olmalıdır */


	SELECT * from artists;
	SELECT * from albums;
	
	SELECT ar.ArtistId, ar.name, al.Title, al.AlbumId
	FROM artists ar
	JOIN albums al
	on ar.ArtistId = al.ArtistId;
	
	SELECT ar.ArtistId, ar.name, al.Title, al.AlbumId
	FROM artists ar
	Left JOIN albums al /* soldaki tablonun tüm verilerini göster */
	on ar.ArtistId = al.ArtistId;	
	