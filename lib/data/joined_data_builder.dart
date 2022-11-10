part of '../com_flutter_client.dart';

/// Flutter Widget Builder for [GlobalData].
///
/// [JoinedDataBuilder] is used to build a widget based on a [GlobalData].
///
/// the [builder] function is called when the [GlobalData] changes.
class JoinedDataBuilder<T> extends StatefulWidget {
  /// Creates a [JoinedDataBuilder] that builds a widget based on [GlobalData]s.
  ///
  /// [builder] is the function that is called when the [GlobalData] changes.
  ///
  /// [data] is the [GlobalData] that is listened to.
  const JoinedDataBuilder({
    super.key,
    required this.data,
    required this.builder,
  });

  /// The [GlobalData] that this [JoinedDataBuilder] listens to.
  final List<GlobalData<T>> data;

  /// The function that is called when the [GlobalData] changes.
  final Widget Function(BuildContext context, T? data) builder;

  @override
  State<JoinedDataBuilder<T>> createState() => _JoinedDataBuilderState<T>();
}

class _JoinedDataBuilderState<T> extends State<JoinedDataBuilder<T>> {
  late JoinedGlobalListener<T> listener;

  T? value;

  @override
  void initState() {
    super.initState();
    listener = JoinedGlobalListener<T>.fromList(update, widget.data);
  }

  @override
  void dispose() {
    listener.dispose();
    super.dispose();
  }

  void update(T data) {
    value = data;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, value);
}
