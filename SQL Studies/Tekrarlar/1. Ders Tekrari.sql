-- Data Base, verilerin bir bilgisayar sisteminde organize bir sekilde saklanmis halidir
-- bu bir bilgisayar da olabilir server da olabilir


-- Database ile kullanici arasindaki iliski su sekildedir:

-- Database <-> DBMS <-> Language(SQL) <-> Applications <-> User

-- Database tek basina düsünülemez. Bunu yönetecek bir sisteme ihtiyac vardir.
-- Bu sisteme DBMS denir. (Mesela database e kimler erisbilecek, kimin yetkisi olacak, iste bu tarz 
-- islemleri düzenleyen yazilim sistemine dbms denir)

-- Bu dbms islemini yapan bircok firma vardir. Bunlarin baslicalari Oracle, Microsoft SQL 
-- Microsoft access de bir veri tabanidir ama cok basittir ve profesyonel calismalarda kullanilamaz

-- Günümüzde bir database satin aldigimizda yada ücretsiz versiyonlarini kullandigimizda, bunlar
-- dbms ile birlikte gelmektedir.

-- Database dedigimizde 3 sey aklimiza gelir. ve bunlar birlikte kullanilir.
-- DATABASE
-- server
-- dbms

 -- birde SQL dedigimiz language vardir. Nasil bir website yaparken javascript kullaniyorsak
 -- bir database ile iletisime gecmek icin de sql kullaniyoruz. 
 -- mesela yeni bir tablo yapma, veri silme, update etme gibi islemler
 
 -- dbms ler de  sql ile vermis oldugumuz komutlari destekler ve bunlari database e iletir.
 
 --                                              Database'in genel mimarisi
 
 --  client(user)       <->                       API(application programming interface) <->        DATABASE
--  Akilli telefon					görselligi olmayan bir yazilim
--   pc yada labtop					user'in database ile iletisimini
--   endüstriyel pc					kolaylastirmak icin kullanilir
--   tablet

-- Burasi front END																		   		Burasi Backend	
-- yani restaurant					garson 															mutfak

-- kullanici pc, tablet , telefon ile bir talep de bulunur. Ancak bu cihazlarin hepsinin formati farklidir.

-- API bu talepleri alir ve hepsini bir formata dönüstürür ve database e gönderir. Tabi ki 
-- kullanicilarin talep ettikleri dil sql degildir. o nedenle api bu dili bir de sql e cevirir

-- yani api mutfak ile restaurant arasindaki iliskiyi saglar

-- api database e talep gönderirken yada oradan veri cekerken, arka plan da sql dilini kullanir

-- Mesela biz bir internet sitesine girdigimizde register islemi yaptigimizda, bizim girdigimiz kisisel
-- bilgiler api ye gider. api de bunleri sql dili kullanarak database e iletir. eger bir sikinti yasanmaz ise de 
-- verilerimiz database e kayit edilir

--  DBMS:
-- en yaygin olarak kullanilan data base management sistemler oracle ve microsoft sql dir.
-- bunlar ücretlidir

-- ücretsiz piyasasinin hakimleri ise postgre sql ve mysql dir
-- birde sqlite vardir.  Bu cok basit kurulumu cok kolay ve kapasitesi sinirli cihazlarda kullanilir

-- Bunlarin hepsinin sorgulama dili aynidir. hepsi SQL kullanir. veri tabaninin tek bir dili vardir

-- ORM (object relational mapping) sistemleri adinda günümüzde sistemler vardir.
-- bunlar bizim python ile yada java ile yazdigimiz kodlari sql e cevirir.
-- yani bizim yüksek seviyede yazdigimiz kodlari sql e dönüstürür

-- 
-- Iki farki data base vardir.
-- Birincisi SQL tabanli  
-- ikincisi NO SQL tabanli

-- Birincisi relational dir. yani verilerimiz tablo formatinda tutulur. Bunlar klasiktir ve RDBMS olarak adlandirilir
-- verileri cekmek icin SQL kullanilir
-- bunu iliskisel yapan sey tablolar degildir. tablolarin birbirleri ile iliskisinin olmasidir.

-- tüm verilerimizi iceren tek bir tablo yapmak cok mantikli degildir.
-- güvenlik nedeniyle veya baska bir sebeple. performans olabilir
-- Bu nedenle verilerimiz farkli farkli tablolara bönülür ve bu tablolarin hepsin de de ortak olarak bulunan
-- bir veri sütun kullanilir.


