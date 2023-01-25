import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pay Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double? _rate = 0;
  double? _hours = 0;
  double? _regular = 0;
  double? _extra = 0;
  double? _total = 0;
  double? _tax = 0;

  //creating a controller to retrieve data from the Rate Text Field
  final hoursController = TextEditingController();

  //creating a controller to retrieve data from the Rate Text Field
  final rateController = TextEditingController();
  @override
  void dispose() {
    rateController.dispose();
    super.dispose();
  }

  void _calculatePay() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      _rate = double.tryParse(rateController.text);
      _hours = double.tryParse(hoursController.text);

      if (_rate != null && _hours != null) {
        if (_hours! >= 40) {
          _regular = _rate! * 40;
          _extra = (_hours! - 40) * (_rate! * 1.5);
          _total = _regular! + _extra!;
        } else {
          _regular = _rate! * _hours!;
          _extra = 0;
          _total = _regular!;
        }
        _tax = _total! * 0.18;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextField(
                controller: rateController,
                decoration: InputDecoration(
                  hintText: 'Enter your hourly rate...',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextField(
                controller: hoursController,
                decoration: InputDecoration(
                    hintText: 'Enter the amount of hours you worked...'),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: _calculatePay,
              child: Text('Calculate'),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            ),
            Text(
              'REPORT',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.left,
            ),
            Text(
              'Regular Pay: ' + _regular.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Overtime Pay: ' + _extra.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Total Pay: ' + _total.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Tax: ' + _tax.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            ),
            Text(
              'Adriana Diaz Torres',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '301157161',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
