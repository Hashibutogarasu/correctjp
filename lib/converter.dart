// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class Converter {
  late String prompt;
  static List<Map<String, dynamic>> jsonlist = [];

  Converter({required this.prompt});

  Future<Converter> initjson() async {
    List<String> files = [
      'json/common.json',
      'json/emoji.json',
      'json/kana.json',
      'json/kanji.json',
      'json/propernoun.json'
    ];

    for (int i = 0; i < files.length; i++) {
      jsonlist.add(jsonDecode(await rootBundle.loadString(files[i])));
    }

    return this;
  }

  Future<String> converttocjp() async {
    for (int i = 0; i < jsonlist.length; i++) {
      Map<String, dynamic> json = jsonlist[i];

      json.forEach((key, value) {
        RegExp reg = RegExp(key);
        if (reg.hasMatch(prompt)) {
          prompt = prompt.replaceAll(reg, value);
        }
      });
    }

    return prompt;
  }
}
