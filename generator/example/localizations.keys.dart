// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// LocalizedTextKeyGenerator
// **************************************************************************

// ignore_for_file: prefer_relative_imports, require_trailing_commas

import 'package:localized_text_widget/localized_text_widget.dart';
import 'localizations.dart' as l;

sealed class AppText extends LocalizedTextGetter<l.AppLocalizations> {
  const AppText();

  /// No description provided for @placeholders.
  ///
  /// In en, this message translates to:
  /// **'Hello {firstName} {lastName}'**
  const factory AppText.placeholders({
    required Object firstName,
    required Object lastName,
  }) = _C1;

  /// A gendered message
  ///
  /// In en, this message translates to:
  /// **'{gender, select, male{he} female{she} other{they}}'**
  const factory AppText.pronoun({required Object gender}) = _C2;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  static const AppText test = _C0();
}

final class _C0 extends AppText {
  const _C0();

  @override
  getFor(
      c,
      l,
      ) =>
      l.test;

  @override
  toString() => 'AppText.test';
}

final class _C1 extends AppText {
  const _C1({
    required this.firstName,
    required this.lastName,
  });

  final Object firstName;

  final Object lastName;

  @override
  getFor(
      c,
      l,
      ) =>
      l.placeholders(
        firstName is LocalizedText
            ? (firstName as LocalizedText).get(c)
            : firstName.toString(),
        lastName is LocalizedText
            ? (lastName as LocalizedText).get(c)
            : lastName.toString(),
      );

  @override
  toString() => 'AppText.placeholders';
}

final class _C2 extends AppText {
  const _C2({required this.gender});

  final Object gender;

  @override
  getFor(
      c,
      l,
      ) =>
      l.pronoun(gender is LocalizedText
          ? (gender as LocalizedText).get(c)
          : gender.toString());

  @override
  toString() => 'AppText.pronoun';
}
