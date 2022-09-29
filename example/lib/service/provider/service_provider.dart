import 'package:com_client/com_client.dart';

class ProviderService extends LocalService {
  ProviderService({required super.com}) : super(service: 'provider');

  late final services = ServicesTask(service: this);
}

class ServicesTask extends LocalTask {
  ServicesTask({required super.service}) : super(task: 'services');

  @override
  List<LocalField<LocalTask>> get fields => [getServices];

  final getServices = const LocalField<ServicesTask>(name: 'getServices');
}

class PingService extends LocalService {
  PingService({required super.com}) : super(service: 'testService');

  late final ping = PingTask(service: this);
}

class PingTask extends LocalTask {
  PingTask({required super.service}) : super(task: 'ping');

  @override
  List<LocalField<LocalTask>> get fields => [];

  final ping = const LocalField<ServicesTask>(name: 'ping');
  final secServer = const LocalField<ServicesTask>(name: 'secondOnServer');
  final msServer = const LocalField<ServicesTask>(name: 'millisecondOnServer');
  final usServer = const LocalField<ServicesTask>(name: 'microsecondOnServer');
  final wait = const LocalField<ServicesTask>(name: 'waitAndReturnSec');
}
