part of '../com_flutter_client.dart';

class LocalText extends StatelessWidget {
  const LocalText({
    required this.id,
    required this.en,
    this.de,
    this.fallbackLanguage = 'en',
    super.key,
  });

  final String id;

  final String en;
  final String? de;

  final String fallbackLanguage;

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;
    return Text(
      lang == 'en' ? en : de ?? en,
    );
  }
}
