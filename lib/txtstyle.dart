import 'package:flutter/material.dart'; // Flutter materyal kütüphanesini ekliyoruz
import 'package:google_fonts/google_fonts.dart'; // Google fontları kütüphanesini ekleme

// Metin stilleri sınıfı
class MyTextStyles {
  static final TextStyle zillaSlab = GoogleFonts.lunasima(
    // Zilla Slab fontunu kullanarak bir metin stili tanımlıyoruz
    fontSize: 26, // Metin boyutu
    fontWeight: FontWeight.bold, // Kalınlık
    color: Color.fromARGB(255, 42, 36, 51), // Metin rengi
  );
}
