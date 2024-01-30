import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shared Preferences'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isBulbOn = false;

  @override
  void initState() {
    readStoredValue();
    super.initState();
  }

  readStoredValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBulbOn = prefs.getBool('IS_BULB_ON') ?? false;
    });
  }

  void _toggleBulb() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBulbOn = !_isBulbOn;
    });
    await prefs.setBool('IS_BULB_ON', _isBulbOn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                _isBulbOn ? Icons.lightbulb : Icons.lightbulb_outline,
                size: 150.0, // Increased size
                color: _isBulbOn ? Colors.yellow : Colors.grey,
              ),
              onPressed: _toggleBulb,
            ),
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _toggleBulb,
              child: Text(_isBulbOn ? 'Turn Off' : 'Turn On'),
            ),
          ],
        ),
      ),
    );
  }
}
