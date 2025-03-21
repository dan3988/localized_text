library;

import 'dart:io';

import 'package:build/build.dart';
import 'package:yaml/yaml.dart';

import 'src/builder.dart';

Builder localizedWidgetGenerator(BuilderOptions options) {
  final file = File('l10n.yaml');
  if (file.existsSync()) {
    final text = file.readAsStringSync();
    final value = loadYaml(text);
    final String directory = value['output-dir'] ?? value['arb-dir'];
    final String templateName = value['template-arb-file'] ?? 'app_en.arb';
    final String outputFile = value['output-localization-file'] ?? 'app_localizations.dart';
    final className = value['output-class'] ?? 'AppLocalizations';
    return LocalizedWidgetBuilder(
      templatePath: '$directory/$templateName',
      classPath: '$directory/$outputFile',
      className: className,
    );
  }

  throw ArgumentError('File "l10n.yaml" not found.');
}
