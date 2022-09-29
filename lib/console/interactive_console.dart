part of '../com_flutter_client.dart';

class InteractiveConsole extends StatefulWidget {
  const InteractiveConsole({Key? key}) : super(key: key);

  @override
  State<InteractiveConsole> createState() => _InteractiveConsoleState();
}

class _InteractiveConsoleState extends State<InteractiveConsole> {
  bool showTrace = false;
  bool showDebug = false;
  bool showInfo = true;
  bool showWarning = true;
  bool showError = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                PillSelect(
                  selected: showTrace,
                  onChanged: (value) => setState(() => showTrace = value),
                  color: Colors.greenAccent,
                  child: const Text('Trace'),
                ),
                PillSelect(
                  selected: showDebug,
                  onChanged: (value) => setState(() => showDebug = value),
                  color: Colors.green,
                  child: const Text('Debug'),
                ),
                PillSelect(
                  selected: showInfo,
                  onChanged: (value) => setState(() => showInfo = value),
                  color: Colors.blue,
                  child: const Text('Info'),
                ),
                PillSelect(
                  selected: showWarning,
                  onChanged: (value) => setState(() => showWarning = value),
                  color: Colors.orange,
                  child: const Text('Warning'),
                ),
                PillSelect(
                  selected: showError,
                  onChanged: (value) => setState(() => showError = value),
                  color: Colors.red,
                  child: const Text('Error'),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: LogConsole(
            showTrace: showTrace,
            showDebug: showDebug,
            showInfo: showInfo,
            showWarning: showWarning,
            showError: showError,
          ),
        )
      ],
    );
  }
}
