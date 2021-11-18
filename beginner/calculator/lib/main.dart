// ignore_for_file: prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Cal());
}

class Cal extends StatelessWidget {
  const Cal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.yellow),
      // ignore: prefer_const_constructors
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationfontsize = 38.0;
  double resultfontsize = 48.0;

  buttonpressed(String buttontext) {
    setState(() {
      if (buttontext == "C") {
        equation = "0";
        result = "0";
        equationfontsize = 38.0;
        resultfontsize = 48.0;
      } else if (buttontext == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        equationfontsize = 38.0;
        resultfontsize = 48.0;
        if (equation == "") {
          equation == "0";
        }
      } else if (buttontext == "=") {
        equationfontsize = 38.0;
        resultfontsize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttontext;
        } else {
          equation = equation + buttontext;
        }
      }
    });
  }

  buildbutton(String buttontext, double buttonheight, Color buttoncolor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonheight,
      color: buttoncolor,
      // ignore: deprecated_member_use
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            // ignore: prefer_const_constructors
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        onPressed: () => buttonpressed(buttontext),
        // ignore: prefer_const_constructors
        child: Text(
          buttontext,
          // ignore: prefer_const_constructors
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(fontSize: equationfontsize),
              )),
          Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultfontsize),
              )),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    TableRow(children: [
                      buildbutton('C', 1, Colors.redAccent),
                      buildbutton('⌫', 1, Colors.yellow),
                      buildbutton('÷', 1, Colors.yellow),
                    ]),
                    TableRow(children: [
                      buildbutton('1', 1, Colors.black54),
                      buildbutton('2', 1, Colors.black54),
                      buildbutton('3', 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildbutton('4', 1, Colors.black54),
                      buildbutton('5', 1, Colors.black54),
                      buildbutton('6', 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildbutton('7', 1, Colors.black54),
                      buildbutton('8', 1, Colors.black54),
                      buildbutton('9', 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildbutton('.', 1, Colors.black54),
                      buildbutton('0', 1, Colors.black54),
                      buildbutton('00', 1, Colors.black54),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildbutton('×', 1, Colors.yellow),
                    ]),
                    TableRow(children: [
                      buildbutton('-', 1, Colors.yellow),
                    ]),
                    TableRow(children: [
                      buildbutton('+', 1, Colors.yellow),
                    ]),
                    TableRow(children: [
                      buildbutton('=', 2, Colors.redAccent),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
