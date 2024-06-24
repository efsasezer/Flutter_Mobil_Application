import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Grafik için gerekli kütüphane
import 'package:prj_1/database_helper.dart';

class UpdateWeightPage extends StatefulWidget {
  final String userEmail;

  UpdateWeightPage({required this.userEmail});

  @override
  _UpdateWeightPageState createState() => _UpdateWeightPageState();
}

class _UpdateWeightPageState extends State<UpdateWeightPage> {
  TextEditingController weightController =
      TextEditingController(); // Kullanıcının ağırlığını girmek için metin denetleyicisi
  List<double> weights = []; // Kullanıcının daha önceki ağırlıklarının listesi
  List<int> weightIndices = []; // Ağırlık verilerinin dizinlerinin listesi

  @override
  void initState() {
    super.initState();
    _fetchWeightData(); // Kullanıcının ağırlık verilerini almak için işlevi çağır
  }

  // Kullanıcının ağırlık verilerini veritabanından getirme işlevi
  Future<void> _fetchWeightData() async {
    List<Map<String, dynamic>> weightDataList = await DatabaseHelper()
        .getAllWeightData(widget
            .userEmail); // Kullanıcının ağırlık verilerini veritabanından al
    if (weightDataList.isNotEmpty) {
      // Eğer veri varsa,
      setState(() {
        weights = weightDataList
            .map((data) => data['weight'] as double)
            .toList(); // Ağırlıkları al
        weightIndices = weightDataList
            .map((data) => data['weight_index'] as int)
            .toList(); // Ağırlık indekslerini al
      });
    } else {
      // Eğer veri yoksa, varsayılan bir ağırlık ekleyin
      Map<String, dynamic>? userData = await DatabaseHelper()
          .getUserByEmail(widget.userEmail); // Kullanıcı verilerini al
      if (userData != null) {
        double initialWeight =
            userData['weight']; // Kullanıcının ilk ağırlığını al
        setState(() {
          weights.add(initialWeight); // Ağırlığı listeye ekle
          weightIndices.add(0); // İndisi ekle
        });
        await DatabaseHelper().insertWeight(widget.userEmail,
            initialWeight); // Veritabanına varsayılan ağırlığı ekle
      }
    }
  }

  // Kullanıcının ağırlığını güncelleme işlevi
  _updateWeight() async {
    double newWeight = double.parse(weightController.text); // Yeni ağırlığı al
    String userEmail = widget.userEmail; // Kullanıcı e-posta adresini al

    await DatabaseHelper()
        .updateWeight(userEmail, newWeight); // Ağırlığı veritabanında güncelle

    int newIndex = weightIndices.length; // Yeni indeks
    setState(() {
      weights.add(newWeight); // Yeni ağırlığı listeye ekle
      weightIndices.add(newIndex); // Yeni indeksi ekle
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Weight updated successfully!'), // Başarılı bir şekilde güncellendi mesajı
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Weight"), // Sayfa başlığı
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: weightController,
                decoration: InputDecoration(
                  labelText: 'New Weight', // Yeni ağırlık için etiket
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateWeight,
                child: Text('Update Weight'), // Ağırlığı güncelle düğmesi
              ),
              SizedBox(height: 20),
              // Eğer ağırlık verileri varsa, grafik göster
              weights.isNotEmpty
                  ? Expanded(
                      child: LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTitles: (value) {
                                return value
                                    .toInt()
                                    .toString(); // Grafik altında indeks değerlerini göster
                              },
                            ),
                          ),
                          borderData: FlBorderData(show: true),
                          minX: 0,
                          maxX: (weightIndices.length - 1)
                              .toDouble(), // X ekseni için minimum ve maksimum değerler
                          minY: weights.reduce((a, b) =>
                              a < b ? a : b), // Y ekseni için minimum değer
                          maxY: weights.reduce((a, b) =>
                              a > b ? a : b), // Y ekseni için maksimum değer
                          lineBarsData: [
                            LineChartBarData(
                              spots: List.generate(
                                weights.length,
                                (index) => FlSpot(
                                    weightIndices[index].toDouble(),
                                    weights[index]), // Grafik noktaları
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
