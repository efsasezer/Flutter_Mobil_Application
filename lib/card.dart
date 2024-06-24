import 'package:flutter/material.dart';
import 'package:prj_1/txtstyle.dart'; // txtstyle dosyasından metin stillerini içe aktarıyoruz

// CardTapCallback türünde bir geri çağırma fonksiyonu tanımlıyoruz
typedef CardTapCallback = void Function();

// Özel bir kart bileşeni oluşturuyoruz
Widget CustomCard({
  required String text, // Kartın üzerinde gösterilecek metin
  required String imagePath, // Kartın üzerinde gösterilecek resmin dosya yolu
  required Color color, // Kartın arka plan rengi
  required CardTapCallback onTap, // Kartın tıklama işlevi
}) {
  return Container(
    margin: const EdgeInsets.all(8.0), // Kenar boşlukları
    decoration: BoxDecoration(
      color: color, // Arka plan rengi
      borderRadius: BorderRadius.circular(10), // Kartın köşe yuvarlama işlemi
    ),
    child: TextButton(
      // Metin butonu widget'ı kullanıyoruz
      onPressed: onTap, // Tıklama işlevi
      child: Padding(
        padding: const EdgeInsets.all(8.0), // İç içe boşluklar
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Sütunun dikey hizalaması
          children: [
            Expanded(
              // Resim widget'ını genişletiyoruz
              child: Image.asset(
                imagePath, // Resmin dosya yolu
                fit: BoxFit.cover, // Resmi genişletme modu
              ),
            ),
            const SizedBox(height: 15), // Dikey boşluk
            Text(
              text, // Gösterilecek metin
              style: MyTextStyles.zillaSlab
                  .copyWith(fontSize: 18), // Metin stilini belirleme
            ),
          ],
        ),
      ),
    ),
  );
}
