part of '../com_flutter_client.dart';

void beamBack(BuildContext context) {
  Beamer.of(context).beamBack();
}

class GoBackIcon extends StatelessWidget {
  const GoBackIcon({
    this.icon,
    super.key,
  });

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => beamBack(context),
      icon: icon ?? const Icon(Icons.arrow_back),
    );
  }
}
