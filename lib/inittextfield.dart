// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// https://qiita.com/solty_919/items/f14b443126122b666c73
class InitTextField extends StatelessWidget {
  const InitTextField({Key? key, required this.title, required this.style})
      : super(key: key);

  final String title;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: 7,
      style: style,
      controller: TextEditingController(text: title),
      readOnly: true,
    );
  }
}
