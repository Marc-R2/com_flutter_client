part of '../com_flutter_client.dart';

/// [SharedStringData] is a [SharedData] that stores a [String].
class SharedStringData extends SharedData<String> {
  /// Creates a [SharedStringData] instance.
  SharedStringData({required super.key, required super.initValue});

  @override
  Future<bool> _saveValue(value) =>
      _prefs.then((prefs) => prefs.setString(key, value));

  @override
  Future<String> _loadValue() =>
      _prefs.then((prefs) => prefs.getString(key) ?? initValue);
}
