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
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blue.shade200,
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
    'AC',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'DEL',
    '0',
    'GANJIL/GENAP',
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
                          style:TextStyle(
                            fontSize: userInput.length > 20 ? 20 : 32,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          result.isEmpty ? (userInput.isEmpty ? "0" : calculate()) : result,
                          style: TextStyle(
                            fontSize:_calculateFontSize(result.length),
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

  double _calculateFontSize(int textLength) {
    if (textLength > 20) {
      return 50;
    } else if (textLength > 6) {
      return 70;
    } else {
      return 100;
    }
  }

  Widget customButton(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      splashColor: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: getColor(text),
              fontSize: getSizefont(text),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == "*" || text == "+" || text == "-") {
      return const Color.fromARGB(255, 237, 163, 2);
    }
    if (text == "AC") {
      return const Color.fromARGB(255, 237, 163, 2);
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if (text == "*" || text == "+" || text == "-") {
      return const Color.fromARGB(255, 0, 68, 255);
    }
    if (text == "DEL" || text == "=" || text == "GANJIL/GENAP") {
      return const Color.fromARGB(255, 61, 61, 61);
    }
    if (text == "AC") {
      return const Color.fromARGB(255, 255, 255, 255);
    }
    return const Color.fromARGB(255, 125, 125, 125);
  }

  getSizefont(String text){
    if(text == "GANJIL/GENAP"){
      return 18.0;
    }
    return 30.0;
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
      userInput = result;
      if(userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }

      if(result.endsWith(".0")) {
        result = result.replaceAll(".0", "");

      }
      return;
    }

    if (text == "GANJIL/GENAP") {
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