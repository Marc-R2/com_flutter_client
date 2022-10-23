part of '../com_flutter_client.dart';

/// [SharedDoubleData] is a [SharedData] that stores a [String].
class SharedDoubleData extends SharedData<double> {
  /// Creates a [SharedDoubleData] instance.
  SharedDoubleData({required super.key, required super.initValue});

  @override
  Future<bool> _saveValue(value) =>
      _prefs.then((prefs) => prefs.setDouble(key, value));

  @override
  Future<double> _loadValue() =>
      _prefs.then((prefs) => prefs.getDouble(key) ?? initValue);
}
