    CREATE TABLE calisanlar(
        id CHAR(4),
        isim VARCHAR2(50),
        maas NUMBER(5),
        PRIMARY KEY (id)
    );

    INSERT INTO calisanlar VALUES('1001', 'Ahmet Aslan', 7000);
    INSERT INTO calisanlar VALUES( '1002', 'Mehmet Yılmaz' ,12000);
    INSERT INTO calisanlar VALUES('1003', 'Meryem ', 7215);
    INSERT INTO calisanlar VALUES('1004', 'Veli Han', 5000);
 
    SELECT * FROM calisanlar;

    CREATE TABLE aileler(
        id CHAR(4),
        cocuk_sayisi VARCHAR2(50),
        ek_gelir INTEGER,
       FOREIGN KEY (id) REFERENCES calisanlar(id)
    );
    
    INSERT INTO aileler VALUES('1001', 4, 2000);
    INSERT INTO aileler VALUES('1002', 2, 1500);
    INSERT INTO aileler VALUES('1003', 1, 2200);
    INSERT INTO aileler VALUES('1004', 3, 2400);
    
    SELECT * FROM aileler;

    -- 2) Veli Han'ın maaşına %20 zam yapınız.
    UPDATE calisanlar
    SET maas = maas * 1.2
    WHERE isim = 'Veli Han';
    
    SELECT * FROM calisanlar;

   -- 3) Maaşı ortalamanın altında olanlara %20 zam yapınız.
    UPDATE calisanlar
    SET maas = maas * 1.2
    WHERE maas < (SELECT AVG(maas) 
                  FROM calisanlar); 
    
    SELECT * FROM calisanlar;
    
    -- 4) calisanların isim ve cocuk_sayisi'ni listeyen sorguyu yazınız.
    SELECT isim, (SELECT cocuk_sayisi FROM aileler
                 WHERE calisanlar.id = aileler.id) as cocuk_sayisi
    FROM calisanlar;
    
    -- Alternatif yol
    SELECT isim, cocuk_sayisi FROM calisanlar, aileler
    WHERE calisanlar.id = aileler.id; 
 
    -- 5) calisanlar' ın  isim ve toplam_gelir'lerini gösteren bir sorgu yazınız. 
          -- toplam_gelir = calisanlar.maas + aileler.ek_gelir 
    
    SELECT id, isim, (SELECT maas + ek_gelir FROM aileler
                      WHERE calisanlar.id = aileler.id) as toplam_gelir
    FROM calisanlar;
    
    -- Alternatif yol
    SELECT isim,(maas+ek_gelir) as toplam_gelir
    FROM calisanlar, aileler  
    WHERE calisanlar.id = aileler.id;
     
    -- 6) eğer bir ailenin kişi başı geliri 2000 TL den daha az ise o çalışanın
           -- maaşına ek %10 aile yardım zammı yapınız. 
           -- kisi_basi_gelir = toplam_gelir / cocuk_sayisi + 2 (anne ve baba)
    
    UPDATE calisanlar 
    SET maas = maas * 1.1    
    WHERE (SELECT (maas + ek_gelir)/(cocuk_sayisi + 2) FROM aileler
          WHERE calisanlar.id = aileler.id) < 2000;  
    
    SELECT * FROM calisanlar;

     
    