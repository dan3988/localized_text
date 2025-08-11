import 'package:flutter/widgets.dart';
import 'package:localized_text_widget/src/legacy.dart';

mixin _LegacyMessageMixin on Message implements LocalizedText {
  @override
  @Deprecated('Use `resolve` instead.')
  get(context) => resolve(context);
}

/// Getter for the translation of a [String] for the locale in a given [BuildContext].
abstract class Message {
  /// Return the resolved text if [obj] is a [Message] instance, otherwise the result of [toString] is returned.
  static String getString(BuildContext context, Object obj) =>
      obj is Message ? obj.resolve(context) : obj.toString();

  /// If the given [text] is null, it falls back to the provided [fallback] instance.
  factory Message.fallback(String? text, Message fallback) =>
      text == null ? fallback : StaticMessage(text);

  const Message();

  /// Returns the value of [text] regardless of the current locale.
  const factory Message.static(String text) = StaticMessage;

  /// Concatenate the text of multiple [Message] instances together.
  /// If [separator] is not null, it's localized value will be inserted between each element.
  const factory Message.joined(
    List<Message> parts, {
    Message? separator,
  }) = JoinedMessage;

  /// Retrieve the localized string for the given context
  String resolve(BuildContext context);
}

/// Concatenate the text of multiple [Message] instances together.
/// If [separator] is not null, it's localized value will be inserted between each element.
final class JoinedMessage extends Message with _LegacyMessageMixin {
  final List<Message> parts;
  final Message? separator;

  const JoinedMessage(this.parts, {this.separator});

  Iterable<String> _getSegments(BuildContext context) sync* {
    for (final part in parts) {
      yield part.resolve(context);
    }
  }

  @override
  get(context) => resolve(context);

  @override
  resolve(context) {
    final sep = separator == null ? '' : separator!.resolve(context);
    return _getSegments(context).join(sep);
  }
}

/// Returns the value of [text] regardless of the current context's locale.
final class StaticMessage extends Message with _LegacyMessageMixin {
  final String text;

  const StaticMessage(this.text) : super();

  @override
  resolve(_) => text;
}

/// Uses the instance of [T] in the given [BuildContext] to get a translated [String].
abstract class LocalizationMessage<T extends Object> extends Message
    with _LegacyMessageMixin {
  const LocalizationMessage() : super();

  const factory LocalizationMessage.getter(
      String Function(T localizations) getter) = _LocalizationMessage;

  @override
  resolve(context) {
    final localizations = Localizations.of<T>(context, T);
    assert(localizations != null, 'No localizations in scope.');
    return getText(context, localizations!);
  }

  @protected
  String getText(BuildContext context, T localizations);
}

final class _LocalizationMessage<T extends Object>
    extends LocalizationMessage<T> {
  final String Function(T localizations) _getter;

  const _LocalizationMessage(this._getter);

  @override
  getText(_, localizations) {
    return _getter(localizations);
  }
}
