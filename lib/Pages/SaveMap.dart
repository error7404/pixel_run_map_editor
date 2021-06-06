import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:filepicker_windows/filepicker_windows.dart';

class SaveMap extends StatelessWidget {
  final File file;
  final List map;
  const SaveMap({Key? key, required this.file, required this.map})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save map"),
        centerTitle: true,
      ),
      body: Center(
          child: TextButton(
              child: Text("Save"),
              onPressed: () {
                final SaveFilePicker saveFile = SaveFilePicker()
                  ..fileName = file.path.split('\\').last
                  ..fileMustExist = false
                  ..defaultFilterIndex = 0
                  ..defaultExtension = 'json'
                  ..title = 'Select the map file';
                saveFile.getFile()!.writeAsStringSync(json.encode(map));
              })),
    );
  }
}
