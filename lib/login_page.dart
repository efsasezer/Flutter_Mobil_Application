import 'package:flutter/material.dart';
import 'package:prj_1/database_helper.dart';
import 'package:prj_1/profile_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = ''; // Hata veya bilgilendirme mesajını tutacak değişken

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"), // Sayfa başlığı
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email', // Email giriş alanı etiketi
                ),
                keyboardType: TextInputType.emailAddress, // Klavye türü
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password', // Şifre giriş alanı etiketi
                ),
                obscureText: true, // Şifrenin gizli olmasını sağlar
              ),
              ElevatedButton(
                onPressed: _login, // Login işlemini gerçekleştirecek fonksiyon
                child: Text('Login'), // Buton üzerindeki metin
              ),
              SizedBox(height: 20), // Diğer bileşenler arasına boşluk ekler
              Text(message), // Hata veya bilgilendirme mesajını gösteren metin
            ],
          ),
        ),
      ),
    );
  }

  // Login işlemini gerçekleştiren fonksiyon
  void _login() async {
    String loginEmail = emailController.text; // Giriş yapılan email
    String loginPassword = passwordController.text; // Giriş yapılan şifre

    Map<String, dynamic>? userData =
        await DatabaseHelper().getUserByEmail(loginEmail);

    if (userData != null && userData['password'] == loginPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(userEmail: loginEmail),
        ),
      ); // Doğru bilgi ise kullanıcı profil sayfasına yönlendirilir
    } else {
      setState(() {
        message = 'Invalid email or password!'; // Hata mesajı atanır
      });
    }
  }
}
