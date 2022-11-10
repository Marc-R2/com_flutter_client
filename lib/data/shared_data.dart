part of '../com_flutter_client.dart';

/// [SharedData] is a [GlobalData] that is also stored in [SharedPreferences].
abstract class SharedData<T> extends GlobalData<T> {
  /// Creates a [SharedData] instance.
  SharedData({
    required super.key,
    required this.initValue,
  }) : super.withoutValue() {
    super.value = initValue;
    init = _loadValue().then((value) {
      super.value = value;
      _isReady = true;
    });
  }

  /// The Future that is completed when the value is loaded from
  /// [SharedPreferences]. (Init is completed)
  late final Future<void> init;

  bool _isReady = false;

  /// The initial value of the [SharedData].
  final T initValue;

  /// The [SharedPreferences] that the [SharedData] is stored in.
  final _prefs = SharedPreferences.getInstance();

  /// Method to set the value of the [SharedData] asynchronously.
  ///
  /// This is useful when you want to make sure the data really is stored.
  ///
  /// [force] can be used to force the value to be set in global data even if
  /// setting the value in [SharedPreferences] fails.
  Future<bool> setSharedValue(
    T value, {
    bool force = false,
    bool notify = true,
  }) async {
    if (force) setValue(value, notify: notify);
    final result = await _saveValue(value);
    if (result && !force) setValue(value, notify: notify);
    if (!result) {
      Message.warning(
        title: 'Failed to save data',
        text: 'shared preferences returned false when trying '
            'to save {type}: {key} = {value}',
        templateValues: {
          'type': T.toString(),
          'key': key,
          'value': value.toString(),
        },
      );
    }
    return result;
  }

  @override
  set value(T value) => setSharedValue(value, force: true);

  @override
  T get value => _isReady ? super.value : initValue;

  Future<bool> _saveValue(T value);

  Future<T> _loadValue();
}
