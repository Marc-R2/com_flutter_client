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

/// [SharedNullStringData] is a [SharedData] that stores a [String].
class SharedNullStringData extends SharedData<String?> {
  /// Creates a [SharedNullStringData] instance.
  SharedNullStringData({required super.key, super.initValue});

  @override
  Future<bool> _saveValue(value) async {
    if (value == null) return _prefs.then((prefs) => prefs.remove(key));
    return _prefs.then((prefs) => prefs.setString(key, value));
  }

  @override
  Future<String?> _loadValue() =>
      _prefs.then((prefs) => prefs.getString(key));
}
