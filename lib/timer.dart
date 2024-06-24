import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

// Egzersiz süresini sayan sayfa
class ExerciseTimerPage extends StatelessWidget {
  final String exerciseName; // Egzersiz adı
  final int durationInMinutes; // Egzersiz süresi dakika cinsinden
  final double caloriesPerMinute; // Dakikadaki yakılan kalori miktarı

  ExerciseTimerPage({
    required this.exerciseName,
    required this.durationInMinutes,
    required this.caloriesPerMinute,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          exerciseName,
          style: const TextStyle(
            color: Colors.white, // Başlık metninin rengi
          ),
        ),
        backgroundColor: Colors.indigo, // AppBar'ın arka plan rengi
      ),
      body: ExerciseTimerWidget(
        durationInMinutes: durationInMinutes,
        caloriesPerMinute: caloriesPerMinute,
      ),
    );
  }
}

// Egzersiz süresini sayan widget
class ExerciseTimerWidget extends StatefulWidget {
  final int durationInMinutes; // Egzersiz süresi dakika cinsinden
  final double caloriesPerMinute; // Dakikadaki yakılan kalori miktarı

  const ExerciseTimerWidget({
    Key? key,
    required this.durationInMinutes,
    required this.caloriesPerMinute,
  }) : super(key: key);

  @override
  _ExerciseTimerWidgetState createState() => _ExerciseTimerWidgetState();
}

class _ExerciseTimerWidgetState extends State<ExerciseTimerWidget> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown, // Geri sayım modu
  );
  bool _isRunning = false; // Zamanlayıcının çalışıp çalışmadığını belirtir

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.setPresetSecondTime(widget.durationInMinutes * 60);
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  // Zamanlayıcıyı başlatır
  void _startTimer() {
    _stopWatchTimer.onStartTimer();
    setState(() {
      _isRunning = true;
    });
  }

  // Zamanlayıcıyı duraklatır
  void _pauseTimer() {
    _stopWatchTimer.onStopTimer();
    setState(() {
      _isRunning = false;
    });
    _showMotivationalMessage();
  }

  // Egzersizi tamamlar
  void _finishTimer() {
    _stopWatchTimer.onStopTimer();
    _showExerciseDetails();
  }

  // Motivasyonel mesaj gösterir
  void _showMotivationalMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text(
            'Keep Going!', // Başlık metni
            style: TextStyle(
              color: Colors.indigo, // Metin rengi
              fontWeight: FontWeight.bold, // Metin kalınlığı
            ),
          ),
          content: const Text(
            'You can do it! Almost there!', // İçerik metni
            style: TextStyle(
              fontSize: 16.0, // Metin boyutu
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog penceresini kapatır
              },
              child: const Text(
                'Close', // Buton metni
                style: TextStyle(color: Colors.indigo), // Buton metin rengi
              ),
            ),
          ],
        );
      },
    );
  }

  // Egzersiz detaylarını gösterir
  void _showExerciseDetails() {
    final int elapsedMilliseconds = widget.durationInMinutes * 60 * 1000 -
        _stopWatchTimer.rawTime.value; // Geçen süre milisaniye cinsinden
    final double totalMinutes = elapsedMilliseconds /
        1000 /
        60; // Toplam dakika cinsinden egzersiz süresi
    final double totalCaloriesBurned = totalMinutes *
        widget.caloriesPerMinute; // Toplam yakılan kalori miktarı

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text(
            'Exercise Complete', // Başlık metni
            style: TextStyle(
              color: Colors.indigo, // Metin rengi
              fontWeight: FontWeight.bold, // Metin kalınlığı
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total calories burned: ${totalCaloriesBurned.toStringAsFixed(2)}', // İçerik metni
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                'You burned ${widget.caloriesPerMinute} calories per minute.', // İçerik metni
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                'You exercised for ${totalMinutes.toStringAsFixed(2)} minutes.', // İçerik metni
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog penceresini kapatır
                Navigator.of(context).pop(); // Timer sayfasını kapatır
              },
              child: const Text(
                'Close', // Buton metni
                style: TextStyle(color: Colors.indigo), // Buton metin rengi
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: _stopWatchTimer.rawTime.value,
            builder: (context, snapshot) {
              final value = snapshot.data!;
              final displayTime = StopWatchTimer.getDisplayTime(value);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  displayTime,
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: _isRunning ? null : _startTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo, // Buton arka plan rengi
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10), // Buton iç içe boşlukları
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Butonun kenar yuvarlaklığı
                  ),
                ),
                child: const Text(
                  'Start', // Buton metni
                  style: TextStyle(
                    fontSize: 16.0, // Metin boyutu
                    color: Colors.white, // Metin rengi
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _isRunning ? _pauseTimer : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, // Buton arka plan rengi
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10), // Buton iç içe boşlukları
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Butonun kenar yuvarlaklığı
                  ),
                ),
                child: const Text(
                  'Pause', // Buton metni
                  style: TextStyle(
                    fontSize: 16.0, // Metin boyutu
                    color: Colors.white, // Metin rengi
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _finishTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Buton arka plan rengi
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10), // Buton iç içe boşlukları
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Butonun kenar yuvarlaklığı
                  ),
                ),
                child: const Text(
                  'Finish', // Buton metni
                  style: TextStyle(
                    fontSize: 16.0, // Metin boyutu
                    color: Colors.white, // Metin rengi
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
