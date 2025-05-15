import 'package:flutter/widgets.dart';

/// Getter for the translation of a [String] for the locale in a given [BuildContext].
abstract class LocalizedText {
  /// If the given [text] is null, it falls back to the provided [fallback] instance.
  static LocalizedText fallback(String? text, LocalizedText fallback) =>
      text == null ? fallback : _StaticLocalizedText(text);

  const LocalizedText();

  const factory LocalizedText.static(String text) = _StaticLocalizedText;
  const factory LocalizedText.joined(List<LocalizedText> parts,
      {LocalizedText? separator}) = JoinedLocalizedText;

  /// Retrieve the localized string for the given context
  String get(BuildContext context);
}

/// Concatenate multiple [LocalizedText] values together.
/// If [separator] is not null, it's localized value will be inserted between each element.
final class JoinedLocalizedText implements LocalizedText {
  final List<LocalizedText> parts;
  final LocalizedText? separator;

  const JoinedLocalizedText(this.parts, {this.separator});

  Iterable<String> _getSegments(BuildContext context) sync* {
    for (final part in parts) {
      yield part.get(context);
    }
  }

  @override
  get(context) {
    final sep = separator == null ? '' : separator!.get(context);
    return _getSegments(context).join(sep);
  }
}

final class _StaticLocalizedText extends LocalizedText {
  final String text;

  const _StaticLocalizedText(this.text) : super();

  @override
  get(_) => text;
}

/// Uses the instance of [T] in the given [BuildContext] to get a translated [String].
abstract class LocalizedTextGetter<T extends Object> extends LocalizedText {
  const LocalizedTextGetter() : super();
  const factory LocalizedTextGetter.getter(
      String Function(T localizations) getter) = _LocalizedTextGetter;

  @override
  get(context) {
    final localizations = Localizations.of<T>(context, T);
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
