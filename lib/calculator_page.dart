import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CalculatorPage extends HookWidget {
  const CalculatorPage({super.key});


  void incrementCalcText(String text, calcText)
  {
    calcText.value += text;
  }

  @override
  Widget build(BuildContext context)
  {
    final calcText = useState<String>("");

    List<String> textList =
    [
      "AC","( )","%" ,"÷",
      "7" , "8" ,"9" ,"×",
      "4" , "5" ,"6" ,"-",
      "1" , "2" ,"3" ,"+",
      "0" , "." ,"C" ,"=",
    ];

    List<Widget> buttonList = [];

    for (String text in textList)
    {
      buttonList.add(
        _calculatorButton(text, calcText)
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

                          child: Text(calcText.value),
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

  Widget _calculatorButton(String buttonText, calcText) {
    return ElevatedButton(
      onPressed: () {
        incrementCalcText(buttonText, calcText);
      },
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 35),
      ),
    );
  }

}
