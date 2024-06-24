import 'package:flutter/material.dart';
import 'package:prj_1/database_helper.dart';
import 'package:prj_1/update.dart';
import 'package:prj_1/home.dart';

class ProfilePage extends StatefulWidget {
  final String userEmail;

  ProfilePage({required this.userEmail});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  late String userEmail;
  List<Map<String, dynamic>> weightDataList =
      []; // Kilo verilerini saklamak için liste

  @override
  void initState() {
    super.initState();
    userEmail = widget.userEmail;
    _fetchUserData();
    _fetchWeightData(); // Kilolari çekme işlemi başlatılıyor
  }

  // Kullanıcı verilerini çeken fonksiyon
  void _fetchUserData() async {
    Map<String, dynamic>? data =
        await DatabaseHelper().getUserByEmail(userEmail);
    setState(() {
      userData = data;
    });
  }

  // Kilo verilerini çeken fonksiyon
  void _fetchWeightData() async {
    List<Map<String, dynamic>> weightData =
        await DatabaseHelper().getAllWeightData(userEmail);
    setState(() {
      weightDataList = weightData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Bilgileri'), // Sayfa başlığı
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'lib/images/assets/profil.jpg', // Arka plan görselinin yolunu belirtin
            fit: BoxFit
                .cover, // Görselin konteynıra nasıl sığdırılacağını belirtin
          ),
          userData != null
              ? Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Text(
                                'Name: ${userData!['name']}',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Center(
                              child: Text(
                                'Age: ${userData!['age']}',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Center(
                              child: Text(
                                'Email: ${userData!['email']}',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Center(
                              child: Text(
                                'Height: ${userData!['height']}',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Center(
                              child: Text(
                                'Weight: ${_getCurrentWeight()}',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateWeightPage(
                                        userEmail: widget.userEmail,
                                      ),
                                    ),
                                  ).then((_) {
                                    // Güncelleme işlemi tamamlandıktan sonra profil verilerini yeniden yükle
                                    _fetchUserData();
                                    _fetchWeightData(); // Kilo verilerini de güncelle
                                  });
                                },
                                child: Text('Kilo Güncelleme'),
                              ),
                            ),
                            SizedBox(
                                height:
                                    20.0), // Kilo Güncelleme butonunun altına boşluk ekliyoruz
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HomeSyf(), // HomePage'e yönlendiriyoruz
                                    ),
                                  );
                                },
                                child: Text('Ana Sayfa'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ), // Kullanıcı verileri yüklenirken bir yüklenme çemberi göster
        ],
      ),
    );
  }

  // En son kaydedilen kiloyu döndüren yardımcı fonksiyon
  String _getCurrentWeight() {
    if (weightDataList.isNotEmpty) {
      double lastWeight =
          weightDataList.last['weight'] as double; // Son kiloyu al
      return lastWeight.toString(); // String olarak döndür
    } else {
      // Eğer kilo verisi yoksa kullanıcı veritabanına kaydedilen kiloyu kullan
      return userData!['weight'].toString();
    }
  }
}
