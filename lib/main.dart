import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlashlightPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FlashlightPage extends StatefulWidget {
  @override
  _FlashlightPageState createState() => _FlashlightPageState();
}

class _FlashlightPageState extends State<FlashlightPage> {
  bool _isOn = false;

  Future<void> _toggleFlashlight() async {
    try {
      if (_isOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        _isOn = !_isOn;
      });
    } catch (e) {
      print("Xatolik: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isOn ? Colors.yellow[100] : Colors.grey[300],
      appBar: AppBar(title: const Text("Fonarni boshqarish")),
      body: Center(
        child: IconButton(
          iconSize: 100,
          icon: Icon(
            _isOn ? Icons.flashlight_on : Icons.flashlight_off,
            color: _isOn ? Colors.amber : Colors.black,
          ),
          onPressed: _toggleFlashlight,
        ),
      ),
    );
  }
}
