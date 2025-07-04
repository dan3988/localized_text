import 'package:flutter/material.dart';
import 'package:localized_text_widget/localized_text_widget.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Localized Text Widget',
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  build(context) {
    return Scaffold(
      body: Column(
        children: [
          // show same text ignoring current locale
          Localized(text: LocalizedText.static('static text')),
          // show localized text using AppLocalizations generated by flutter_localizations
          Localized(text: LocalizedTextGetter<AppLocalizations>.getter((l) => l.localizedText)),
          // show localized using class generated by localized_text_key_generator
          const Localized(text: AppLocalizationsKey.localizedText),
        ],
      ),
    );
  }
}
