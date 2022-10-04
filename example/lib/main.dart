//import 'package:com_flutter_client/com_flutter_client.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

void main() {
  // Message.info(title: 'App is starting');
  runApp(MyHomePageTemp());
}
/*
class MyHomePage extends DynamicPage {
  const MyHomePage({super.key});

  @override
  get pages => {};

  @override
  Widget build(BuildContext context) => const MyHome();
}
*/

class MyHomePageTemp extends StatelessWidget {
  MyHomePageTemp({super.key});

  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const MyHome(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      /*
      Message.info(
        title: 'Incremented to {counter}',
        templateValues: {'counter': '$_counter'},
      );
      */
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // const Expanded(child: InteractiveConsole()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
