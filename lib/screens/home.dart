import 'package:calculator/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // List of all button texts
  final List<String> buttonTexts = [
    'A/C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '='
  ];

  // Method to set the color of the operator buttons to be different than the other buttons
  bool isOperator(String str)
  {
    bool res = false;
    if (str  == '%' || str == '/' || str  == 'x' || str == '-' || str  == '+' || str == '=')  res = true;
    return res;
  }

  String equalPressed(String userQuestion)
  {
    if (userQuestion.isEmpty) return "";
    // We need to replace the 'x' with '*' because the parse looks for '*' not 'x'
    userQuestion = userQuestion.replaceAll("x", "*");
    // You can either create an mathematical expression programmatically or parse
    // a string.
    // (1a) Parse expression:
    Parser p = Parser();
    Expression exp = p.parse(userQuestion);

    // (3) Evaluate expression:
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return "$eval";
  }
  String userExpresion = "";
  String answer = "";
  String ansButton = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[300],
          title: const Opacity(opacity: 0.2,
          child: Text("Calculator", style: TextStyle(color: Colors.black, fontSize: 25),)),

        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.all(30),
                      alignment: Alignment.centerLeft,
                        child: Text(userExpresion, style: const TextStyle(fontSize: 30),)),
                    Container(
                        padding: const EdgeInsets.all(30),
                      alignment: Alignment.centerRight,
                        child: Text(answer, style: const TextStyle(fontSize: 50))
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                      color: Colors.grey[300],
                      child: GridView.builder(
                          itemCount: buttonTexts.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                          itemBuilder: (BuildContext context, int index) {

                            // Changing the button and text colors for the clear button
                            if (index == 0) {
                              return Button(
                                buttonText: buttonTexts[index],
                                buttonColor: Colors.green,
                                textColor: Colors.green,
                                performAction: () {
                                  setState(() {
                                     userExpresion = "";
                                     answer = "";
                                  });
                                },
                            );

                              // Changing the button and text colors for the delete button
                            } else if (index == 1) {
                              return Button(
                            buttonText: buttonTexts[index],
                            buttonColor: Colors.red,
                            textColor: Colors.green,
                                performAction: () {
                                  setState(() {
                                    userExpresion = userExpresion.isNotEmpty ?userExpresion.substring(0, userExpresion.length - 1): "";
                                  });
                                },
                            );

                              // If it's an equals button
                            } else if (index == 19) {
                              return Button(
                                buttonText: buttonTexts[index],
                                buttonColor: Colors.purple,
                                textColor: Colors.green,
                                performAction: (){
                                  setState(() {
                                    answer = equalPressed(userExpresion);
                                  });
                                }

                              );
                            }

                            else {
                              // These are the rest of the buttons
                              return Button(
                                buttonText: buttonTexts[index],
                                buttonColor: isOperator(buttonTexts[index]) ? Colors.green: Colors.black,
                                textColor: isOperator(buttonTexts[index]) ? Colors.green: Colors.black,
                                performAction: (){
                                  setState(() {
                                    userExpresion += buttonTexts[index];
                                  });
                                },
                            );
                            }
                          }
                          )
                  )
              ),
            ],
          ),
        ));
  }
}
