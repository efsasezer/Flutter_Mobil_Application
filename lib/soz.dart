import 'dart:math'; // Rastgele sayı üretmek için gerekli matematik kütüphanesi
import 'package:flutter/material.dart'; // Flutter materyal kütüphanesini ekliyoruz

// Stateful widget sınıfımızı tanımlıyoruz
class Motivasyon extends StatefulWidget {
  const Motivasyon({Key? key}) : super(key: key);

  @override
  _MotivasyonState createState() =>
      _MotivasyonState(); // State sınıfını çağırıyoruz
}

// State sınıfı
class _MotivasyonState extends State<Motivasyon> {
  late int _answerIndex; // Rastgele seçilen metnin indeksi
  final List<String> _answers = [
    // Motivasyon mesajlarının listesi
    "Ödem problemi yaşadığınız dönemlerde meyve olarak kivi, ananas veya nar tüketebilirsiniz. Sıvı bir şey tüketmek isterseniz de ısırgan otu, adaçayı ve yeşil çayı birlikte demleyebilir ve içerisine 1 adet kabuk tarçın ve 1 çay kaşığı zencefil ilave edebilirsiniz. Günlük 1-2 fincan içmek yeterli. Fakat herhangi bir sağlık probleminiz varsa, diyette kilo verme uğruna asla bir doktora danışmadan bu tür çayları tüketmeyin.",
    "Yemeklerinizde taze ve işlenmemiş kuru meyveler, ceviz, fındık, badem, kaju, yulaf ezmesi, yağsız sütlü kahve, kinoa, karabuğdaylı krakerler, 1 dilim ekmeğin üzerine sürülen az yağlı bir peynir sağlıklı atıştırmalık alternatifleri oluşturabilir. Yine diyetinizde protein oranı yüksek süt, yoğurt gibi gıdalar ve liften zengin yulaf ezmesi ve müsli gibi atıştırmalıklar daha uzun süre tokluk sağlar.",
    " Multivitaminler, ihtiyacınız olan günlük vitamin ve mineral ihtiyacınızı karşılarken; yorgunluğunuzu gidermek için magnezyum destekçiniz olabilir. Hücrelerinizde azalan enerji miktarını dengelemek için koenzim q10 tercih ederken, kemik ve eklemlerinizin sağlığı için collagen takviyesine ihtiyaç duyabilirsiniz. Saçlarınız, tırnaklarınız ve cildinizde sağlıklı bir görünüme kavuşmak için biotin, damar sağlığınız için de omega 3 desteği alabilirsiniz.",
    "Doğadaki bitkilerden elde edilen yağların her biri farklı özelliklere sahip. Cildinizi nemlendiren, saçlarınızı canlandıran çay ağacı yağı ve gül yağı, rahat ve kesintisiz uyumanızı sağlayan lavanta yağı, akne problemleriniz için kullanabileceğiniz jojoba yağı, vitaminler yönünden zengin tatlı badem yağı, yara ve yanık izlerini iyileştirmek için sarı kantaron yağı, eklem ağrılarınız için masaj yağı olarak da kullanabileceğiniz çam terebentin yağı bu yağlardan yalnızca bazıları. Özel dokulara ve etkilere sahip bu bitkisel yağları sağlıklı yaşam rutininizde kullanmayı tercih edebilirsiniz. ",
    "Uykunuzun kalitesi tüm günü etkileyen önemli bir ayrıntı. Rahat ve kesintisiz bir uyku, güne zinde başlamanızı sağlarken geri kalan saatlerde de kaliteli vakit geçirmenize yardımcı olur.Ancak çoğu zaman stres, düzensiz beslenme alışkanlıkları, yorgunluk gece uyku düzeninizde de sorun yaşamanıza neden olur. Tüm bunların yanı sıra uykunuzda aldığınız nefes de sağlığınız için son derece önemli. Bu konuda problem yaşayanlar için küçük ama etkili önlemler de mevcut. ",
    "Günümüzde önemli sorunlardan biri de hareketsiz yaşamdır. Hareketsiz yaşam obezite ve diyabet gibi sağlık sorunları riskini artırıyor. Bu nedenle yürüyüşler yapma, bisiklete binme, germe egzersizleri, bilgisayar başında uzun süre kalınmaması gerekiyor. Özellikle masa başında uzun süre oturmak bel ve sırt ağrılarına sebep olmaktadır.",
  ];

  @override
  void initState() {
    super.initState();
    _answerIndex = Random()
        .nextInt(_answers.length); // Rastgele bir motivasyon mesajı seçme
  }

  // "Faydalı Bilgiler!" düğmesine tıklandığında çağrılan işlev
  void _bilgi() {
    setState(() {
      _answerIndex =
          Random().nextInt(_answers.length); // Yeni bir motivasyon mesajı seç
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              _answers[
                  _answerIndex], // Rastgele seçilen motivasyon mesajını göster
              style: const TextStyle(fontSize: 20), // Metin boyutu
              textAlign: TextAlign.center, // Metnin hizalama şekli
            ),
          ),
          ElevatedButton(
            onPressed: _bilgi, // Butona basıldığında _bilgi işlevini çağır
            child: const Text('Faydalı Bilgiler!'), // Buton metni
          ),
        ],
      ),
    );
  }
}
