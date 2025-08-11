import 'package:flutter/widgets.dart';

import '../localized_text_widget.dart';

@Deprecated('Use `Message` instead.')
abstract class LocalizedText implements Message {
  /// If the given [text] is null, it falls back to the provided [fallback] instance.
  factory LocalizedText.fallback(String? text, LocalizedText fallback) =>
      text == null ? fallback : StaticMessage(text);

  const LocalizedText();

  const factory LocalizedText.static(String text) = StaticMessage;

  const factory LocalizedText.joined(
    List<Message> parts, {
    Message? separator,
  }) = JoinedMessage;

  @override
  resolve(context) => get(context);

  String get(BuildContext context);
}
