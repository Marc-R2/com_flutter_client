part of '../com_flutter_client.dart';

class FieldBuilder extends StatelessWidget {
  const FieldBuilder({
    required this.builder,
    required this.field,
    this.task,
    this.onTaskNotFound,
    this.onWaiting,
    this.onError,
    this.onNull,
    super.key,
  });

  final String field;

  final TaskRequest? task;

  final Widget Function(BuildContext, TaskAnswer) builder;

  final Widget? onTaskNotFound;

  final Widget? onWaiting;

  final Widget? onError;

  final Widget? onNull;

  TaskRequest? getTask(BuildContext context) {
    if (task != null) return task;
    final taskScope = context.findAncestorStateOfType<_TaskRequestScopeState>();
    if (taskScope != null) return taskScope.task;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final task = getTask(context);
    if (task == null) return onTaskNotFound ?? const TaskNotFound();
    final fieldTask = task.getField(field);
    return FutureBuilder(
      future: fieldTask,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data! as TaskAnswer;
          if ((data.value == null || data.valueType == 'empty') &&
              onNull != null) return onNull!;
          if (data.status != 2 && onError != null) return onError!;
          return builder(context, data);
        } else if (snapshot.hasError) {
          return onError ?? Text('Error: ${snapshot.error}');
        }
        return onWaiting ?? const CircularProgressIndicator();
      },
    );
  }
}
