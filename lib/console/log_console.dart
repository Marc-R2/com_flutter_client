part of '../com_flutter_client.dart';

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

  Color? _color(int type) {
    switch (type) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Logger().stream,
      builder: (context, snapshot) {
        final keys = Logger.messages.keys.toList();
        final length = Logger.messages.length;
        return ListView.builder(
          itemCount: Logger.messages.length,
          itemBuilder: (context, index) {
            final message = Logger.messages[keys[length - index - 1]];
            if (message == null) return const SizedBox();
            return Card(
              color: _color(message.type),
              child: ListTile(
                title: Text(message.replaceTemplates(message.title)),
                dense: true,
              ),
            );
          },
        );
      },
    );
  }
}
