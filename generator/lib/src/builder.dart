import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

import 'code.dart';

class LocalizedTextKeyGenerator extends Generator {
  final String className;
  final String classPath;
  final bool namedParameters;

  LocalizedTextKeyGenerator({
    required this.className,
    required this.classPath,
    required this.namedParameters,
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

          entries.add(ComplexLocalizedEntry(method.name, method.documentationComment, parameters, namedParameters));
        }
      }

      if (entries.isNotEmpty) {
        final library = buildLibrary(className, AssetId(id.package, classPath).uri, entries);
        //final outputId = id.changeExtension('.g.dart');
        final emitter = DartEmitter.scoped();
        return library.accept(emitter).toString();
        // final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
        // final unformatted = library.accept(emitter).toString();
        // final text = formatter.format(unformatted, uri: outputId.uri);
      }
    }

    return null;
  }
}
