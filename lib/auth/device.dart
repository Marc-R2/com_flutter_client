import 'package:com_auth_service_dart/com_auth_service_dart.dart';
import 'package:com_flutter_client/com_flutter_client.dart';

class Device {
  factory Device() => _instance;

  Device._internal() {
    init();
  }

  static final Device _instance = Device._internal();

  final _deviceKey = SharedNullStringData(key: 'com-auth-deviceKey');

  final _deviceID = SharedNullStringData(key: 'com-auth-deviceID');

  final _sessionKey = GlobalData.nullable<String>();

  void init() async {
    await _deviceKey.init;
    _deviceKey.value ??= _generateDeviceKey();
    await _deviceID.init;
    if (_deviceID.value == null) await _getDeviceID();
  }

  Future<void> _getDeviceID() async {
    final res = await ComClient.answer(
      AuthService.device.registerDevice,
      data: {'deviceKey': _deviceKey.value},
    );
    if (res.status == 2 && res.value != null) {
      _deviceID.value = res.value as String;
    }
  }

  String _generateDeviceKey() {
    final key = StringBuffer();
    for (var i = 0; i < 16; i++) {
      key.write(ID.getRandomString(8));
    }
    return key.toString();
  }
}
