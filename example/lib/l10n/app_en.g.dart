import 'package:localized_text_widget/localized_text_widget.dart';
import 'package:localized_text_example/l10n/localizations.dart' as l;

enum AppLocalizationsKey implements LocalizedText {
  /// Key for [l.AppLocalizations.test]
  test(_g0);

  const AppLocalizationsKey(this._getter);

  final LocalizationGetter<l.AppLocalizations> _getter;

  @override
  get(context) {
    return LocalizedText.invoke(context, _getter);
  }
}

String _g0(l.AppLocalizations l) {
  return l.test;
}
