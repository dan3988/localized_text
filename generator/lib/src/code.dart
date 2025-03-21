import 'package:code_builder/code_builder.dart';

const self = 'package:localized_text_widget/localized_text_widget.dart';

Library buildLibrary(String localizationsType, Uri localizationsUrl, List<String> names) {
  return Library((library) {
    final localizationsRef = refer('l.$localizationsType');
    library.directives.addAll([
      Directive.import(self),
      Directive.import('$localizationsUrl', as: 'l'),
    ]);

    final enumBuilder = EnumBuilder();

    enumBuilder.name = '${localizationsType}Key';
    enumBuilder.implements.add(refer('LocalizedText'));
    enumBuilder.fields.add(
      Field((b) {
        b.name = '_getter';
        b.modifier = FieldModifier.final$;
        b.type = TypeReference((b) {
          b.symbol = 'LocalizationGetter';
          b.types.add(localizationsRef);
        });
        // b.type = FunctionType((b) {
        //   b.returnType = refer('String');
        //   b.requiredParameters.add(localizationsType);
        // });
      })
    );

    enumBuilder.constructors.add(
      Constructor((b) {
        b.constant = true;
        b.requiredParameters.add(
          Parameter((b) {
            b.name = '_getter';
            b.toThis = true;
          })
        );
      })
    );

    enumBuilder.methods.add(
      Method((b) {
        b.name = 'get';
        b.annotations.add(
          refer('override')
        );

        b.requiredParameters.add(
          Parameter((b) {
            b.name = 'context';
          })
        );

        b.body = Code.scope((allocate) {
          final ref = refer('LocalizedText');
          return 'return ${allocate(ref)}.invoke(context, _getter);';
        });
      })
    );

    for (final (index, name) in names.indexed) {
      final methodName = '_g$index';
      final method = Method((b) {
        b.name = methodName;
        b.returns = refer('String');
        b.body = Code('return l.$name;');
        b.requiredParameters.add(
          Parameter((b) {
            b.name = 'l';
            b.type = localizationsRef;
          })
        );

      });

      final value = EnumValue((b) {
        b.name = name;
        b.arguments.add(Reference(methodName));
        b.docs.add('/// Key for [l.AppLocalizations.$name]');
      });

      library.body.add(method);
      enumBuilder.values.add(value);
    }

    library.body.insert(0, enumBuilder.build());
  });
}
