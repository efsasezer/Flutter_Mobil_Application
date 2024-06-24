import 'package:flutter/material.dart';
import 'package:prj_1/database_helper.dart';
import 'package:prj_1/login_page.dart';

class SignupPage extends StatefulWidget {
  final String goal;

  SignupPage({required this.goal});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final dbHelper = DatabaseHelper();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"), // Sayfa başlığı
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Goal: ${widget.goal}', // Hedefi gösteren metin
                style: TextStyle(fontSize: 20), // Metin stilini belirle
              ),
              SizedBox(height: 10), // Boşluk ekleyerek aralığı arttır
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name', // İsim etiketi
                ),
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age', // Yaş etiketi
                ),
                keyboardType:
                    TextInputType.number, // Sadece sayı girişi için klavye türü
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email', // Email etiketi
                ),
                keyboardType: TextInputType
                    .emailAddress, // Email adresi girişi için klavye türü
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password', // Şifre etiketi
                ),
                obscureText: true, // Şifre girişini gizle
              ),
              TextFormField(
                controller: heightController,
                decoration: const InputDecoration(
                  labelText: 'Height', // Boy etiketi
                ),
                keyboardType:
                    TextInputType.number, // Sadece sayı girişi için klavye türü
              ),
              TextFormField(
                controller: weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight', // Kilo etiketi
                ),
                keyboardType:
                    TextInputType.number, // Sadece sayı girişi için klavye türü
              ),
              ElevatedButton(
                onPressed: _signup, // Butona basıldığında çalışacak fonksiyon
                child: Text('Sign Up'), // Buton metni
              ),
              SizedBox(height: 20), // Boşluk ekleyerek aralığı arttır
              Text(message), // İşlem sonucunu gösteren metin
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginPage()), // Login sayfasına geçiş
                  );
                },
                child: Text('Eğer kayıtlıysanız giriş yapın'), // Buton metni
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signup() async {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        heightController.text.isEmpty ||
        weightController.text.isEmpty) {
      setState(() {
        message = 'Lütfen tüm alanları doldurun.'; // Eksik alan uyarısı
      });
      return;
    }

    Map<String, dynamic> row = {
      'name': nameController.text,
      'age': int.parse(ageController.text),
      'email': emailController.text,
      'password': passwordController.text,
      'height': double.parse(heightController.text),
      'weight': double.parse(weightController.text),
      'goal': widget.goal,
      'weight_index': 0, // İlk kilo endeksi
    };
    final id =
        await dbHelper.insertData(row); // Veritabanına kullanıcı ekleme işlemi
    setState(() {
      message =
          'User signed up successfully!'; // Kullanıcı başarıyla kaydedildi mesajı
    });
    print('inserted row id: $id');
  }
}
