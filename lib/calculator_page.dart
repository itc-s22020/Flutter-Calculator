import 'package:calculator/widget/calculator_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CalculatorPage extends HookWidget {
  const CalculatorPage({super.key});

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
        CalculatorButton(
            buttonText: text,
            calcText: calcText,
            logText: logText
          )
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
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                alignment: Alignment.bottomRight,
                                child: AutoSizeText(
                                  logText.value,
                                  style: const TextStyle(
                                    fontSize: 30,
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
                        _CalculatorButtons(buttonList: buttonList)
                      ]
                  )
              ),
            )
        )
    );
  }
}


class _CalculatorButtons extends HookWidget {
  const _CalculatorButtons({
    required this.buttonList
  });
  final List<Widget> buttonList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}