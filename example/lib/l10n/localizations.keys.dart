// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// LocalizedTextKeyGenerator
// **************************************************************************

import 'package:localized_text_widget/localized_text_widget.dart';
import 'package:localized_text_example/l10n/localizations.dart' as l;

sealed class AppLocalizationsKey
    extends LocalizedTextGetter<l.AppLocalizations> {
  const AppLocalizationsKey();

  /// No description provided for @placeholders.
  ///
  /// In en, this message translates to:
  /// **'Hello {firstName} {lastName}'**
  const factory AppLocalizationsKey.placeholders({
    required String firstName,
    required String lastName,
  }) = _C1;

  /// A gendered message
  ///
  /// In en, this message translates to:
  /// **'{gender, select, male{he} female{she} other{they}}'**
  const factory AppLocalizationsKey.pronoun({required String gender}) = _C2;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  static const AppLocalizationsKey test = _C0();
}

final class _C0 extends AppLocalizationsKey {
  const _C0();

  @override
  getFor(l) {
    return l.test;
  }
}

final class _C1 extends AppLocalizationsKey {
  const _C1({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;

  final String lastName;

  @override
  getFor(l) {
    return l.placeholders(firstName: firstName, lastName: lastName);
  }
}

final class _C2 extends AppLocalizationsKey {
  const _C2({required this.gender});

  final String gender;

  @override
  getFor(l) {
    return l.pronoun(gender: gender);
  }
}
