import 'package:flutter/material.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:pixel_run_map_editor/Pages/MapViewer.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            final file = OpenFilePicker()
              ..filterSpecification = {
                'Json map': '*.json',
                'All Files': '*.*',
              }
              ..defaultFilterIndex = 0
              ..defaultExtension = 'json'
              ..title = 'Select the map file';

            final result = file.getFile();
            if (result != null) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      MapViewer(file: result),
                ),
              );
            }
          },
          child: Text("import map"),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.all(20),
            ),
          ),
        ),
      ),
    );
  }
}
