import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pixel_run_map_editor/Pages/SaveMap.dart';

int _currentBloc = 0;

class MapViewer extends StatefulWidget {
  final File file;

  const MapViewer({Key? key, required this.file}) : super(key: key);

  @override
  _MapViewerState createState() => _MapViewerState();
}

class _MapViewerState extends State<MapViewer> {
  List? map;
  @override
  Widget build(BuildContext context) {
    if (map == null) {
      try {
        map = json.decode(widget.file.readAsStringSync());
      } catch (e) {
        Navigator.pop(context);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.file.path.split('\\').last),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    SaveMap(
                  file: widget.file,
                  map: map!,
                ),
              ),
            ),
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: InteractiveViewer(
        scaleEnabled: false,
        constrained: false,
        child: Column(
          children: List.generate(
            map!.length + 1,
            (int index) => Row(
              children: List.generate(
                map![0].length + 1,
                (int index2) {
                  try {
                    return block(
                      id: map![index][index2],
                      map: map!,
                      x: index,
                      y: index2,
                      callback: (newMap) => setState(() => map = newMap),
                    );
                  } catch (e) {
                    // rendering no block when out of blocks
                    return block(
                      id: 1,
                      map: map!,
                      x: index,
                      y: index2,
                      callback: (newMap) => setState(() => map = newMap),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBloc,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset("assets/Bloc_de_terre_2.png"),
              label: "Bloc_de_terre"),
          BottomNavigationBarItem(
              icon: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
              label: "Air"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/Porte.png"), label: "Porte"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/Pic.png"), label: "Pic")
        ],
        showUnselectedLabels: true,
        showSelectedLabels: true,
        fixedColor: Colors.green,
        mouseCursor: SystemMouseCursors.click,
        onTap: (value) {
          setState(() {
            _currentBloc = value;
          });
        },
      ),
    );
  }
}

class block extends StatelessWidget {
  final int id;
  final List map;
  final int x;
  final int y;
  final callback;

  const block(
      {Key? key,
      required this.id,
      required this.map,
      required this.x,
      required this.y,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String block;
    switch (id) {
      case 0:
        block = "assets/Bloc_de_terre_2.png";
        break;
      case 1:
        block = "";
        break;
      case 2:
        block = "assets/Porte.png";
        break;
      case 3:
        block = "assets/Pic.png";
        break;
      default:
        block = "assets/Bloc_de_terre_2.png";
    }
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        // onTap: () {
        //   try {
        //     updateMap(map, x, y, id < 3 ? id + 1 : 0);
        //     // print(map);
        //     callback(map);
        //   } catch (e) {
        //     print("pas dans le map $e");
        //   }
        // },
        onTap: () {
          updateMap(map, x, y, _currentBloc);
          callback(map);
        },
        child: block != ""
            ? Image.asset(
                block,
                filterQuality: FilterQuality.none,
              )
            : SizedBox(
                height: 64,
                width: 64,
                child: Text(""),
              ),
      ),
    );
  }
}

List updateMap(List map, int x, int y, int value) {
  try {
    map[x][y] = value;
  } catch (e) {
    try {
      map[x].add(value);
    } catch (e) {
      map.add([value]);
    }
  }
  return map;
}
