import 'package:com_flutter_client/com_flutter_client.dart';
import 'package:example/service/provider/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:com_flutter_client/com_flutter_client.dart';

void main() {
  // Message.info(title: 'App is starting');
  runApp(const COMApp(homePage: MyHomePage()));
}

class MyHomePage extends DynamicPage {
  const MyHomePage({super.key});

  @override
  get pages => {};

  @override
  Widget build(BuildContext context) => const MyHome();
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _counter = 0;

  /// Assign via [com] or remember to connect the client before using it.
  late ComSocket _com;

  ComSocket get com {
    if (!_com.ready) _initClient();
    return _com;
  }

  set com(ComSocket com) {
    _com = com;
    _initClient();
  }

  void _initClient() {
    _com.init().then((value) async {
      if (_com.exists) await _com.connectClient();
    });
  }

  @override
  void initState() {
    com = ComSocket.fromIP(ip: '192.168.178.132', port: 7000);
    super.initState();
  }

  PingService get ping => PingService(com: com);

  void _incrementCounter() {
    setState(() {
      _counter++;

      Message.info(
        title: 'Incremented to {counter}',
        templateValues: {'counter': '$_counter'},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: const [
          OpenSettingsIcon(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You have pushed the button this many times:'),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
          TextButton(
            onPressed: () async {
              final ms = ping.ping.request(
                fields: [ping.ping.wait],
                data: {'wait': 4096},
              ).values;
              await Future.wait(ms.toList());
              setState(() => _counter = 0);
            },
            child: const Text('Test - Connection to COM'),
          ),
          // const Expanded(child: InteractiveConsole()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
