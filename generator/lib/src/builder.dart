import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

import 'code.dart';
import 'settings.dart';

class LocalizedTextKeyGenerator extends Generator {
  final String className;
  final String classPath;
  final bool namedParameters;
  final Settings settings;

  LocalizedTextKeyGenerator({
    required this.className,
    required this.classPath,
    required this.namedParameters,
    required this.settings,
  });

  @override
  generate(library, buildStep) {
    final id = buildStep.inputId;
    if (id.path == classPath) {
      //final file = File(id.path);
      final type = library.findType(className);
      if (type == null) {
        log.warning('Could not find type "$className" in file "${id.path}"');
        return null;
      }

      final entries = <LocalizedEntry>[];

      for (final field in type.fields) {
        final getter = field.getter;
        if (getter != null && getter.isAbstract) {
          entries.add(SimpleLocalizedEntry(field.name, getter.documentationComment));
        }
      }

      for (final method in type.methods) {
        if (method.isAbstract) {
          final parameters = [
            for (final parameter in method.parameters)
              LocalizedTextParameter(parameter.name, refer('${parameter.type}')),
          ];

          entries.add(ComplexLocalizedEntry(method.name, method.documentationComment, parameters));
        }
      }

      if (entries.isNotEmpty) {
        final localizationsUri = AssetId(id.package, classPath).uri;
        final library = buildLibrary(
          settings: settings,
          localizationsClass: className,
          localizationsUri: localizationsUri.toString(),
          namedLocalizationParameters: namedParameters,
          entries: entries,
        );

        final emitter = DartEmitter.scoped();
        return library.accept(emitter).toString();
      }
    }

    return null;
  }
}
