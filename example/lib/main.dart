import 'package:floodfill_image/floodfill_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flood Fill Image Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flood Fill Image Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? title;
  MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _fillColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloodFillImage(
                imageProvider: AssetImage("assets/dog.jpg"),
                fillColor: _fillColor,
                avoidColor: [Colors.transparent, Colors.black],
                tolerance: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _fillColor = Colors.brown;
                      });
                    },
                    child: Text("Brown",style: TextStyle(color: Colors.black),),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.brown)),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _fillColor = Colors.amber;
                      });
                    },
                    child: Text("Amber",style: TextStyle(color: Colors.black),),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _fillColor = Colors.cyan;
                      });
                    },
                    child: Text("Cyan",style: TextStyle(color: Colors.black),),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.cyan)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
