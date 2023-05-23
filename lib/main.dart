// ignore_for_file: use_build_context_synchronously, unused_local_variable, must_be_immutable

import 'dart:io';

import 'package:correctjp/converter.dart';
import 'package:correctjp/initTextField.dart';
import 'package:correctjp/ui/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'correctJP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(103, 58, 183, 1)),
        useMaterial3: true,
      ),
      home: MyHomePage(title: '怪レい日本語ジェネレーター'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String cjp = '';
  String input = '';
  static bool isinit = true;

  @override
  void initState() {
    super.initState();
    Converter(prompt: 'あなたは上のテキストフィールドに文字を入力することでを怪しい日本語を変換することができます！')
        .initjson()
        .then((value) {
      value.converttocjp().then(
        (cjp) {
          setState(
            () {
              this.cjp = cjp;
            },
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Converter(prompt: widget.title).converttocjp().then(
      (cjp) {
        setState(
          () {
            widget.title = cjp;
          },
        );
      },
    );

    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Info()));
            },
            icon: const Icon(Icons.info),
            tooltip: "このアプリについて",
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                style: const TextStyle(fontSize: 20),
                onChanged: (value) {
                  isinit = false;
                  Converter(prompt: value).converttocjp().then(
                    (cjp) {
                      setState(
                        () {
                          this.cjp = cjp;
                        },
                      );
                    },
                  );
                },
              ),
              InitTextField(
                title: cjp,
                style: const TextStyle(fontSize: 15),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              ElevatedButton(
                onPressed: () {
                  if (!isinit) {
                    if (cjp.isEmpty) {
                      showSnackBarAscjp("文字を入力してください");
                    } else {
                      Clipboard.setData(ClipboardData(text: cjp));
                      showSnackBarAscjp("クリップボードにテキストをコピーしました");
                    }
                  } else {
                    showSnackBarAscjp("文字を入力してください");
                  }
                },
                child: const Text('コピー'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBarAscjp(String prompt) {
    Converter(prompt: prompt).converttocjp().then(
      (value) {
        SnackBar snackBar = SnackBar(
          content: Text(value),
        );
        if (Platform.isAndroid || Platform.isIOS) {
          Fluttertoast.showToast(msg: value);
        } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
