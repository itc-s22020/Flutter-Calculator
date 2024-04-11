import 'package:calculator/main.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context){
            //   return const MainPage();
            // }));
          },
          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 200)),
          child: const Text("戻る"),
        ),
      ),
    );
  }
}
