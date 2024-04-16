import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends HookWidget {
  const CalculatorPage({super.key});

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

  void incrementText(String incrementText, ValueNotifier<String> text) {
    if(text.value == "Error") {
      clearText(text);
    }
    text.value += incrementText;
  }

  void decrementText(ValueNotifier<String> text) {
    final pos = text.value.length - 1;
    if (pos >= 0) {
      text.value = text.value.substring(0,pos);
    }
  }

  void bracketsText(ValueNotifier<String> text) {
    final textValue = text.value;
    final length = textValue.length;
    final leftBracketIndex = textValue.lastIndexOf("(");
    final rightBracketIndex = textValue.lastIndexOf(")");
    final leftBracketCount = length - textValue.replaceAll("(", "").length;
    final rightBracketCount = length - textValue.replaceAll(")", "").length;

    if (textValue.isEmpty || leftBracketCount == 0) {
      incrementText("(", text);
    } else if(length-1==leftBracketIndex) {
      incrementText("(", text);
    } else if(leftBracketCount > rightBracketCount) {
      incrementText(")", text);
    } else if(leftBracketIndex < rightBracketIndex){
      incrementText("(", text);
    } else{
      incrementText(")", text);
    }
  }


  void clearText(ValueNotifier<String> text) {
    text.value = "";
  }

  void saveLog(String saveText,ValueNotifier<String> text) {
    text.value = saveText;
  }

  void loadLog(ValueNotifier<String> saveText, ValueNotifier<String> text) {
    text.value = saveText.value;
  }

  void calculatorButtonSwitch(String buttonText, ValueNotifier<String> text, ValueNotifier<String> logText) {
    switch(buttonText) {
      case "0":
      case "1":
      case "2":
      case "3":
      case "4":
      case "5":
      case "6":
      case "7":
      case "8":
      case "9":
      case "+":
      case "-":
      case "×":
      case "÷":
      case ".":
        incrementText(buttonText, text);
        break;
      case "( )":
        bracketsText(text);
        break;
      case "C":
        decrementText(text);
        break;
      case "AC":
        clearText(text);
        break;
      case "<":
        loadLog(logText, text);
        break;
      case "=":
        saveLog(text.value, logText);
        calculator(text);
      case _:
        calculator(text);
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final calcText = useState<String>("");
    final logText = useState<String>("");

    final List<String> textList =
    [
      "AC","( )","<" ,"÷",
      "7" , "8" ,"9" ,"×",
      "4" , "5" ,"6" ,"-",
      "1" , "2" ,"3" ,"+",
      "0" , "." ,"C" ,"=",
    ];

    List<Widget> buttonList = [];

    for (String text in textList)
    {
      buttonList.add(
        _calculatorButton(text, calcText, logText)
      );
    }

    return MaterialApp(
        home: Scaffold(
            body: ScreenUtilInit(
              designSize: const Size(300, 600),
              builder: (_, child) => Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: 200.w,
                          height: 210.h,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 2,bottom: 2),
                                alignment: Alignment.bottomRight,
                                child: AutoSizeText(
                                  logText.value,
                                  style: const TextStyle(
                                    fontSize: 60,
                                    color: Colors.grey
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.only(bottom: 0.h,left: 5.h,right: 5.h,top: 0),
                                child: AutoSizeText(
                                  calcText.value,
                                  style: const TextStyle(
                                      fontSize: 90,
                                  ),
                                  maxLines: 1,
                                ),
                              )
                            ],
                          )
                        ),
                        Expanded(
                            child:Container(
                              alignment: Alignment.center,
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(), //スクロール無効
                                itemCount: buttonList.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                ),
                                padding: const EdgeInsets.all(8),
                                itemBuilder: (BuildContext context, int index) {
                                  return buttonList[index];
                                  },
                              ),
                            )
                        )

                      ]
                  )
              ),
            )
        )
    );
  }

  Widget _calculatorButton(String buttonText, ValueNotifier<String> calcText, ValueNotifier<String> logText) {
    return ElevatedButton(
      onPressed: () {
        calculatorButtonSwitch(buttonText, calcText, logText);
      },
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 35),
      ),
    );
  }

}
