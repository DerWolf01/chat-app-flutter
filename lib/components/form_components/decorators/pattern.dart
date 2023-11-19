import 'package:chat_app_dart/components/form_components/decorators/data.dart';

class Pattern extends Data<String> {
  const Pattern(String regExp, this.errorMessage) : super(regExp);

  final String errorMessage;
  @override
  ValidationResult validate(inputValue) {
    RegExp regExp = RegExp(value);
    return ValidationResult(
        regExp.hasMatch(
          value,
        ),
        errorMessage: errorMessage);
  }
}
