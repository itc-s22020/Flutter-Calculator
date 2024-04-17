import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.buttonText,
    required this.calcText,
    required this.logText,
    required this.onPressedFunction
  });

  final String buttonText;
  final ValueNotifier<String> calcText;
  final ValueNotifier<String> logText;
  final Function(String, ValueNotifier<String>,ValueNotifier<String>) onPressedFunction;

  void method() {
    onPressedFunction(buttonText,calcText,logText);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: method,
      child: AutoSizeText(
        buttonText,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 35,
        ),
      )
    );
  }
}