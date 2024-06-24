import 'package:flutter/material.dart'; // Flutter materyal kütüphanesini ekliyoruz
import 'package:prj_1/card.dart'; // Özel kart bileşenimizi içeren dosyayı ekliyoruz
import 'package:prj_1/exercise.dart';
import 'package:quickalert/quickalert.dart'; // Hızlı uyarılar için kütüphaneyi ekliyoruz

// İkinci ve üçüncü sayfaların ekranlarını içeren dosyaları ekliyoruz
import 'package:prj_1/ikincisyf.dart';
import 'package:prj_1/soz.dart';
import 'package:prj_1/txtstyle.dart';

class HomeSyf extends StatefulWidget {
  const HomeSyf({Key? key}) : super(key: key);

  @override
  _HomeSyfState createState() => _HomeSyfState();
}

class _HomeSyfState extends State<HomeSyf> {
  late PageController _pageController;
  int _selectedIndex = 0;
  List<String> _tasks = [
    'Günlük 3 lt su içme',
    '2000 kalori beslenme',
    '10.000 adım sayısı Yürüme hedefi',
    '25 dk egzersiz yapma'
  ];
  List<bool> _taskStatus = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: _selectedIndex); // Sayfa kontrolcüsünü başlatıyoruz
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex =
                  index; // Sayfa değiştikçe seçili indeksi güncelliyoruz
            });
          },
          children: [
            // Anasayfa
            Scaffold(
              body: Column(
                children: [
                  // Başlık
                  Container(
                    width: deviceWidth,
                    height: deviceHeight / 8,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/images/assets/RESİM.jpg'),
                        fit: BoxFit.cover, // Resmin boyutunu ayarlamak için
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Sağlıklı Yaşam ",
                          style: MyTextStyles.zillaSlab,
                        ),
                      ),
                    ),
                  ),

                  // Kartlar
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: [
                          CustomCard(
                            text: "Beslenme",
                            imagePath: "lib/images/assets/salad.png",
                            color: Color.fromRGBO(231, 229, 254, 1),
                            onTap: () {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.info,
                                text:
                                    'Sağlıklı bir yaşam sürdürmek için dengeli bir beslenme programıyla günlük yaklaşık 2000-2500 kalori alınması önemlidir',
                              );
                            },
                          ),
                          CustomCard(
                            text: "Su Tüketimi",
                            imagePath: "lib/images/assets/water-bottle.png",
                            color: Color.fromRGBO(231, 229, 254, 1),
                            onTap: () {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text:
                                    ' Günlük su tüketimi ise en az 2-3 litre olmalıdır, çünkü vücudun su dengesini korumak önemlidir',
                              );
                            },
                          ),
                          CustomCard(
                            text: "Günlük Adım",
                            imagePath: "lib/images/assets/walking.png",
                            color: Color.fromRGBO(231, 229, 254, 1),
                            onTap: () {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.warning,
                                text:
                                    'Ayrıca, her gün en az 10.000 adım atmaya çalışmak fiziksel aktivite düzeyini artırabilir ve kardiyovasküler sağlığı destekleyebilir',
                              );
                            },
                          ),
                          CustomCard(
                            text: "Egzersiz",
                            imagePath: "lib/images/assets/fitness.png",
                            color: Color.fromRGBO(231, 229, 254, 1),
                            onTap: () {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.loading,
                                text:
                                    'Haftada en az 150 dakika orta yoğunlukta aerobik egzersiz yapmak, kasları güçlendirmek ve genel sağlığı desteklemek için önemlidir',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // İkinci ve üçüncü sayfalar, PageView içindeki children listesine eklenmiştir. Bu nedenle, PageView, bu sayfaları ilk sayfa olarak gösterir ve kullanıcılar arasında geçiş yapabilir.
            IkinciSayfa(
              tasks: _tasks,
              taskStatus: _taskStatus,
              updateTaskStatus: (List<bool> updatedTaskStatus) {
                setState(() {
                  _taskStatus = updatedTaskStatus;
                });
              },
            ),
            ExerciseListPage(), // İkinci sayfa (IkinciSayfa sınıfı), "ikincisyf.dart" dosyasında tanımlanmıştır. Bu dosyada, sayfa içeriği ve görünümü belirlenir.
            Motivasyon(), // Üçüncü sayfa (Motivasyon sınıfı), "soz.dart" dosyasında tanımlanmıştır. Bu dosyada da sayfa içeriği ve     görünümü belirlenir.
          ],
        ),
        // bottomNavigationBar, alt gezinme çubuğunu oluşturur. Her bir öğe, sayfanın altında bir simge ve metin içerir.
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety),
              label: 'Exercise',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm),
              label: 'Alarm',
            ),
          ],
          selectedItemColor: const Color.fromARGB(255, 182, 164, 232),
          currentIndex: _selectedIndex,
          onTap: (int index) {
            // onTap fonksiyonu, bottomNavigationBar'daki bir öğe tıklandığında çağrılır. Bu, _pageController aracılığıyla PageView'daki sayfalar arasında geçişi tetikler.
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            ); // Sayfa değişim animasyonu
          },
        ),
        // floatingActionButton, kaydırılabilir sayfanın üstünde yüzen bir düğme oluşturur. onPressed işlevi, düğme tıklandığında çağrılır ve Navigator aracılığıyla bir sonraki sayfaya yönlendirme yapılır.
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super
        .dispose(); // _HomeSyfState nesnesi ortadan kaldırıldığında çağrılır. Bu, gereksiz bellek tüketimini önlemek için sayfa kontrolcüsünü temizler.
  }
}
