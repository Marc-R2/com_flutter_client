import 'package:example/service/provider/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:com_flutter_client/com_flutter_client.dart';

void main() {
  Message.info(title: 'App is starting');
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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      await _com.connectClient();
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
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
              onPressed: () async {
                final ms = await ping.ping
                    .request(
                      fields: [ping.ping.wait],
                      data: {'wait': 4096},
                    )
                    .values
                    .first;
              },
              child: const Text(
                'Reset (Test)',
              ),
            ),
            const Expanded(
              child: LogConsole(),
            ),
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

class LogConsole extends StatefulWidget {
  const LogConsole({Key? key}) : super(key: key);

  @override
  State<LogConsole> createState() => _LogConsoleState();
}

class _LogConsoleState extends State<LogConsole> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Logger().stream,
      builder: (context, snapshot) {
        final keys = Logger.messages.keys;
        final length = Logger.messages.length;
        return ListView.builder(
          itemCount: Logger.messages.length,
          itemBuilder: (context, index) {
            //final message = msgs[index];
            final message = Logger.messages[keys.elementAt(length - index - 1)];
            if(message == null) return const SizedBox();
            return ListTile(
              title: Text(message.title),
            );
          },
        );
      },
    );
  }
}
