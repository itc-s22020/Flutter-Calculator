import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/component/text_calculator.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(
      {super.key,
      required this.buttonText,
      required this.calcText,
      required this.logText,
      });

  final String buttonText;
  final ValueNotifier<String> calcText;
  final ValueNotifier<String> logText;

  @override
  Widget build(BuildContext context) {

    TextCalculator textCalculator = TextCalculator();

    void calculatorButtonSwitch(String buttonText, ValueNotifier<String> text, ValueNotifier<String> logText) {
      switch(buttonText) {
        case "0"||"1"||"2"||"3"||"4"||"5"||"6"||"7"||"8"||"9":
        case "+"||"-"||"×"||"÷"||".":
          textCalculator.incrementText(buttonText, text);
          break;
        case "( )":
          textCalculator.bracketsText(text);
          break;
        case "C":
          textCalculator.decrementText(text);
          break;
        case "AC":
          textCalculator.clearText(text);
          textCalculator.clearText(logText);
          break;
        case "<":
          textCalculator.loadLog(logText, text);
          break;
        case "=":
          textCalculator.saveLog(text.value, logText);
          textCalculator.calculator(text);
          break;
        case _:
          break;
      }
    }

    void method() {
      calculatorButtonSwitch(buttonText, calcText, logText);
    }

    return ElevatedButton(
        onPressed: method,
        child: AutoSizeText(
          buttonText,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 35,
          ),
        ));
  }
}
