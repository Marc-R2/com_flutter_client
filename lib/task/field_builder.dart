part of '../com_flutter_client.dart';

class FieldBuilder extends StatelessWidget {
  const FieldBuilder({
    required this.builder,
    required this.field,
    this.task,
    super.key,
    this.onTaskNotFound,
    this.onWaiting,
    this.onError,
  });

  final String field;

  final TaskRequest? task;

  final Widget Function(BuildContext, TaskAnswer) builder;

  final Widget? onTaskNotFound;

  final Widget? onWaiting;

  final Widget? onError;

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
          return builder(context, snapshot.data!);
        } else if (snapshot.hasError) {
          return onError ?? Text('Error: ${snapshot.error}');
        }
        return onWaiting ?? const CircularProgressIndicator();
      },
    );
  }
}

class TaskNotFound extends StatelessWidget {
  const TaskNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Could not find any task in Scope or direct'),
    );
  }
}
