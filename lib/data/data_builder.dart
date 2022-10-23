part of '../com_flutter_client.dart';

class DataBuilder<T> extends StatefulWidget {
  const DataBuilder({super.key, required this.data, required this.builder});

  final GlobalData<T> data;

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
