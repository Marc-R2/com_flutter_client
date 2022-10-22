part of '../../../com_flutter_client.dart';

class LogConsolePage extends DynamicPage {
  const LogConsolePage({super.key});

  @override
  Map<String, DynamicPage> get pages => {};

  @override
  Widget build(BuildContext context) => const LogConsole();
}

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

  bool filter(Message message) {
    if (message.type == 0 && !showDebug) return false;
    if (message.type == 1 && !showInfo) return false;
    if (message.type == 2 && !showWarning) return false;
    if (message.type == 3 && !showError) return false;
    if (message.type == 9 && !showTrace) return false;
    return true;
  }

  void toMessage(BuildContext context, int id) => context.beamToChild('$id');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Logger().stream,
      builder: (context, snapshot) {
        final messages = Logger.messages.values.toList();
        final filtered = messages.where(filter).toList().reversed.toList();
        if (filtered.isEmpty) {
          return const Center(child: Text('Nothing to show here'));
        }
        return Scrollbar(
          radius: const Radius.circular(10),
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final message = filtered[index];
              return Card(
                color: message.color,
                child: ListTile(
                  title: Text(message.replaceTemplates(message.title)),
                  dense: true,
                  leading: message.icon,
                  onTap: () => toMessage(
                    context,
                    message.time.millisecondsSinceEpoch,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// Extend the Message class with the color and icon
extension MessageMaterial on Message {
  Color? get color {
    switch (type) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      case 9:
        return Colors.greenAccent;
    }
    return null;
  }

  Icon get icon {
    switch (type) {
      case 1:
        return const Icon(Icons.info_outline);
      case 2:
        return const Icon(Icons.warning);
      case 3:
        return const Icon(Icons.error_outline);
      case 9:
        return const Icon(Icons.bug_report);
    }
    return const Icon(Icons.info_outline);
  }
}
