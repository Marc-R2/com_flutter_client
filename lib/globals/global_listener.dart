part of '../com_flutter_client.dart';

class GlobalListener<T> {
  final String key;
  final void Function(T) listener;
  final GlobalData<T> data;

  GlobalListener(this.key, this.listener, this.data) {
    GlobalController.registerGlobalListener(this);
  }

  void dispose() {
    GlobalController.unregisterGlobalListener(this);
    data.removeListener(this);
  }

  T get value => data.value;
}
