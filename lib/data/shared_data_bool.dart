part of '../com_flutter_client.dart';

/// [SharedBoolData] is a [SharedData] that stores a [String].
class SharedBoolData extends SharedData<bool> {
  /// Creates a [SharedBoolData] instance.
  SharedBoolData({required super.key, required super.initValue});

  @override
  Future<bool> _saveValue(value) =>
      _prefs.then((prefs) => prefs.setBool(key, value));

  @override
  Future<bool> _loadValue() =>
      _prefs.then((prefs) => prefs.getBool(key) ?? initValue);
}
