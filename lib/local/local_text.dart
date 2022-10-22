part of '../com_flutter_client.dart';

class LocalText extends StatelessWidget {
  const LocalText(this.ident, {
    this.oj,
    this.en,
    this.de,
    this.fallbackLanguage = 'en',
    super.key,
  });

  final String ident;

  final String? oj;
  final String? en;
  final String? de;

  final String fallbackLanguage;

  @override
  Widget build(BuildContext context) {
    final lang = context.lang;
    return Text(
      (lang == 'en' ? en : (de ?? en)) ?? oj ?? ident,
    );
  }
}

extension LocalTextExtension on Text {
  LocalText local(String ident) => LocalText(ident, oj: data);
}
