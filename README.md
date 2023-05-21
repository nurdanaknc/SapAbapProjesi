# Veri Tabloları

##Çalışan Tablosu (ZCALISAN_TABLOSU)
![Çalışan Tablosu](/resimler/calisan_tablosu.png "Çalışan Tablosu")

Yukarıda ZCALISAN_TABLOSU gösterilmektedir.
Bu tablo bu projedeki çalışan adı soyadı ve id gibi verileri tutar. 
Bu tabloda Key değeri CAL_ID 'dir. 
Aşağıda bu tablonun tuttuğu veriler gösterilmektedir. İstenirse veri büyüklüğü arttırılabilir.
![Çalışan Tablosu İçerik](/resimler/calisan_tablosu_i.png "Çalışan Tablosu İçerik")

##Çalışan Adresi Tablosu (ZCALISAN_ADRES)
![Çalışan Adres Tablosu](/resimler/calisan_adres.png "Çalışan Adres Tablosu")
Yukarıda ZCALISAN_ADRES gösterilmektedir.
Bu tablo bu projedeki çalışan daire no, sokak adı gibi adres verilerini ve id alanını tutar.
Bu tabloda Key değeri CAL_ID 'dir. 
Aşağıda bu tablonun tuttuğu veriler gösterilmektedir. İstenirse veri büyüklüğü arttırılabilir.

![Çalışan Adres Tablosu](/resimler/calisan_adres_i.png "Çalışan Adres Tablosu")

##Çalışan Maaş Tablosu (ZCALISAN_MAAS)
![Çalışan Maaş Tablosu](/resimler/calisan_maas.png "Çalışan Maaş Tablosu")
Yukarıda ZCALISAN_MAAS gösterilmektedir.
Bu tablo bu projedeki çalışan maaş verilerini ve id alanını tutar.
Bu tabloda Key değeri CAL_ID 'dir.
Aşağıda bu tablonun tuttuğu veriler gösterilmektedir. İstenirse veri büyüklüğü arttırılabilir.

![Çalışan Maaş Tablosu](/resimler/calisan_maas_i.png "Çalışan Maaş Tablosu")

#SMARTFORM Uygulaması

![smartform](/resimler/smartform.png )
Yukarıda smartform oluşturkenki ekran görüntülenmektedir.
Burada sağ taraf oluşturulacak olan formun genel hattını temsil eder.
Sol tarafta ise veri tanımlamaları sayfalar ve pencereler düzenlenir.
![def](/resimler/def.png )
Yukarıda veri tanımlamaları yapılmıştır. gs_maas maaş structure'ını ifade eder.
gt_maas maaş tablosunu ifade eder. 
gv_sayac ise global variable yani global değişkeni ifade eder.

```ABAP
TYPES:  gtt_maas TYPE TABLE OF ZCALISAN_MAAS.
```
Yukarıda ise ZCALISAN_MAAS tablosu gtt_maas tablo tipine eklenmiştir. Böylece tablomuz formda kullanılabilecektir.

```ABAP
SELECT * FROM ZCALISAN_MAAS
  INTO TABLE gt_maas.


GV_sAYAC = 0.```
Initialization kısmında ise uygulama çalıştığında tanımlanması gereken değişkenler veya tablolar tanımlanır.

# Uygulama Arayüzü
![Arayüz1](/resimler/arayuz1.png )
Uygulama arayüzü Read,Create,Update,Delete işlemlerini gerçekleştirmek için seçenekler sunar.
Bunların yanında ek olarak projede oluşturulmuş olan SMARTFORM işlemi de rapor seçeneği olarak sunulur.

![Read](/resimler/Read.png )
Yukarıda Id'si '1' olan çalışanın verileri READ işlemi ile görüntülenmiştir.

![Create](/resimler/Create.png )
Create işlemi ile yeni bir çalışan verisi eklenir.

![Update](/resimler/Update.png )
Update işlemi ile seçili olan çalışan id'li çalışan verileri güncellenir.

![Delete](/resimler/Delete.png )
 Delete işlemi ile Id'si seçili çalışanın verileri silinir.
 
 ![Rapor](/resimler/Rapor.png )
 Rapor işlemi ile ise mevcut verilerin SMARTFORM'u oluşturulur. Böylece yazdırılabilir bir pdf haline gelir.
 
 ## Hazırlayan

[NURDAN AKINCI / B191200044 / SAKARYA UNİVERSİTESİ / BİLİSİM SİSTEMLERİ MUHENDİSLİGİ / YAZILIM STAJI PROJESİ /ABAP] (https://github.com/nurdanaknc)