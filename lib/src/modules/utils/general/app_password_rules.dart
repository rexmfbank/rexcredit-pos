import 'package:flutter/material.dart';

List<PasswordRule2> validatePassword2(String password) {
  final requirements = [
    {
      'text': 'Contains a number',
      'check': (String pass) => pass.contains(RegExp(r'\d'))
    },
    {
      'text': 'Contains an uppercase letter',
      'check': (String pass) => pass.contains(RegExp(r'[A-Z]'))
    },
    {
      'text': 'Contains a lowercase letter',
      'check': (String pass) => pass.contains(RegExp(r'[a-z]'))
    },
    {
      'text': 'Contains a special character',
      'check': (String pass) => pass.contains(RegExp(r'[^A-Za-z0-9]'))
    },
    {
      'text': 'At least 8 characters',
      'check': (String pass) => pass.length >= 8
    },
  ];

  List<PasswordRule2> rules = [];
  bool unmetFound = false;

  for (var req in requirements) {
    bool isMet = (req['check'] as bool Function(String))(password);
    bool isNext = !isMet && !unmetFound;
    if (isNext) unmetFound = true;

    rules.add(PasswordRule2(
      text: req['text'] as String,
      isMet: isMet,
      isNext: isNext,
    ));
  }
  return rules;
}

class PasswordRule2 {
  final String text;
  final bool isMet;
  final bool isNext;

  PasswordRule2({
    required this.text,
    required this.isMet,
    required this.isNext,
  });

  Color get color => isMet ? Colors.green : (isNext ? Colors.red : Colors.grey);
}

class PasswordRuleItem2 extends StatelessWidget {
  final PasswordRule2 rule;
  const PasswordRuleItem2(this.rule, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Icon(Icons.circle, color: rule.color, size: 12),
          const SizedBox(width: 8),
          Text(rule.text, style: TextStyle(color: rule.color)),
        ],
      ),
    );
  }
}
