import 'package:flutter/material.dart';
import 'success.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFC41A3B),
        primaryColorLight: Color(0xFFFBE0E6),
        accentColor: Color(0xFF1B1F32),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String title = 'Payment Animation';

  String _amount = 'Total amount: \$49';

  Animation<Offset> _animationPosition;
  AnimationController _controller;

  double _radius = 5.0; // For Button Radius
  double _width = 248.0; // For Button Width
  double _height = 64.0; // For Button Height

  bool _title = true; // For Button Text
  bool _success = false; // For Payment Completed

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _animationPosition = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, 1.5),
    ).animate(
      CurvedAnimation(curve: Curves.easeIn, parent: _controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // Button Change When Click Then This Properties Called
  void _pay() async {
    setState(() {
      _amount = 'Processing...';
      _radius = 15.0;
      _width = 25.0;
      _height = 25.0;
      _title = false;
    });
    await Future.delayed(
      Duration(
        // For Waiting Button Circle
        milliseconds: 600,
      ),
    );
    _changeSuccess();
    while (!_success) {
      // For Animation in Loop
      await _controller.forward();
      await _controller.reverse();
    }
  }

  void _changeSuccess() async {
    await Future.delayed(
      Duration(milliseconds: 2600),
    );
    setState(() {
      // For Payment Complete!
      _success = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Success(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SlideTransition(
              position: _animationPosition,
              child: Hero(
                tag: 'payment',
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  height: _height,
                  width: _width,
                  curve: Curves.fastOutSlowIn,
                  decoration: BoxDecoration(
                    color: Color(0xFFC41A3B),
                    borderRadius: BorderRadius.circular(_radius),
                  ),
                  child: _title
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Color(0xFFC41A3B),
                            onTap: () {
                              _pay();
                            },
                            child: Center(
                              child: Text(
                                'Pay',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: Color(0xFFC41A3B),
                ),
              ),
              child: Text(
                _amount,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}