-- tablolarda bir primary key bir de fireign key bulunur.

-- primary key her bir tabloda bulunan unique bir degerdir. ve None olamaz. yani bos birakilamaz.
-- mesela ID sütunu bir primary key dir. yada e-devlet de Tc kimlik numarasi
-- e-mail adresi de primary key olabilir ama isim olamaz
-- primary key'i neden kullaniriz. tablodan verilerimizi kolaylikla cekmek icin. 


-- iki tablo arasindaki iliskiyi saglayan sütuna da foreign key denir.
-- iki tablo arasinda ortak bir sütunun olmasi tek basina yeterli degildir. 
-- iki tablo arasindaki iliskiyi saglama icin sql komutlarinda bunu belirtiyoruz

-- primary key tek olmak zorunda degildir. mesela tc kimlik no ve e-mail ayni anda olabilir.
-- ayni sekilde foreign key de birden cok olabilir. cünkü ayni anda birden cok tablo ile 
-- iletisim kurariz.

-- eger iki tablodan ayni anda bilgi cekmeye ihtiyac duyarsak o zaman join kullanacagiz.

-- Bu tablolar hayali tablolardir. Yani binary formatinda hafizada saklanir.

-- günümüzde veriler artik tablodan görsele dönüstü.(video foto) Bu nedenle artik büyük verileri tablolarda tutamiyoruz.
-- Bu nedenle de artik bu veriler icin no sql kullanilir.

-- aslinda sql  de de görsel verileri BLOB dedigimiz sistemde yani binary large object de tutulur ama
-- buna ragmen sql bu veriler icin uygun degildir

-- No sql 2000 li yillarin baslangicinda cikmistir.
-- burada veriler iliskisel olarak tutulmaz. key value seklinde tutulur. (yani python daki dict ler gibi)
-- bir kisinin bilgilerini isterken o kisiye ait key'e ait bilgileri aliriz

-- eger bizim verilerimiz structured ise yani bankalar gibi verilerle isimiz varsa o durumda
-- sql kullanmamiz daha mantikli

-- ancak hiz gözönüne alindiginda, text ve tablo formatinda bile no sql cok cok daha hizli

-- no sql tabanli database lerde dil olarak sql kullanilmaz. Bunun acilimi not only sql dir.
-- bu sistemler python gibi java gibi dillerle dogrudan entegre halde calisir.
-- eger python yada java script biliyorsak iletisime gecebiliriz. 

-- yani yüksek seviye dillerle entegredir

-- no sql ler arasinda en yaygin olanlar
-- mongo db
-- cassandra
-- hadop

-- Edgar Frank 1970 li yillarda klasik data base yapisini ilk olarak yazdigi makalede anlatan kisidir.
-- tablolarin bölünmesi, birbirine baglanmasi gibi hususlari tanimlamistir.

-- klasik sql yapilarini hayata geciren firma oracle dir

-- terminology:

-- tablolara ayni zamanda relation da denilir

-- column yani sütunlara;  field yada attribute denilir

-- row lara yani satirlara ise record denilir

-- icerideki veriye de data yada cell denilir

-- Not: her zaman degil ama tablolar genellikle cogul isimler ile isimlerlendirilir
-- mesela employess

-- sütun isimlerinde python gibi iki kelime arasina _  konulur
-- last_name gibi

-- javascript gibi dillerde ise lastName seklindedir-
-- bunun adi camel case dir.

-- html de ise background-color seklindedir. buna kebapcase denir

-- sql in acilimi structured query language dir.
-- yani asil amaci ve ortaya cikis amaci data base de sorgulama yapmaktir.
-- ancak günümüzde bu dil ile veriler manipule edilebilir.

-- ilk olarak 1970 li yilarda cikmistir. 
-- 1986 ve 1987 yillarinda ise bu dil standart hale getirilmistir.

-- peki bu dil ile veri tabani üzerinde neler yapabiliriz??

--  CRUD operations

-- CREATE
-- retrieve(read)  (oku, sorgula)
-- update 
-- delete 


-- sql dili kurallari:

-- komutlar case sensitive degildir. kücük yada büyük yazilabilir
-- ama string bir verimiz varsa bu durumda bunun ismini ayni sekilde yazmak zorundayiz.

-- sql dil yapisi tamamen ingilizceden esinlenerek yapilmistir

-- select, from, where, order by bunlar keyword dur

