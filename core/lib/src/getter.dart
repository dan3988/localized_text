import 'package:flutter/widgets.dart';

abstract class LocalizedText {
  static String invoke<T extends Object>(BuildContext context, LocalizationGetter<T> getter) {
    final localizations = Localizations.of(context, T);
    assert(localizations != null, 'No localizations in scope.');
    return getter(localizations!);
  }

  static LocalizedText fallback(String? text, LocalizedText fallback) => text == null ? fallback : _StaticLocalizedText(text);

  const LocalizedText._();

  const factory LocalizedText.static(String text) = _StaticLocalizedText;

  String get(BuildContext context);
}

final class _StaticLocalizedText extends LocalizedText {
  final String text;

  const _StaticLocalizedText(this.text) : super._();

  @override
  get(_) => text;
}

typedef LocalizationGetter<T> = String Function(T localizations);

final class LocalizedTextGetter<T extends Object> extends LocalizedText {
  final LocalizationGetter<T> getter;

  const LocalizedTextGetter(this.getter) : super._();

  @override
  get(context) => LocalizedText.invoke(context, getter);
}
