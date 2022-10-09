import 'package:com_client/com_client.dart';

class ProviderService extends LocalService {
  ProviderService({required super.com}) : super(service: 'provider');

  late final services = ServicesTask(service: this);
}

class ServicesTask extends LocalTask {
  ServicesTask({required super.service}) : super(task: 'services');

  @override
  List<LocalField<LocalTask>> get fields => [getServices];

  late final getServices = LocalField<ServicesTask>(
    name: 'getServices',
    task: this,
  );
}

class PingService extends LocalService {
  PingService({required super.com}) : super(service: 'testService');

  late final ping = PingTask(service: this);
}

class PingTask extends LocalTask {
  PingTask({required super.service}) : super(task: 'ping');

  @override
  List<LocalField<LocalTask>> get fields => [];

  late final ping = LocalField<PingTask>(
    name: 'ping',
    task: this,
  );

  late final secServer = LocalField<PingTask>(
    name: 'secondOnServer',
    task: this,
  );

  late final msServer = LocalField<PingTask>(
    name: 'millisecondOnServer',
    task: this,
  );

  late final usServer = LocalField<PingTask>(
    name: 'microsecondOnServer',
    task: this,
  );

  late final wait = LocalField<PingTask>(
    name: 'waitAndReturnSec',
    task: this,
  );
}
