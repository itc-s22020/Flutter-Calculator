# Flutter-Calculator
<img src="https://img.shields.io/badge/Dart-v3.3.3-00A98F.svg?logo=Dart&style=social">  <img src="https://img.shields.io/badge/Flutter-v3.19.5-000000.svg?logo=Flutter&style=social">

flutterの学習用に作成したスマートフォン用のシンプルな電卓アプリ

# Note
<details open>
  <summary>ClassDiagram</summary>
  
```mermaid
classDiagram
    class MyApp {
        +build(BuildContext context)
    }

    class CalculatorPage {
        +build(BuildContext context)
    }

    class _CalculatorTextDisplay {
        -ValueNotifier<String> calcText
        -ValueNotifier<String> logText
        +build(BuildContext context)
    }

    class _CalculatorButtons {
        -ValueNotifier<String> calcText
        -ValueNotifier<String> logText
        +build(BuildContext context)
    }

    class CalculatorButton {
        -String buttonText
        -ValueNotifier<String> calcText
        -ValueNotifier<String> logText
        +build(BuildContext context)
    }

    class TextCalculator {
        +calculator(ValueNotifier<String> text)
        +bracketsText(ValueNotifier<String> text)
        +incrementText(String incrementText, ValueNotifier<String> text)
        +decrementText(ValueNotifier<String> text)
        +clearText(ValueNotifier<String> text)
        +saveLog(String saveText, ValueNotifier<String> text)
        +loadLog(ValueNotifier<String> saveText, ValueNotifier<String> text)
    }

    MyApp --> CalculatorPage
    CalculatorPage --> _CalculatorTextDisplay
    CalculatorPage --> _CalculatorButtons
    _CalculatorButtons --> CalculatorButton
    CalculatorButton --> TextCalculator
```
</details>


<details open>
  <summary>SequenceDiagram</summary>
  
```mermaid
sequenceDiagram
    participant User
    participant CalculatorButton
    participant TextCalculator

    User ->> CalculatorButton: onPressed("buttonText")
    CalculatorButton ->> TextCalculator: calculatorButtonSwitch(buttonText, calcText, logText)
    alt buttonText is a number or operator
        TextCalculator ->> calcText: incrementText(buttonText)
    else buttonText is "( )"
        TextCalculator ->> calcText: bracketsText(calcText)
    else buttonText is "C"
        TextCalculator ->> calcText: decrementText(calcText)
    else buttonText is "AC"
        TextCalculator ->> calcText: clearText(calcText)
        TextCalculator ->> logText: clearText(logText)
    else buttonText is "<"
        TextCalculator ->> calcText: loadLog(logText, calcText)
    else buttonText is "="
        TextCalculator ->> logText: saveLog(calcText.value, logText)
        TextCalculator ->> calcText: calculator(calcText)
    end
```
</details>


# external package
使用した外部パッケージ
- [auto_size_text](https://pub.dev/packages/auto_size_text/install) 文字サイズの自動調整
- [math_expressions](math_expressions) 文字列を計算式として扱う
- [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) 画面サイズをdp単位で調整
