part of '../com_flutter_client.dart';

void openSettings(BuildContext context) {
  Beamer.of(context).beamToNamed('/${context.lang}/settings');
}

class OpenSettingsIcon extends StatelessWidget {
  const OpenSettingsIcon({
    this.icon,
    super.key,
  });

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => openSettings(context),
      icon: icon ?? const Icon(Icons.settings),
    );
  }
}
