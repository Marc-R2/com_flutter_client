part of '../com_flutter_client.dart';

class LogMessagePage extends StatelessWidget {
  const LogMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final messageId =
        int.tryParse(context.beamState!.pathParameters['message']!) ?? 0;
    final message = Logger.messages[messageId];

    if (message == null) {
      return const Scaffold(
        body: Center(
          child: Text('404 - Message Not Found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Log Message - ${message.title}'),
        backgroundColor: message.color ?? Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message.titleString,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 16),
          Text(
            message.textString,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 16),
          Text(
            message.time.toString(),
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Beamer.of(context).beamBack(),
            child: const Text('Navigate Back'),
          ),
        ],
      ),
    );
  }
}
