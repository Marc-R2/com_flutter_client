part of '../com_flutter_client.dart';

class TaskRequestScope extends StatefulWidget {
  const TaskRequestScope({
    required this.child,
    required this.task,
    super.key,
  });

  final TaskRequest? task;

  final Widget child;

  @override
  State<TaskRequestScope> createState() => _TaskRequestScopeState();
}

class _TaskRequestScopeState extends State<TaskRequestScope> {
  TaskRequest? get task => widget.task;

  @override
  Widget build(BuildContext context) => widget.child;
}
