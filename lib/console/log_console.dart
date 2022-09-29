part of '../com_flutter_client.dart';

class LogConsole extends StatelessWidget {
  const LogConsole({
    this.showTrace = false,
    this.showDebug = false,
    this.showInfo = true,
    this.showWarning = true,
    this.showError = true,
    super.key,
  });

  final bool showTrace;
  final bool showDebug;
  final bool showInfo;
  final bool showWarning;
  final bool showError;

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

  Icon _icon(int type) {
    switch (type) {
      case 1:
        return const Icon(Icons.info_outline);
      case 2:
        return const Icon(Icons.warning);
      case 3:
        return const Icon(Icons.error_outline);
    }
    return const Icon(Icons.info_outline);
  }

  bool filter(Message message) {
    if (message.type == 0 && !showTrace && !showDebug) return false;
    if (message.type == 1 && !showInfo) return false;
    if (message.type == 2 && !showWarning) return false;
    if (message.type == 3 && !showError) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Logger().stream,
      builder: (context, snapshot) {
        final keys = Logger.messages.keys.toList();
        final length = Logger.messages.length;
        int counter = 0;
        return ListView.builder(
          itemCount: length,
          itemBuilder: (context, index) {
            final message = Logger.messages[keys[length - index - 1]];
            if (message == null || !filter(message)) {
              if (counter == 0 && index + 1 >= length) {
                return const Center(child: Text('Nothing to show here'));
              }
              return const SizedBox();
            }
            counter++;
            return Card(
              color: _color(message.type),
              child: ListTile(
                title: Text(message.replaceTemplates(message.title)),
                dense: true,
                leading: _icon(message.type),
              ),
            );
          },
        );
      },
    );
  }
}
