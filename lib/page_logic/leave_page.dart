part of '../com_flutter_client.dart';

class LeavePage extends DynamicPage {
  const LeavePage({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  BeamPageType get transition => BeamPageType.fadeTransition;

  @override
  Map<String, DynamicPage> get pages => {};

  void _goBack(BuildContext context) => context.beamBack();

  void _endApp(BuildContext context) => SystemNavigator.pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // IgnorePointer(child: child),
          InkWell(
            onTap: () => _goBack(context),
            child: Opacity(
              opacity: 0.75,
              child: Container(color: Colors.black),
            ),
          ),
          AlertDialog(
            title: const Text('Are you sure you want to leave?'),
            actions: [
              TextButton(
                onPressed: () => _goBack(context),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => _endApp(context),
                child: const Text('Yes'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
