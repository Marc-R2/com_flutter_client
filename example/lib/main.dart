import 'package:com_flutter_client/com_flutter_client.dart';
import 'package:example/service/provider/service_provider.dart';
import 'package:flutter/material.dart';

void main() {
  Message.info(title: 'App is starting');
  runApp(COMApp(homePage: const MyHomePage()));
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

  void _ping() async {
    final ms = ping.ping.request(fields: [ping.ping.msServer]);
    final now1 = DateTime.now().millisecondsSinceEpoch;
    await Future.wait(ms.values.toList());
    final now2 = DateTime.now().millisecondsSinceEpoch;
    final msServer = int.parse('${(await ms.values.first).value}');
    Message.log(
      title: 'Ping: {ms}ms',
      templateValues: {'ms': '$msServer'},
    );
    Message.warning(
      title: 'Ping: {ms}ms / {ms2}ms',
      templateValues: {'ms': '${now2 - now1}', 'ms2': '${msServer - now1}'},
    );
    setState(() => _counter = msServer);
  }

  Future<void> _pingRepeat() async {
    for (var i = 0; i < 4096; i++) {
      _ping();
      await Future<void>.delayed(const Duration(milliseconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: const [
          OpenSettingsIcon(),
        ],
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
            TextButton(
              onPressed: _ping,
              child: const Text('Test'),
            ),
            TextButton(
              onPressed: _pingRepeat,
              child: const Text('Test Repeat'),
            ),
            const Expanded(child: LogConsole(showInfo: false)),
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
