import 'package:flutter/material.dart';
import 'result_display.dart'; 

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _input = '';
  String _result = '';
  String _operator = '';
  int _firstOperand = 0;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == '=') {
        _calculateResult();
      } else if (value == 'C') {
        _clearInput();
      } else if (_isOperator(value)) {
        _firstOperand = int.tryParse(_input) ?? 0;
        _operator = value;
        _input = ''; 
      } else {
        _input += value; 
      }
    });
  }

  void _calculateResult() {
    int secondOperand = int.tryParse(_input) ?? 0; 

    if (_operator == '/' && secondOperand == 0) {
      _result = 'Error: Division by 0';
      return;
    }

    switch (_operator) {
      case '+':
        _result = (_firstOperand + secondOperand).toString();
        break;
      case '-':
        _result = (_firstOperand - secondOperand).toString();
        break;
      case '*':
        _result = (_firstOperand * secondOperand).toString();
        break;
      case '/':
        _result = (_firstOperand ~/ secondOperand).toString(); 
        break;
      default:
        _result = 'Invalid Operation';
    }
  }

  void _clearInput() {
    setState(() {
      _input = '';
      _result = '';
      _operator = '';
      _firstOperand = 0;
    });
  }

  bool _isOperator(String value) {
    return ['+', '-', '*', '/'].contains(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            alignment: Alignment.centerRight,
            color: Colors.grey[300], 
            child: Text(
              _input,
              style: TextStyle(fontSize: 32),
            ),
          ),
          ResultDisplay(result: _result), 
          Expanded(child: Divider()),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildButtons(['7', '8', '9', '/']),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildButtons(['4', '5', '6', '*']),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildButtons(['1', '2', '3', '-']),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildButtons(['C', '0', '=', '+']),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildButtons(List<String> labels) {
    return labels.map((label) {
      return InkWell(
        onTap: () => _onButtonPressed(label),
        child: Container(
          width: 70, 
          height: 70, 
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      );
    }).toList();
  }
}
