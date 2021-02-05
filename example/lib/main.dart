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
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _fillColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _fillColor = Colors.brown;
                      });
                    },
                    child: Text("Brown"),
                    color: Colors.brown,
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _fillColor = Colors.amber;
                      });
                    },
                    child: Text("Amber"),
                    color: Colors.amber,
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _fillColor = Colors.cyan;
                      });
                    },
                    child: Text("Cyan"),
                    color: Colors.cyan,
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
