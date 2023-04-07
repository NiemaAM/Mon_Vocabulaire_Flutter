import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

import 'Widgets/button.dart';

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
      debugShowCheckedModeBanner: false,
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
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Mon Vocabulaire'),
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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Color color = Palette.lightGrey;
  Color color2 = Palette.lightGrey;
  bool _isEnabled = true;
  void call() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Button pressed !")));
    setState(() {
      color = Palette.darkGreen;
      color2 = Palette.red;
      _isEnabled = false;
    });
  }

  void song() {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
      body: SingleChildScrollView(
        child: Center(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Button(
                label: false,
                callback: song,
                isImage: false,
                icon: const Icon(
                  Icons.volume_up,
                  color: Palette.white,
                  size: 50,
                ),
                width: 100,
                heigth: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Foular',
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Button(
                        enabled: _isEnabled,
                        isImage: true,
                        image:
                            "https://cdn-icons-png.flaticon.com/512/1386/1386975.png",
                        color: color,
                        callback: call,
                        heigth: width / 2.1,
                        width: width / 2.1,
                        label: false,
                        radius: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Button(
                        enabled: _isEnabled,
                        isImage: true,
                        image:
                            "https://cdn-icons-png.flaticon.com/512/2806/2806170.png",
                        color: color2,
                        callback: call,
                        heigth: width / 2.1,
                        width: width / 2.1,
                        label: false,
                        radius: 30,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Button(
                        enabled: _isEnabled,
                        isImage: true,
                        image:
                            "https://cdn-icons-png.flaticon.com/512/2300/2300218.png",
                        color: color2,
                        callback: call,
                        heigth: width / 2.1,
                        width: width / 2.1,
                        label: false,
                        radius: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Button(
                        enabled: _isEnabled,
                        isImage: true,
                        image:
                            "https://cdn-icons-png.flaticon.com/512/2806/2806186.png",
                        color: color2,
                        callback: call,
                        heigth: width / 2.1,
                        width: width / 2.1,
                        label: false,
                        radius: 30,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            color = Palette.lightGrey;
            color2 = Palette.lightGrey;
            _isEnabled = true;
          });
        },
        tooltip: 'Clear',
        child: const Icon(Icons.minimize_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
