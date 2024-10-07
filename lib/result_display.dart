import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final String result;

  const ResultDisplay({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      alignment: Alignment.centerRight,
      color: Colors.lightBlue[100], 
      child: Text(
        result,
        style: TextStyle(fontSize: 24, color: Colors.black), 
      ),
    );
  }
}
