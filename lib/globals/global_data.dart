part of '../com_flutter_client.dart';

class GlobalData<T> {
  GlobalData({required this.key, required T value}) {
    this.value = value;
  }

  GlobalData.withoutValue({required this.key});

  GlobalData.withoutKey({required T value}) : key = DateTime.now().toString() {
    this.value = value;
  }

  final String key;

  set value(T value) => GlobalController.setGlobalData<T>(key, value);

  T get value => GlobalController._globalData[T]?[key] as T;

  final List<GlobalListener<T>> listeners = [];

  GlobalListener<T> listen(void Function(T) listen) {
    final listener = GlobalListener<T>(key, listen, this);
    listeners.add(listener);
    return listener;
  }

  void removeListener(GlobalListener<T> listener) {
    listeners.remove(listener);
  }

  void dispose() {
    for (final listener in listeners) {
      listener.dispose();
    }
  }
}
