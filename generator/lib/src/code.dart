import 'package:code_builder/code_builder.dart';

import 'settings.dart';

const self = 'package:localized_text_widget/localized_text_widget.dart';

sealed class LocalizedEntry {
  final String name;
  final String? doc;

  const LocalizedEntry(this.name, [this.doc]);

  void _buildClass(ClassBuilder rootClass, ClassBuilder implClass,
      String localizationName, bool preferNamed);

  Code _buildGetBody(bool namedLocalizationParameters);
}

final class SimpleLocalizedEntry extends LocalizedEntry {
  const SimpleLocalizedEntry(super.name, [super.doc]);

  @override
  _buildClass(rootClass, implClass, localizationName, preferNamed) {
    rootClass.fields.add(Field((b) {
      if (doc != null) {
        b.docs.add(doc!);
      }

      b.name = name;
      b.static = true;
      b.modifier = FieldModifier.constant;
      b.type = refer(rootClass.name!);
      b.assignment = Code('${implClass.name!}()');
    }));

    implClass.constructors.add(Constructor((b) => b.constant = true));
  }

  @override
  _buildGetBody(namedLocalizationParameters) => Code('return l.$name;');

  @override
  toString() => 'SimpleLocalizedEntry($name)';
}

final class LocalizedTextParameter {
  final String name;
  final Reference type;

  const LocalizedTextParameter(this.name, this.type);

  @override
  toString() => 'LocalizedTextParameter($type $name)';
}

final class ComplexLocalizedEntry extends LocalizedEntry {
  final List<LocalizedTextParameter> parameters;

  const ComplexLocalizedEntry(super.name, super.doc, this.parameters);

  @override
  _buildClass(rootClass, implClass, localizationName, preferNamed) {
    rootClass.constructors.add(Constructor((b) {
      if (doc != null) {
        b.docs.add(doc!);
      }

      b.name = name;
      b.constant = true;
      b.factory = true;
      b.redirect = refer(implClass.name!);
      b.addParameters(preferNamed, parameters, (b, parameter) {
        b.name = parameter.name;
        b.type = parameter.type;
      });
    }));

    implClass.fields.addAll([
      for (final LocalizedTextParameter(:name, :type) in parameters)
        Field((b) {
          b.name = name;
          b.type = type;
          b.modifier = FieldModifier.final$;
        })
    ]);

    implClass.constructors.add(Constructor((b) {
      b.constant = true;
      b.addParameters(preferNamed, parameters, (b, parameter) {
        b.name = parameter.name;
        b.toThis = true;
      });
    }));
  }

  @override
  _buildGetBody(namedLocalizationParameters) {
    final buffer = StringBuffer();
    buffer.write('return l.$name(');
    for (var i = 0; i < parameters.length;) {
      final LocalizedTextParameter(:name) = parameters[i];
      if (namedLocalizationParameters) {
        buffer
          ..write(name)
          ..write(':');
      }

      buffer.write(name);

      if (++i == parameters.length) {
        break;
      }

      buffer.write(',');
    }

    buffer.write(');');

    return Code('$buffer');
  }

  @override
  toString() =>
      'ComplexLocalizedEntry($name, ${parameters.map((v) => v.name).join(', ')})';
}

Library buildLibrary({
  required Settings settings,
  required String localizationsClass,
  required String localizationsUri,
  required bool namedLocalizationParameters,
  required List<LocalizedEntry> entries,
}) {
  return Library((library) {
    final localizationsRef = refer('l.$localizationsClass');
    library.ignoreForFile
        .addAll(['prefer_relative_imports', 'require_trailing_commas']);
    library.directives.addAll([
      Directive.import(self),
      Directive.import(localizationsUri, as: 'l'),
    ]);

    final override = refer('override');
    final preferNamed = settings.namedParameters ?? namedLocalizationParameters;
    final mainClassBuilder = ClassBuilder();
    final mainClassName = settings.outputClass ?? '${localizationsClass}Key';

    mainClassBuilder.name = mainClassName;
    mainClassBuilder.sealed = true;
    mainClassBuilder.constructors.add(Constructor((b) => b.constant = true));
    mainClassBuilder.extend = TypeReference((b) {
      b.symbol = 'LocalizedTextGetter';
      b.types.add(localizationsRef);
    });

    for (final (index, entry) in entries.indexed) {
      final className = '_C$index';
      final clazz = Class((b) {
        b.name = className;
        b.modifier = ClassModifier.final$;
        b.extend = refer(mainClassName);
        b.methods.addAll([
          Method((b) {
            b.name = 'getFor';
            b.annotations.add(override);
            b.body = entry._buildGetBody(namedLocalizationParameters);
            b.requiredParameters.add(Parameter((b) => b.name = 'l'));
          }),
          Method((b) {
            b.name = 'toString';
            b.annotations.add(override);
            b.body = Code('return \'$mainClassName("${entry.name}")\';');
          }),
        ]);

        entry._buildClass(mainClassBuilder, b, localizationsClass, preferNamed);
      });

      library.body.add(clazz);
    }

    library.body.insert(0, mainClassBuilder.build());
  });
}

extension on ConstructorBuilder {
  void addParameters<T>(bool named, Iterable<T> parameters,
      void Function(ParameterBuilder builder, T value) build) {
    if (named) {
      optionalParameters.addAll([
        for (final parameter in parameters)
          Parameter((b) {
            b.required = true;
            b.named = true;
            build(b, parameter);
          })
      ]);
    } else {
      requiredParameters.addAll([
        for (final parameter in parameters)
          Parameter((b) => build(b, parameter))
      ]);
    }
  }
}
