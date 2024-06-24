import 'package:flutter/material.dart';
import 'package:prj_1/timer.dart'; // Zamanlayıcı sayfasını import ediyoruz
import 'database_helper.dart'; // Veritabanı yardımcı sınıfını import ediyoruz

class ExerciseListPage extends StatefulWidget {
  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  late Future<List<Map<String, dynamic>>>
      _exercises; // Egzersiz listesini temsil eden Future nesnesi

  @override
  void initState() {
    super.initState();
    _exercises = DatabaseHelper()
        .getAllExercises(); // Tüm egzersizleri getiren metodun sonucunu atama
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise List'), // Sayfa başlığı
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future:
            _exercises, // Future nesnesini kullanarak gelecek egzersiz listesi
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // Veri yüklenirken bir dairesel ilerleme çubuğu göster
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Error: ${snapshot.error}')); // Hata durumunda hata mesajını göster
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
                    'No exercises found.')); // Veri yoksa veya boşsa uyarı mesajı göster
          } else {
            List<Map<String, dynamic>> exercises =
                snapshot.data!; // Gelen egzersiz verisini bir listeye atama
            return ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                var exercise = exercises[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(
                      exercise['name'], // Egzersiz adını göster
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise[
                              'description'], // Egzersiz açıklamasını göster
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Calories per minute: ${exercise['calories_per_minute']}', // Dakika başına kaloriyi göster
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.play_arrow), // Egzersiz başlatma simgesi
                      onPressed: () => _showDurationInputDialog(context,
                          exercise), // Dialogu gösterme fonksiyonunu çağır
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Egzersiz süresi giriş dialogunu gösteren fonksiyon
  void _showDurationInputDialog(
      BuildContext context, Map<String, dynamic> exercise) {
    TextEditingController durationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter duration in minutes'), // Dialog başlığı
          content: TextField(
            controller: durationController,
            keyboardType: TextInputType.number, // Sayısal klavye türü
            decoration: InputDecoration(
              hintText: 'Enter duration', // Giriş alanı için ipucu
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // İptal butonuna basıldığında dialogu kapat
              },
              child: Text('Cancel'), // İptal butonu metni
            ),
            TextButton(
              onPressed: () {
                int duration = int.parse(
                    durationController.text); // Girdiyi integer'a çevir
                Navigator.of(context)
                    .pop(); // Onay butonuna basıldığında dialogu kapat
                _startExercise(
                    exercise, duration); // Egzersizi başlatan fonksiyonu çağır
              },
              child: Text('Start'), // Onay butonu metni
            ),
          ],
        );
      },
    );
  }

  // Egzersizi başlatan fonksiyon
  void _startExercise(Map<String, dynamic> exercise, int duration) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseTimerPage(
          exerciseName:
              exercise['name'], // Egzersiz adını parametre olarak geçir
          durationInMinutes:
              duration, // Egzersiz süresini parametre olarak geçir

          caloriesPerMinute: exercise[
              'calories_per_minute'], // Dakika başına kaloriyi parametre olarak geçir
        ),
      ),
    );
  }
}
