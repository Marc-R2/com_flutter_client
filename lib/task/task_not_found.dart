part of '../com_flutter_client.dart';

class TaskNotFound extends StatelessWidget {
  const TaskNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Could not find any task in Scope or direct'),
    );
  }
}
