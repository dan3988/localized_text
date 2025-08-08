# localized_text_key_generator [![Pub Package](https://img.shields.io/pub/v/localized_text_key_generator.svg)](https://pub.dev/packages/localized_text_key_generator)

Code generator that creates an implementation of [Message](../core/lib/src/getter.dart) for each key in an .arb file

## Configuration

```yaml
targets:
  $default:
    builders:
      localized_text_key_generator:
        options:
          #options
```

| Option             | Description                                                                                    | Default                                                                 |
|--------------------|------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| `named_parameters` | Whether the constructors generated for messages with placeholders should have named parameters | The value of `use-named-parameters` in l10n.yaml                        |
| `output_class`     | The name of the generated class                                                                | The value of `output-class` in l10n.yaml with `Key` appended to the end |

## Example

`app_en.arb`:
```json
{
  "text": "Text",
  "placeholders": "Hello {firstName} {lastName}",
  "@placeholders": {
    "placeholders": {
      "firstName": {
        "type": "String"
      },
      "lastName": {
        "type": "String"
      }
    }
  },
  "pronoun": "{gender, select, male{he} female{she} other{they}}",
  "@pronoun": {
    "description": "A gendered message",
    "placeholders": {
      "gender": {
        "type": "String"
      }
    }
  }
}
```

Output:
```dart
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
```

This can be used to simplify
```dart
return Builder(
  builder: (context) {
    return Text(AppLocalizations.of(context)!.text);
  },
)
```
to
```dart
return const Localized(text: AppLocalizationsKey.text)
```