import 'package:flutter/foundation.dart';

class ValidatorRule with ChangeNotifier {
  final String rule;
  final bool Function(String? input) validator;
  bool _valid = false;

  ValidatorRule({
    required this.rule,
    required this.validator,
  });

  bool get isValidated => _valid;

  void validate(bool valid) {
    _valid = valid;
    notifyListeners();
  }
}

extension ValidatorRules on List<ValidatorRule> {
  bool validate(String value) {
    bool valid = true;
    for (final rule in this) {
      final isRuleValid = rule.validator(value);
      rule.validate(isRuleValid);
      if (!isRuleValid && valid) {
        valid = false;
      }
    }
    return valid;
  }
}
