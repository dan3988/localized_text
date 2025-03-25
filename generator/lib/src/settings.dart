class Settings {
  final String? outputClass;
  final bool? namedParameters;

  Settings.fromJson(Map<String, dynamic> values)
      : this(
          outputClass: values['output_class'],
          namedParameters: values['named_parameters'],
        );

  const Settings({
    this.outputClass,
    this.namedParameters,
  });
}
