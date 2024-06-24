import 'package:flutter/material.dart';
import 'package:prj_1/dort.dart'; // Dördüncü sayfayı içeren dosyayı ekliyoruz
import 'package:prj_1/txtstyle.dart'; // Metin stilleri dosyasını ekliyoruz
import 'package:prj_1/video.dart'; // Video_player sınıfını içeren dosyayı ekliyoruz

class IkinciSayfa extends StatefulWidget {
  final List<String> tasks;
  final List<bool> taskStatus;
  final Function(List<bool>) updateTaskStatus;

  const IkinciSayfa({
    Key? key,
    required this.tasks,
    required this.taskStatus,
    required this.updateTaskStatus,
  }) : super(key: key);

  @override
  _IkinciSayfaState createState() => _IkinciSayfaState();
}

class _IkinciSayfaState extends State<IkinciSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Görevler',
          style: MyTextStyles.zillaSlab,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'lib/images/assets/RESİM.jpg'), // Arkaplan resmini ekliyoruz
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title:
                      Text(widget.tasks[index]), // Görev adını gösteren başlık
                  leading: Checkbox(
                    value: widget.taskStatus[
                        index], // Görev durumunu gösteren onay kutusu
                    onChanged: (bool? value) {
                      setState(() {
                        widget.taskStatus[index] =
                            value ?? false; // Görev durumunu güncelle
                        widget.updateTaskStatus(widget
                            .taskStatus); // Durumu güncelleme işlevini çağır
                      });
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(
                        Icons.edit), // Görevi düzenlemek için düzenle simgesi
                    onPressed: () {
                      _editTask(
                          context, index); // Görevi düzenleme işlevini çağır
                    },
                  ),
                );
              },
            ),
          ),
          // Video player alanı
          Container(
            height: 150,
            width: double.infinity,
            child: Video_player(), // VideoPlayer sınıfını çağırıyoruz
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _addNewTask(context), // Yeni görev ekleme düğmesi
            child: Icon(Icons.add), // Ekle simgesi
            backgroundColor: Colors.blue, // Arka plan rengi
          ),
          SizedBox(
              height: 16), // FAB ile diğer içerik arasında boşluk bırakmak için
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DortuncuSayfa(
                        taskStatus:
                            widget.taskStatus)), // Dördüncü sayfaya geçiş
              );
            },
            child: Icon(Icons.arrow_forward), // İleri simgesi
            backgroundColor: Colors.green, // Arka plan rengi
          ),
        ],
      ),
    );
  }

  // Görevi düzenleme metodu
  void _editTask(BuildContext context, int index) {
    TextEditingController editingController = TextEditingController(
        text: widget.tasks[index]); // Düzenleme denetleyicisi

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Görevi Düzenle',
            style: MyTextStyles.zillaSlab,
          ),
          content: TextField(
            controller: editingController, // Düzenleme metni girişi
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  widget.tasks[index] =
                      editingController.text; // Görevi güncelle
                });
                Navigator.pop(context); // Dialogu kapat
              },
              child: Text(
                'Tamam',
                style: MyTextStyles.zillaSlab,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dialogu kapat
              },
              child: Text(
                'İptal',
                style: MyTextStyles.zillaSlab,
              ),
            ),
          ],
        );
      },
    );
  }

  // Yeni görev ekleme metodu
  void _addNewTask(BuildContext context) {
    TextEditingController newTaskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Yeni Görev Ekle',
            style: MyTextStyles.zillaSlab,
          ),
          content: TextField(
            controller: newTaskController, // Yeni görev metni girişi
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  widget.tasks
                      .add(newTaskController.text); // Yeni görevi listeye ekle
                  widget.taskStatus
                      .add(false); // Yeni görevin durumunu false olarak ayarla
                  widget.updateTaskStatus(
                      widget.taskStatus); // Durumu güncelleme işlevini çağır
                });
                Navigator.pop(context); // Dialogu kapat
              },
              child: Text('Ekle', style: MyTextStyles.zillaSlab),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dialogu kapat
              },
              child: Text('İptal', style: MyTextStyles.zillaSlab),
            ),
          ],
        );
      },
    );
  }
}
