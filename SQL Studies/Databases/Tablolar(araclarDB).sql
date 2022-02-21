
/* SQLite Browser Üzerinde yeni bir veritabanı (New Database) açıp 
adını araclar olarak kaydederiz. Sonrasında ise aşağıdaki SQL komutlarını
çalıştırarak markalar ve siparisler adında 2 tablo oluşturmuş oluruz. 
JOIN işlemlerinde kullanılan araclar.db bu şekilde oluşturulmuştur */

CREATE TABLE siparisler(
 id INTEGER NOT NULL,
 marka_id INTEGER NOT NULL,
 siparis_tarihi	DATE,
 siparis_adedi INTEGER,
 FOREIGN KEY(marka_id) REFERENCES markalar(marka_id),
 PRIMARY KEY(id)
);

CREATE TABLE markalar(
 marka_id	INTEGER NOT NULL,
 marka_adi VARCHAR,
 PRIMARY KEY(marka_id)
);

INSERT INTO markalar(marka_id,marka_adi) VALUES(1001, "HONDA");
INSERT INTO markalar(marka_id,marka_adi) VALUES(1002, "TOYOTA");
INSERT INTO markalar(marka_id,marka_adi) VALUES(1003, "FIAT");
INSERT INTO markalar(marka_id,marka_adi) VALUES(1004, "RENAULT");
INSERT INTO markalar(marka_id,marka_adi) VALUES(1005, "TOGG");

INSERT INTO siparisler("id", marka_id, siparis_tarihi,siparis_adedi) VALUES(11,1001, "2021-01-02", 200);
INSERT INTO siparisler("id", marka_id, siparis_tarihi,siparis_adedi) VALUES(12,1001, "2021-03-15", 555);
INSERT INTO siparisler("id", marka_id, siparis_tarihi,siparis_adedi) VALUES(13,1003, "2021-10-22", 300);
INSERT INTO siparisler("id", marka_id, siparis_tarihi,siparis_adedi) VALUES(14,1003, "2021-05-23",700);
INSERT INTO siparisler("id", marka_id, siparis_tarihi,siparis_adedi) VALUES(15,1004, "2021-07-30", 144);



	 
	 
	 
	 
	 