library;

import 'dart:io';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yaml/yaml.dart';

import 'src/builder.dart';

Builder localizedWidgetGenerator(BuilderOptions options) {
  final Generator generator;
  final file = File('l10n.yaml');
  if (!file.existsSync()) {
    log.warning('File "l10n.yaml" not found.');
    generator = const _EmptyGenerator();
  } else {
    final text = file.readAsStringSync();
    final value = loadYaml(text);
    final String directory = value['output-dir'] ?? value['arb-dir'];
    //final String templateName = value['template-arb-file'] ?? 'app_en.arb';
    final String outputFile = value['output-localization-file'] ?? 'app_localizations.dart';
    final bool? noNamedParameters = value['no-use-named-parameters'];
    final bool namedParameters = noNamedParameters != null ? !noNamedParameters : value['use-named-parameters'] ?? false;
    final className = value['output-class'] ?? 'AppLocalizations';
    generator = LocalizedTextKeyGenerator(
      //templatePath: '$directory/$templateName',
      classPath: '$directory/$outputFile',
      className: className,
      namedParameters: namedParameters,
    );
  }

  return LibraryBuilder(generator, generatedExtension: '.keys.dart');
}

class _EmptyGenerator extends Generator {
  const _EmptyGenerator();
}
