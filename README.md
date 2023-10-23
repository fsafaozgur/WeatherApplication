
# WeatherApplication Uygulaması

## Giriş
Proje kapsamında; Unit Testleri de yapılmış, kaynak olarak bir Hava Durumu API kullanılarak Türkiye'de yer alan tüm şehirlerdeki detaylı hava şartlarını kullanıcıya sunan bir Hava Durumu uygulaması MVVM tasarım kalıbı ile tasarlanmıştır. 

## Hedef
Proje ile birlikte; Hava Durumu API 'a istek göndererek istediğimiz şehre ait hava durumu bilgilerinin JSON formatında alınması ve bu bilgilerin kullanıcıya bir arayüz yardımı ile sunulması işlemlerinin MVVM tasarım kalıbı ile nasıl tasarlanacağının ortaya konulması amaçlanmış, fonksiyonlara ilişkin Unit Testler de gerçekleştirilmiştir.

## Uygulama Kullanımı
Uygulama ilk olarak yerel bir JSON dosyasından Türkiye'de yer alan şehirlerin listesini almakta ve bunları kullanıcıya bir arayüz yardımı ile listelemektedir.

Kullanıcı tarafından listeden seçilen şehre ait hava durumu bilgileri, Hava Durumu API 'dan JSON formatında alınarak, bir arayüz yardımıyla kullanıcıya sunulmaktadır.