-- bu verilerin yanina yazdigimiz tablo isimleri, sütun isimleri gibi isimler ise 
-- identifizier yani belirleyi tanimlayicidirlar

-- komutun bittigi yere ; semi colon koyulur
-- koymasak da calisir ama altina baska bir komut yazdigimizda hata verecektir.
-- cünkü iki komut ayirt edilemeyecektir.


-- Not: sql tabanli database lerde de video saklanabilir ama 
-- no sql ile ayni performans alinamaz

-- tavsiye olarak keywords uppercase
-- identifizier ise lowercase dir
-- bu kurallara BNF notation denir

-- sqlite de hem tek tirnak hem de cift tirnak calisir
-- ama diger ortamlarda sadece tek tirnak calisir

-- Önemli: tarihler de string iceriisnde yer alir. o nedenle format olarak
-- ayni sekilde yazmak zorundayiz.
-- YYYY-MM-DD  formatinda yazilir

--------------------------------

--  Language Elements

-- select   first_name    from     employees;
-- keyword  Identifizier   keyword    identifizier

-- eger tüm verileri cekmek istiyorsak:

-- select * from employees;

select FirstName from employees;

select * from employees;

-- not: komutlar arasinda bosluklar olsa bile kodumuz calisir

-- database acmak icin open database butonu secilir

-- database structure, bize database imizin ana yapisini gösterir
-- ve verilerimizin hangi veri tipine ait oldugunu burada görebiliriz.
-- integer ve nvarchar(string) seklinde veri tiplerimiz vardir.

-- browse data butonu ise structure da gördügümüz yapi icerisindeki tablolari görmemizi saglar

-- en üstte write changes butonu vardir. Bu butona tiklayarak ver itabanimizi degistirebiliriz

-- revert changes e tiklarsak da geri alir

-- yukarida kodu calistir tusu satirinda bulunan tuslarin görevleri:

-- en soldaki yeni bir tab yani sql dosyasi acar
-- soldan ikinci, önceden actigimiz ve üzerinde calistigimiz sql dosyasini acar
-- 3. ise save eder

-- biz sql komutlarimizi execute sql butonu altinda yazariz.

-- tablolar arasindaki iliskiyi gösteren semaya 
-- ERD yani entity relationship diagram denir



select name from tracks;

-- Not: font büyütme islemi:
-- edit > preferences > sql > sql editör font

-- Not: sql de comment yazmanin iki yöntemi vardir.

-- Birincisi su an yaptigimiz sekil
-- ikincisi ise C style dedigimiz /*    */

--  
----------DISTINCT

-- UNIQUE cikti aliriz. Bir isimden ssadece bir kez return edilir

SELECT DISTINCT Composer from tracks;

-- Önemli: eger birden cok column secip distinct kullanirsak
-- bu durumda iki sütunun da esit olmasi gerekir. eger iki sütun birbirine esit degilse
-- bu durumda distinct calismaz

SELECT DISTINCT AlbumId , name from tracks;

-- sadece albumid secilip distinct yapilirsa bu durumda 347 adet satir olur.
-- ama bu ikisini secersek neredeyse tüm satirlar ayni sekilde kalir
-- cünkü iki sütunun birbirine esit olmasi zor bu tabloda

SELECT DISTINCT AlbumId, MediaTypeId from tracks;

-- 348 sonuc


----------------WHERE
-- sartlarda kullanilan isaretler
--  =
-- >
-- <
-- >=
-- <=
-- <>  esit degildir


SELECT * from students WHERE Grade > 70;

SELECT * FROM customers WHERE country = "Brazil";

-- distinct ile where combine edilebilir

SELECT DISTINCT SupportRepId FROM customers WHERE country = "Brazil";

-- kodlarimizi yazmanin diger bir yöntemi:

SELECT name 
FROM tracks 
WHERE Composer = "Jimi Hendrix";


SELECT * 
from invoices 
where Total > 10;



-- Database acma islemi "Open Database" butonu ile

-- programi yeni actigimizda, eskiden calistigimiz kodlari acmak icin de kaydet butonunun solundaki buton kullanilir


-- Visual studio code da, kodumuzu calistimak icin ya sadece saga tiklayip run quwery deriz.
-- Bu durumda tüm kodlari calistirir

-- yada calistirmak istedigimiz kod blokunu seceriz ve saga tiklayip run selected query deriz

SELECT * FROM invoices;

