import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class TextCalculator {
  /// 計算式を計算結果に変更
  void calculator(ValueNotifier<String> text) {
    final calcText = text.value.replaceAll("÷", "/").replaceAll("×", "*");
    Parser p = Parser();
    clearText(text);
    try {
      Expression exp = p.parse(calcText);
      double calc = exp.evaluate(EvaluationType.REAL,ContextModel());
      RegExp reg = RegExp(r'\.0+$'); //正規表現で少数以下がない場合破棄
      incrementText(calc.toString().replaceAll(reg, ""), text);
    } catch(e) {
      incrementText("Error", text);
      return;
    }
  }

  ///　計算式が適切になるように括弧を追加
  void bracketsText(ValueNotifier<String> text) {
    final textValue = text.value;

    if (textValue.isEmpty || textValue.endsWith("(")) {
      incrementText("(", text);
    } else {
      //count関数が見つけきれなかったのでsplitのlengthから取得
      final leftBracketCount = textValue.split("(").length - 1;
      final rightBracketCount = textValue.split(")").length - 1;
      if(leftBracketCount > rightBracketCount) {
        incrementText(")", text);
      }else{
        incrementText("(", text);
      }
    }
  }

  ///計算式にtextを追加
  void incrementText(String incrementText, ValueNotifier<String> text) {
    if(text.value == "Error") {
      clearText(text);
    }
    text.value += incrementText;
  }

  ///計算式を一文字削除
  void decrementText(ValueNotifier<String> text) {
    final pos = text.value.length - 1;
    if (pos >= 0) {
      text.value = text.value.substring(0,pos);
    }
  }

  ///計算式をクリア
  void clearText(ValueNotifier<String> text) {
    text.value = "";
  }

  ///計算式をログに保存
  void saveLog(String saveText,ValueNotifier<String> text) {
    text.value = saveText;
  }

  ///現在の計算式をログに変更
  void loadLog(ValueNotifier<String> saveText, ValueNotifier<String> text) {
    text.value = saveText.value;
  }
}