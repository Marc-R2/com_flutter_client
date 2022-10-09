import 'package:com_client/com_client.dart';

class ApplinkService extends LocalService {
  ApplinkService({required super.com}) : super(service: 'backlink');

  late final applink = ApplinkTask(service: this);
}

class ApplinkTask extends LocalTask {
  ApplinkTask({required super.service}) : super(task: 'applink');

  @override
  List<LocalField<LocalTask>> get fields => [];

  late final msServer = LocalField<ApplinkTask>(
    name: 'millisecondOnServer',
    task: this,
  );

  // Override the call method to make it easier to use
  TaskRequest? call() => msServer.request();
}
