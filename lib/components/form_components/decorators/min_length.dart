import 'package:chat_app_dart/components/form_components/decorators/data.dart';

class MinLength extends Data<int> {
  const MinLength(int value) : super(value);
  @override
  ValidationResult validate(inputValue) {
    bool valid = false;
    if (inputValue is int) {
      valid = inputValue >= value;
    } else {
      valid = (inputValue as String).length >= value;
    }
    return ValidationResult(valid,
        errorMessage: "Type in less than $value characters.");
  }
}
