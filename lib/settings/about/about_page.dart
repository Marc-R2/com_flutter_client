part of '../../com_flutter_client.dart';

class AboutPage extends SettingsChildPage {
  const AboutPage({super.key});

  @override
  Map<String, DynamicPage> get pages => {};

  @override
  Icon get overviewIcon => const Icon(Icons.info);

  @override
  Widget? get overviewSubtitle => null;

  @override
  Widget get overviewTitle => const Text('About');

  static int _debugPressCounter = 0;

  void _pressForDebug() {
    _debugPressCounter++;
    if (_debugPressCounter >= 8) {
      DebugPage.showDebug.value = !DebugPage.showDebug.value;
      _debugPressCounter = 0;
    }
    print(_debugPressCounter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Name:'),
            trailing: Text(COMApp.appName),
          ),
          ListTile(
            title: const Text('Version:'),
            trailing: Text(COMApp.appVersion),
          ),
          ListTile(
            title: const Text('Current Time:'),
            trailing: Text(DateTime.now().toString()),
          ),
          const ListTile(
            title: Text('Published by:'),
            trailing: Text('©2022, BitBot UG'),
          ),
          ListTile(
            title: const Text('Licences:'),
            trailing: TextButton(
              child: const Text(
                'View Licences',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                showLicensePage(
                  context: context,
                  applicationName: COMApp.appName,
                  applicationVersion: COMApp.appVersion,
                  // applicationIcon: applicationIcon,
                  // applicationLegalese: '',
                );
              },
            ),
          ),
          const Divider(),
          const Text(
            'This App was created by:',
            textAlign: TextAlign.center,
          ),
          ...COMApp.appDevelopers.map(
            (author) => ListTile(
              title: Text(author.fullName),
              subtitle: Text('${author.role}, ${author.company} '
                  '${author.email != null ? '(${author.email})' : ''}'),
            ),
          ),
          const Divider(),
          TextButton(
            onPressed: _pressForDebug,
            child: DataBuilder(
                data: DebugPage.showDebug,
                builder: (context, snapshot) {
                  return Text(
                    'This App is based on com_flutter_client '
                    'by Marc Renken @BitBot UG',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: DebugPage.showDebug.value
                          ? Colors.green
                          : Colors.blue,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
