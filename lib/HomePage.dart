import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M4 Application',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
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
      const PenjumlahanPage(),
      const PenguranganPage(),
      const GanjilGenapPage(),
      Calculator(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Kelompok'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Tambah'),
          BottomNavigationBarItem(icon: Icon(Icons.remove), label: 'Kurang'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline), label: 'Ganjil/Genap'),
          BottomNavigationBarItem(
              icon: Icon(Icons.remove), label: 'Ganjil/Genap'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple[800],
        unselectedItemColor: Colors.blueGrey[800],
        backgroundColor: Colors.deepPurple[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class DataKelompokPage extends StatelessWidget {
  const DataKelompokPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Anggota Kelompok:\n1. 123210100 - Yeheskiel Pambuko Aji\n2. 123210111 - Faza Denandra\n3. 123210164 - Muhammad Aditya Nugraha',
          style: TextStyle(fontSize: 18, height: 1.5),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class PenjumlahanPage extends StatefulWidget {
  const PenjumlahanPage({super.key});

  @override
  _PenjumlahanPageState createState() => _PenjumlahanPageState();
}

class _PenjumlahanPageState extends State<PenjumlahanPage> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  double _result = 0;

  void _calculateSum() {
    final String num1Text = _num1Controller.text;
    final String num2Text = _num2Controller.text;

    if (_isValidNumber(num1Text) && _isValidNumber(num2Text)) {
      final double num1 = double.parse(num1Text);
      final double num2 = double.parse(num2Text);
      setState(() {
        _result = num1 + num2;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Invalid input. Please enter valid numbers.')),
      );
    }
  }

  bool _isValidNumber(String input) {
    return double.tryParse(input) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _num1Controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Angka Pertama'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _num2Controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Angka Kedua'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateSum,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, // background
                minimumSize: const Size.fromHeight(50), // Set height
              ),
              child:
                  const Text('Hitung', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            Text('Hasil: $_result', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

class PenguranganPage extends StatefulWidget {
  const PenguranganPage({super.key});

  @override
  _PenguranganPageState createState() => _PenguranganPageState();
}

class _PenguranganPageState extends State<PenguranganPage> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  double _result = 0;

  void _calculateDifference() {
    final String num1Text = _num1Controller.text;
    final String num2Text = _num2Controller.text;

    if (_isValidNumber(num1Text) && _isValidNumber(num2Text)) {
      final double num1 = double.parse(num1Text);
      final double num2 = double.parse(num2Text);
      setState(() {
        _result = num1 - num2;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Invalid input. Please enter valid numbers.')),
      );
    }
  }

  bool _isValidNumber(String input) {
    return double.tryParse(input) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _num1Controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Angka Pertama'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _num2Controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Angka Kedua'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calculateDifference,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              minimumSize: Size.fromHeight(50), // Set height
            ),
            child: const Text('Kurangi', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
          Text('Hasil: $_result', style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

class GanjilGenapPage extends StatefulWidget {
  const GanjilGenapPage({super.key});

  @override
  _GanjilGenapPageState createState() => _GanjilGenapPageState();
}

class _GanjilGenapPageState extends State<GanjilGenapPage> {
  final TextEditingController _numController = TextEditingController();
  String _result = "";

  void _checkNumber() {
    final String numText = _numController.text;

    if (_isValidNumber(numText)) {
      final int num = int.parse(numText);
      setState(() {
        _result = (num % 2 == 0) ? "Genap" : "Ganjil";
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Invalid input. Please enter a valid number.')),
      );
    }
  }

  bool _isValidNumber(String input) {
    return int.tryParse(input) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _numController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Masukkan Angka'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkNumber,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: Size.fromHeight(50), // Set height
              ),
              child: const Text('Periksa', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            Text('Hasil: $_result', style: const TextStyle(fontSize: 20)),
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
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white),
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
    userInput = userInput + text;
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
      var exp = Parser().parse(userInput);
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
