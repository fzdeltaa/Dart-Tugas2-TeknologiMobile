import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M4 Application',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('localId');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const DataKelompokPage(),
      const Calculator(),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
    bottomNavigationBar: ClipRRect(
    borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(40.0),
    topRight: Radius.circular(40.0),
    ),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'KELOMPOK'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: 'KALKULATOR'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade200,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blue.shade900,
        onTap: _onItemTapped,
      ),
    ),
    );
  }
}

class DataKelompokPage extends StatelessWidget {
  const DataKelompokPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 150),
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: const Text(
                "Tugas Pemrograman Mobile",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 100),
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
            child: const Text(
              'Anggota Kelompok:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            ),
            const SizedBox(height: 10),
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
            child: const Text(
                  '1. 123210100 - Yeheskiel Pambuko Aji\n'
                  '2. 123210111 - Faza Denandra\n'
                  '3. 123210164 - Muhammad Aditya Nugraha',
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    '7',
    '8',
    '9',
    'DEL',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'AC',
    '0',
    'Even/Odd',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          userInput.isEmpty ? "" : userInput,
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          result.isEmpty ? (userInput.isEmpty ? "0" : calculate()) : result,
                          style: const TextStyle(
                            fontSize: 100,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return customButton(buttonList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton(String text) {
    return InkWell(
      splashColor: const Color(0xFF1d2630),
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 0.5,
                offset: const Offset(-3, -3),
              )
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == "*" || text == "+" || text == "-") {
      return const Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if (text == "AC" || text == "=" || text == "DEL") {
      return const Color.fromARGB(255, 252, 100, 100);
    }
    return const Color(0xFF1d2630);
  }

  handleButtons(String text) {
    List<String> operators = ['+', '-', '*', '/'];
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }

    if (text == "DEL") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == "=") {
      result = calculate();
      userInput = "";
      if(userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }

      if(result.endsWith(".0")) {
        result = result.replaceAll(".0", "");

      }
      return;
    }

    if (text == "Even/Odd") {
      result = isEven();
      userInput = "";
      if(userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }

      if(result.endsWith(".0")) {
        result = result.replaceAll(".0", "");

      }
      return;
    }

    if ((text == "+" || text == "-") && !result.isEmpty) {
      if(userInput.isEmpty) {
        userInput = result + text;
        result = "";
        return;
      }
    }

    if (userInput.isNotEmpty && operators.contains(text) && operators.contains(userInput[userInput.length - 1])) {
      userInput = userInput.substring(0, userInput.length - 1) + text;
      return;
    }
    userInput += text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch(e) {
      return "Error";
    }
  }

  String isEven() {
    try {
      var exp = Parser().parse(result);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      if (evaluation % 2 == 0) {
        return "Genap";
      } else {
        return "Ganjil";
      }
    } catch(e) {
      return "Error";
    }
  }
}