import 'package:flutter/widgets.dart';

import 'getter.dart';

/// Creates a [Text] widget showing the translation of [text] for the current context's language.
@immutable
class Localized extends StatelessWidget {
  /// The getter for the text to display
  final LocalizedText text;

  /// The value to be passed to [Text.style]
  final TextStyle? style;

  /// The value to be passed to [Text.strutStyle]
  final StrutStyle? strutStyle;

  /// The value to be passed to [Text.textAlign]
  final TextAlign? textAlign;

  /// The value to be passed to [Text.textDirection]
  final TextDirection? textDirection;

  /// The value to be passed to [Text.locale]
  final Locale? locale;

  /// The value to be passed to [Text.softWrap]
  final bool? softWrap;

  /// The value to be passed to [Text.overflow]
  final TextOverflow? overflow;

  /// The value to be passed to [Text.textScaler]
  final TextScaler? textScaler;

  /// The value to be passed to [Text.maxLines]
  final int? maxLines;

  /// The value to be passed to [Text.semanticsLabel]
  final String? semanticsLabel;

  /// The value to be passed to [Text.textWidthBasis]
  final TextWidthBasis? textWidthBasis;

  /// The value to be passed to [Text.textHeightBehavior]
  final TextHeightBehavior? textHeightBehavior;

  /// The value to be passed to [Text.selectionColor]
  final Color? selectionColor;

  const Localized({
    super.key,
    required this.text,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  @override
  build(context) {
    return Text(
      text.get(context),
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
