enum FieldType {
  text,
  number,
  dropdown,
  multiSelect,
  textarea,
  fileUpload,
}

class PartnerFieldConfig {
  final String key;
  final String label;
  final FieldType type;
  final List<String>? options;
  final bool required;

  const PartnerFieldConfig({
    required this.key,
    required this.label,
    required this.type,
    this.options,
    this.required = true,
  });
}
