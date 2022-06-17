import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nextflow Flutter Workshop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Nextflow SQLite Note'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = ""}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> noteList = [];

  TextEditingController messageController = TextEditingController();

  _MyHomePageState() {
    this.loadRecentMessage();
  }

  void loadRecentMessage() async {
    noteList = await loadNote();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      controller: messageController,
                    )),
                    TextButton(
                      onPressed: () {
                        var message = messageController.text;

                        saveNewNote(message);
                      },
                      child: Text('บันทึก'),
                    ),
                  ],
                ),
              ),
            ),
            // List to show note message

            Expanded(
              child: ListView.builder(
                itemCount: noteList.length,
                itemBuilder: (BuildContext context, int index) {
                  var note = noteList[index];

                  return ListTile(
                    title: Text(note),
                  );
                },
              ),
            )
          ],
        ));
  }

  void saveNewNote(String text) async {
    var db = await createConnection();
    var sql = "INSERT INTO Note (text) VALUES (?)";
    var res = await db.rawInsert(sql, [text]);

    noteList = await loadNote();
    setState(() {
      messageController.text = "";
    });
  }

  Future<List<String>> loadNote() async {
    final db = await createConnection();
    var res = await db.query("Note");

    List<String> resultList;

    if (res.isNotEmpty) {
      resultList = res.map((row) {
        var result = row['text'].toString();
        return result;
      }).toList();
    } else {
      resultList = [];
    }

    return resultList;
  }

  Future<Database> createConnection() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Nextflow.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Note ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "text TEXT"
            ")");
      },
    );
  }
}
