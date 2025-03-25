# localized_text_widget [![Pub Package](https://img.shields.io/pub/v/localized_text_widget.svg)](https://pub.dev/packages/localized_text_widget)

Use with the [`localized_text_key_generator`](../generator) package to simplify text widgets with localized text using .arb files

## Example

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
return Localized(text: LocalizedTextGetter<AppLocalizationsKey>.getter((l) => l.text))
```
or when using the code generator
```dart
return Localized(text: AppLocalizationsKey.text)
```