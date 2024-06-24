import 'package:flutter/material.dart';
import 'package:prj_1/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Debug etiketini kaldırmak için bunu false yapıyoruz
      theme: ThemeData.light(),
      home:
          WelcomePage(), // Ana sayfa olarak WelcomePage widget'ını belirtiyoruz
    );
  }
}
