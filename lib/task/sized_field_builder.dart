part of '../com_flutter_client.dart';

class SizedFieldBuilder extends StatelessWidget {
  const SizedFieldBuilder({
    this.width,
    this.height,
    required this.builder,
    required this.field,
    this.task,
    this.onTaskNotFound,
    this.onWaiting,
    this.onError,
    this.onNull,
    super.key,
  });

  final double? width;

  final double? height;

  final String field;

  final TaskRequest? task;

  final Widget Function(BuildContext, TaskAnswer) builder;

  final Widget? onTaskNotFound;

  final Widget? onWaiting;

  final Widget? onError;

  final Widget? onNull;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: FieldBuilder(
          field: field,
          builder: builder,
          task: task,
          onTaskNotFound: onTaskNotFound,
          onWaiting: onWaiting,
          onError: onError,
          onNull: onNull,
        ),
      ),
    );
  }
}
