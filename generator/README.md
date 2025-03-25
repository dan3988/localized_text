# localized_text_key_generator

Code generator that creates an implementation of [LocalizedText](../core/lib/src/getter.dart) for each key in an .arb file

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
import 'package:localized_text_widget/localized_text_widget.dart';
import 'package:localized_text_example/l10n/localizations.dart' as l;

sealed class AppLocalizationsKey
    extends LocalizedTextGetter<l.AppLocalizations> {
  const AppLocalizationsKey();

  /// No description provided for @placeholders.
  ///
  /// In en, this message translates to:
  /// **'Hello {firstName} {lastName}'**
  const factory AppLocalizationsKey.placeholders(
    String firstName,
    String lastName,
  ) = _C1;

  /// A gendered message
  ///
  /// In en, this message translates to:
  /// **'{gender, select, male{he} female{she} other{they}}'**
  const factory AppLocalizationsKey.pronoun(String gender) = _C2;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  static const AppLocalizationsKey text = _C0();
}

final class _C0 extends AppLocalizationsKey {
  const _C0();

  @override
  getFor(l) {
    return l.text;
  }

  @override
  toString() {
    return 'AppLocalizationsKey("text")';
  }
}

final class _C1 extends AppLocalizationsKey {
  const _C1(
    this.firstName,
    this.lastName,
  );

  final String firstName;

  final String lastName;

  @override
  getFor(l) {
    return l.placeholders(firstName, lastName);
  }

  @override
  toString() {
    return 'AppLocalizationsKey("placeholders")';
  }
}

final class _C2 extends AppLocalizationsKey {
  const _C2(this.gender);

  final String gender;

  @override
  getFor(l) {
    return l.pronoun(gender);
  }

  @override
  toString() {
    return 'AppLocalizationsKey("pronoun")';
  }
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
return Localized(text: AppLocalizationsKey.text)
```