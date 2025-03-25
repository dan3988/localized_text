import 'package:flutter/widgets.dart';

abstract class LocalizedText {
  static LocalizedText fallback(String? text, LocalizedText fallback) =>
      text == null ? fallback : _StaticLocalizedText(text);

  const LocalizedText();

  const factory LocalizedText.static(String text) = _StaticLocalizedText;

  String get(BuildContext context);
}

final class _StaticLocalizedText extends LocalizedText {
  final String text;

  const _StaticLocalizedText(this.text) : super();

  @override
  get(_) => text;
}

abstract class LocalizedTextGetter<T extends Object> extends LocalizedText {
  const LocalizedTextGetter() : super();
  const factory LocalizedTextGetter.getter(
      String Function(T localizations) getter) = _LocalizedTextGetter;

  @override
  get(context) {
    final localizations = Localizations.of(context, T);
    assert(localizations != null, 'No localizations in scope.');
    return getFor(localizations!);
  }

  @protected
  getFor(T localizations);
}

final class _LocalizedTextGetter<T extends Object>
    extends LocalizedTextGetter<T> {
  final String Function(T localizations) _getter;

  const _LocalizedTextGetter(this._getter);

  @override
  getFor(localizations) {
    return _getter(localizations);
  }
}
