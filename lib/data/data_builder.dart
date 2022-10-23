part of '../com_flutter_client.dart';

/// Flutter Widget Builder for [GlobalData].
///
/// [DataBuilder] is used to build a widget based on a [GlobalData].
///
/// the [builder] function is called when the [GlobalData] changes.
class DataBuilder<T> extends StatefulWidget {
  /// Creates a [DataBuilder] that builds a widget based on a [GlobalData].
  ///
  /// [builder] is the function that is called when the [GlobalData] changes.
  ///
  /// [data] is the [GlobalData] that is listened to.
  const DataBuilder({
    super.key,
    required this.data,
    required this.builder,
  });

  /// The [GlobalData] that this [DataBuilder] listens to.
  final GlobalData<T> data;

  /// The function that is called when the [GlobalData] changes.
  final Widget Function(BuildContext context, T data) builder;

  @override
  State<DataBuilder<T>> createState() => _DataBuilderState<T>();
}

class _DataBuilderState<T> extends State<DataBuilder<T>> {
  late GlobalListener<T> listener;

  @override
  void initState() {
    super.initState();
    listener = widget.data.listen(update);
  }

  @override
  void dispose() {
    listener.dispose();
    super.dispose();
  }

  void update(T data) {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, listener.value);
}
