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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> noteList = [];

  TextEditingController messageController = TextEditingController();

  _MyHomePageState() {}

  void loadRecentMessage() async {}

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

  void saveNewNote(String text) async {}

  Future<List<String>> loadNote() async {
    List<String> resultList;

    return resultList;
  }

  Future<Database> createConnection() async {
    return null;
  }
}
