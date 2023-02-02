import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';

class ValidatorRuleCheck extends StatelessWidget {
  final ValidatorRule rule;

  const ValidatorRuleCheck({
    super.key,
    required this.rule,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rule,
      builder: (_, __) {
        final valdiated = rule.isValidated;
        final color = valdiated ? AppColors.positive : AppColors.gray;
        return SizedBox(
          height: 24,
          child: Row(
            children: [
              valdiated
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: color,
                    )
                  : Icon(
                      Icons.circle,
                      size: 16,
                      color: color.withOpacity(0.3),
                    ),
              const SizedBox(
                width: 8,
              ),
              XText.bodySmall(rule.rule).customWith(context, color: color),
            ],
          ),
        );
      },
    );
  }
}
