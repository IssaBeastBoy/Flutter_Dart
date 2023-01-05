import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? _batteryLevel;
  Future<void> _getBatterLevel() async {
    const platform = MethodChannel('battery.life/get');
    try {
      final batteryLevel = await platform.invokeListMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = batteryLevel as int;
      });
    } catch (err) {
      setState(() {
        _batteryLevel = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(
        child: Text('Error getting battery life'),
      )));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native Code'),
      ),
      body: Center(
        child: Text('Battery Level: $_batteryLevel'),
      ),
    );
  }
}
