part of '../com_flutter_client.dart';

class GlobalController {
  static Map<Type, Map<String, dynamic>> _globalData = {};

  static Map<Type, List<GlobalListener<dynamic>>> _globalListeners = {};

  static void registerGlobalListener<T>(GlobalListener<T> listener) {
    _globalListeners[T] ??= [];
    _globalListeners[T]!.add(listener);
  }

  static void unregisterGlobalListener<T>(GlobalListener<T> listener) {
    _globalListeners[T] ??= [];
    _globalListeners[T]!.remove(listener);
  }

  static void setGlobalData<T>(String key, T data) {
    _globalData[T] ??= {};
    _globalData[T]![key] = data;

    _globalListeners[T]?.forEach((listener) {
      if (listener.key == key) listener.listener(data);
    });
  }
}
