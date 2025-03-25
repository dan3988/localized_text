library;

import 'dart:io';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yaml/yaml.dart';

import 'src/builder.dart';
import 'src/settings.dart';

Generator _createGenerator(BuilderOptions options) {
  final file = File('l10n.yaml');
  if (!file.existsSync()) {
    log.warning('localized_text_key_generator: l10n.yaml does not exist.');
    return const _EmptyGenerator();
  }

  final text = file.readAsStringSync();
  final YamlMap value = loadYaml(text);
  if (value['synthetic-package'] != false) {
    log.warning('localized_text_key_generator: l10n.yaml must have "synthetic-package: false".');
    return const _EmptyGenerator();
  }

  final String directory = value['output-dir'] ?? value['arb-dir'];
  //final String templateName = value['template-arb-file'] ?? 'app_en.arb';
  final String outputFile = value['output-localization-file'] ?? 'app_localizations.dart';
  final bool? noNamedParameters = value['no-use-named-parameters'];
  final bool namedParameters = noNamedParameters != null ? !noNamedParameters : value['use-named-parameters'] ?? false;
  final className = value['output-class'] ?? 'AppLocalizations';
  return LocalizedTextKeyGenerator(
    //templatePath: '$directory/$templateName',
    classPath: '$directory/$outputFile',
    className: className,
    namedParameters: namedParameters,
    settings: Settings.fromJson(options.config),
  );
}

Builder localizedWidgetGenerator(BuilderOptions options) {
  final generator = _createGenerator(options);
  return LibraryBuilder(generator, generatedExtension: '.keys.dart');
}

class _EmptyGenerator extends Generator {
  const _EmptyGenerator();
}
