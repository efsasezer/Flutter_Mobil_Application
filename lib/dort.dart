import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DortuncuSayfa extends StatelessWidget {
  final List<bool> taskStatus;

  const DortuncuSayfa({Key? key, required this.taskStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tamamlanan görevlerin sayısını hesapla
    int completedTasks = taskStatus.where((status) => status).length;
    int totalTasks = taskStatus.length; // Toplam görev sayısı
    int incompleteTasks =
        totalTasks - completedTasks; // Tamamlanmamış görev sayısı

    // Tamamlanan görevlerin yüzdesini hesapla
    double completedPercentage = (completedTasks / totalTasks);
    double incompletePercentage = (incompleteTasks / totalTasks);

    return Scaffold(
      appBar: AppBar(
        title: Text('Günlük İlerleme'), // Sayfa başlığı
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tamamlanan görevlerin yüzdesini gösteren daire grafiği
            Container(
              width: 250.0,
              height: 250.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CircularPercentIndicator(
                radius: 200.0,
                lineWidth: 20.0,
                percent: completedPercentage,
                center: Text(
                  'Tamamlanan Görevler\n$completedTasks/$totalTasks', // Görev istatistikleri
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                progressColor: Colors.green, // Tamamlanan görevlerin rengi
                backgroundColor: Colors.transparent,
                animationDuration: 1000,
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            SizedBox(height: 30), // İki daire grafiği arasına boşluk ekler
            // Tamamlanmamış görevlerin yüzdesini gösteren daire grafiği
            Container(
              width: 250.0,
              height: 250.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CircularPercentIndicator(
                radius: 200.0,
                lineWidth: 20.0,
                percent: incompletePercentage,
                center: Text(
                  'Eksik Görevler\n$incompleteTasks/$totalTasks', // Görev istatistikleri
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                progressColor: Colors.red, // Eksik görevlerin rengi
                backgroundColor: Colors.transparent,
                animationDuration: 1000,
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
