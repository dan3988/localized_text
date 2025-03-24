// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// LocalizedTextKeyGenerator
// **************************************************************************

// ignore_for_file: prefer_relative_imports

import 'package:localized_text_widget/localized_text_widget.dart';
import 'package:localized_text_example/l10n/localizations.dart' as l;

sealed class AppText extends LocalizedTextGetter<l.AppLocalizations> {
  const AppText();

  /// No description provided for @placeholders.
  ///
  /// In en, this message translates to:
  /// **'Hello {firstName} {lastName}'**
  const factory AppText.placeholders({
    required String firstName,
    required String lastName,
  }) = _C1;

  /// A gendered message
  ///
  /// In en, this message translates to:
  /// **'{gender, select, male{he} female{she} other{they}}'**
  const factory AppText.pronoun({required String gender}) = _C2;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  static const AppText test = _C0();
}

final class _C0 extends AppText {
  const _C0();

  @override
  getFor(l) {
    return l.test;
  }
}

final class _C1 extends AppText {
  const _C1({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;

  final String lastName;

  @override
  getFor(l) {
    return l.placeholders(firstName, lastName);
  }
}

final class _C2 extends AppText {
  const _C2({required this.gender});

  final String gender;

  @override
  getFor(l) {
    return l.pronoun(gender);
  }
}
