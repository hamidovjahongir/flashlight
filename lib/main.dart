import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashlight Toggle',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FlashlightPage(),
    );
  }
}

class FlashlightPage extends StatefulWidget {
  @override
  _FlashlightPageState createState() => _FlashlightPageState();
}

class _FlashlightPageState extends State<FlashlightPage> {
  static const platform = MethodChannel('samples.flutter.dev/flashlight');
  bool _isFlashlightOn = false;

  Future<void> _toggleFlashlight() async {
    try {
      if (_isFlashlightOn) {
        await platform.invokeMethod('turnOff');
        setState(() {
          _isFlashlightOn = false;
        });
      } else {
        await platform.invokeMethod('turnOn');
        setState(() {
          _isFlashlightOn = true;
        });
      }
    } on PlatformException catch (e) {
      print("Xatolik: '${e.message}'");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flashlight Toggle')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              _isFlashlightOn ? Icons.flashlight_on : Icons.flashlight_off,
              size: 100,
              color: _isFlashlightOn ? Colors.yellow : Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              _isFlashlightOn ? 'Flashlight ON' : 'Flashlight OFF',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _isFlashlightOn ? Colors.yellow : Colors.grey,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _toggleFlashlight,
              child: Text(
                _isFlashlightOn ? 'Ochirish' : 'Yoqish',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFlashlightOn ? Colors.red : Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
