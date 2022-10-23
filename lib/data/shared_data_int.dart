part of '../com_flutter_client.dart';

/// [SharedIntData] is a [SharedData] that stores a [String].
class SharedIntData extends SharedData<int> {
  /// Creates a [SharedIntData] instance.
  SharedIntData({required super.key, required super.initValue});

  @override
  Future<bool> _saveValue(value) =>
      _prefs.then((prefs) => prefs.setInt(key, value));

  @override
  Future<int> _loadValue() =>
      _prefs.then((prefs) => prefs.getInt(key) ?? initValue);
}
