part of '../com_flutter_client.dart';

/// [SharedStringListData] is a [SharedData] that stores a [String].
class SharedStringListData extends SharedData<List<String>> {
  /// Creates a [SharedStringListData] instance.
  SharedStringListData({required super.key, required super.initValue});

  @override
  Future<bool> _saveValue(value) =>
      _prefs.then((prefs) => prefs.setStringList(key, value));

  @override
  Future<List<String>> _loadValue() =>
      _prefs.then((prefs) => prefs.getStringList(key) ?? initValue);
}
