// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// LocalizationResolverGenerator
// **************************************************************************

// ignore_for_file: prefer_relative_imports, require_trailing_commas

import 'package:localized_text_widget/localized_text_widget.dart';
import 'package:localized_text_example/l10n/localizations.dart' as l;

sealed class AppText extends LocalizationMessage<l.AppLocalizations> {
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
  getText(
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
  getText(
    c,
    l,
  ) =>
      l.placeholders(
        Message.getString(
          c,
          firstName,
        ),
        Message.getString(
          c,
          lastName,
        ),
      );

  @override
  toString() => 'AppText.placeholders';
}

final class _C2 extends AppText {
  const _C2({required this.gender});

  final Object gender;

  @override
  getText(
    c,
    l,
  ) =>
      l.pronoun(Message.getString(
        c,
        gender,
      ));

  @override
  toString() => 'AppText.pronoun';
}
