import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SlidingBox(_controller, Colors.blue[100], Interval(0.0, 0.2)),
            SlidingBox(_controller, Colors.blue[300], Interval(0.2, 0.4)),
            SlidingBox(_controller, Colors.blue[500], Interval(0.4, 0.6)),
            // FadeTransition(
            //   opacity: Tween(begin: 0.5, end: 1.0)
            //       .chain(CurveTween(curve: Interval(0.4, 0.6)))
            //       .animate(_controller),
            //   // position: Tween(begin: Offset.zero, end: Offset(0.1, 0))
            //   //     .chain(CurveTween(curve: Interval(0.4, 0.6)))
            //   //     .animate(_controller), //Offset.zero = Offset(0, 0)
            //   child: Container(
            //     width: 300,
            //     height: 100,
            //     color: Colors.blue[500],
            //   ),
            // ),
            SlidingBox(_controller, Colors.blue[700], Interval(0.6, 0.8)),
            // ScaleTransition(
            //   scale: Tween(begin: 1.0, end: 1.5)
            //       .chain(CurveTween(curve: Interval(0.6, 0.8)))
            //       .animate(_controller),
            //   // position: Tween(begin: Offset.zero, end: Offset(0.1, 0))
            //   //     .chain(CurveTween(curve: Interval(0.4, 0.6)))
            //   //     .animate(_controller), //Offset.zero = Offset(0, 0)
            //   child: Container(
            //     width: 300,
            //     height: 100,
            //     color: Colors.blue[700],
            //   ),
            // ),
            SlidingBox(_controller, Colors.blue[900], Interval(0.8, 1.0)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class SlidingBox extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final Interval interval;

  SlidingBox(this.controller, this.color, this.interval);

  //傳給我的controller自動複製到controller
  //傳給我的color自動複製到color

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: Offset.zero, end: Offset(0.1, 0))
          .chain(CurveTween(curve: Curves.bounceOut))
          .chain(CurveTween(curve: interval))
          .animate(controller), //Offset.zero = Offset(0, 0)
      child: Container(
        width: 300,
        height: 100,
        color: color,
      ),
    );
  }
}
