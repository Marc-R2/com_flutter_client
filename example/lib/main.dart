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

  TaskRequest? _task;

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
    setState(() => _task = null);
    await Future<void>.delayed(const Duration(seconds: 1));
    final now1 = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      _task = ping.ping.request(fields: [ping.ping.wait]);
    });
    if (_task == null) return;
    final ms = await _task!.getField('millisecondOnServer');
    final now2 = DateTime.now().millisecondsSinceEpoch;
    final msServer = int.tryParse('${ms.value}');
    Message.log(
      title: 'Ping: {ms}ms',
      templateValues: {'ms': '$msServer'},
    );
    if (msServer is int) {
      Message.warning(
        title: 'Ping: {ms}ms / {ms2}ms',
        templateValues: {'ms': '${now2 - now1}', 'ms2': '${msServer - now1}'},
      );
      _counter = msServer;
    }
    // setState(() => _counter = msServer);
  }

  Future<void> _pingRepeat() async {
    for (var i = 0; i < 1024; i++) {
      _ping();
      await Future<void>.delayed(const Duration(milliseconds: 8));
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
            ColoredBox(
              color: Colors.grey,
              child: SizedFieldBuilder(
                task: _task,
                width: 200,
                height: 100,
                field: 'millisecondOnServer',
                onNull: const Text('Task contains no value'),
                builder: (context, answer) {
                  return Text(
                    'ms: ${answer.value}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
            ),
            FieldBuilder(
              task: _task,
              field: 'millisecondOnServer',
              builder: (context, answer) {
                final ms = int.tryParse('${answer.value}');
                return Text(
                  'ms: $ms',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            TaskRequestScope(
              task: _task,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(),
                  const Text('millisecondOnServer'),
                  FieldBuilder(
                    field: 'millisecondOnServer',
                    builder: (context, answer) {
                      final ms = int.tryParse('${answer.value}');
                      return Text(
                        'ms: $ms',
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    },
                  ),
                  const Divider(),
                ],
              ),
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
