import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

import 'code.dart';

class LocalizedWidgetBuilder extends Builder {
  final String className;
  final String classPath;
  final String templatePath;

  @override
  get buildExtensions => const { '.arb': ['.g.dart'] };

  LocalizedWidgetBuilder({
    required this.className,
    required this.classPath,
    required this.templatePath,
  });

  @override
  build(buildStep) async {
    final id = buildStep.inputId;
    if (id.path == templatePath) {
      final file = File(id.path);
      final Map<String, dynamic> json = await file.readAsString().then((v) => jsonDecode(v));
      final names = json.keys.where((v) => !v.startsWith('@')).toList();
      if (names.isNotEmpty) {
        final library = buildLibrary(className, AssetId(id.package, classPath).uri, names);
        final outputId = id.changeExtension('.g.dart');
        final emitter = DartEmitter.scoped();
        final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
        final unformatted = library.accept(emitter).toString();
        final text = formatter.format(unformatted);
        //final text = formatter.format(source)
        await buildStep.writeAsString(outputId, text);
      }
    }
  }
}

//
// class LocalizedWidgetGenerator extends Generator {
//   final String className;
//   final String filePath;
//
//   const LocalizedWidgetGenerator({
//     required this.className,
//     required this.filePath,
//   });
//
//   @override
//   generate(library, buildStep) async {
//     final source = library.element.source;
//     final path = _getFilePath(source.uri);
//     if (path != filePath) {
//       return null;
//     }
//
//     final type = library.findType(className);
//     final reference = refer(className, 'package:${buildStep.inputId.package}/${buildStep.inputId.path}');
//     final library = buildLibrary();
//
//     return super.generate(library, buildStep);
//   }
// }

String? _getFilePath(Uri uri) {
  final Uri(:scheme, :path) = uri;
  if (scheme != 'package') {
    return null;
  }

  final i = path.indexOf('/');
  return 'lib${path.substring(i)}';
}