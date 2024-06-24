import 'package:flutter/material.dart';
import 'package:prj_1/signup_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arka plan resmini ekleyin
          Positioned.fill(
            child: Image.asset(
              'lib/images/assets/back.jpg', // Arka plan resminin yolunu belirtin
              fit: BoxFit.cover, // Resmi boyutlandırma yöntemi
            ),
          ),
          // Dikey olarak ortalıyoruz
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Başlık metni
                const Text(
                  'Sağlıklı Yaşam Uygulamasına Hoşgeldiniz',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 80, 67, 95), // Metin rengi
                    fontWeight: FontWeight.bold, // Kalın font ağırlığı
                  ),
                  textAlign: TextAlign.center, // Metnin hizalanması
                ),
                const SizedBox(height: 20), // Araya bir boşluk ekliyoruz
                // Kullanıcının amacını belirtmesi için düğmeler
                ElevatedButton(
                  onPressed: () {
                    // Kullanıcı 'Kilo Verme'yi seçtiğinde SignupPage'e yönlendirilir
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignupPage(goal: 'Kilo Verme')),
                    );
                  },
                  child: const Text('Kilo Verme'), // Düğme metni
                ),
                const SizedBox(height: 10), // Araya bir boşluk ekliyoruz
                ElevatedButton(
                  onPressed: () {
                    // Kullanıcı 'Fit Kalma'yı seçtiğinde SignupPage'e yönlendirilir
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignupPage(goal: 'Fit Kalma')),
                    );
                  },
                  child: const Text('Fit Kalma'), // Düğme metni
                ),
                const SizedBox(height: 10), // Araya bir boşluk ekliyoruz
                ElevatedButton(
                  onPressed: () {
                    // Kullanıcı 'Kilo Alma'yı seçtiğinde SignupPage'e yönlendirilir
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignupPage(goal: 'Kilo Alma')),
                    );
                  },
                  child: const Text('Kilo Alma'), // Düğme metni
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
