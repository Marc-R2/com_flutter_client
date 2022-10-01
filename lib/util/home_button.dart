part of '../com_flutter_client.dart';

void resetToHome(BuildContext context) {
  Beamer.of(context).beamToNamed('/${context.lang}');
}

class GoHomeIcon extends StatelessWidget {
  const GoHomeIcon({
    this.icon,
    super.key,
  });

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => resetToHome(context),
      icon: icon ?? const Icon(Icons.home),
    );
  }
}
