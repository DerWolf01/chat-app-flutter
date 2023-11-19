abstract class Data<ValueType> {
  const Data(
      // {this.minLength, this.maxLength, this.regexp, this.required}
      this.value);
  final ValueType value;
  ValidationResult validate(dynamic inputValue);
  // final int? minLength;
  // final int? maxLength;
  // final String? regexp;
  // final bool? required;

  // RegExp? get getRegExp => regexp != null ? RegExp(regexp!) : null;
  // bool hasMinlength(String value) => value.length >= (minLength ?? 0);
  // bool hasMaxlength(String value) => value.length >= (maxLength ?? 0);
  // bool get isRequired => required ?? false;

  // bool matchesPattern(String value) {
  //   return getRegExp?.hasMatch(value) ?? true;
  // }

  // List<ValidationResult> validate(String value) {
  //   return [

  //   ];
  // }
}

class ValidationResult {
  ValidationResult(this.valid, {required this.errorMessage});
  bool valid;
  String errorMessage;
}
