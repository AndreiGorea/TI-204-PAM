import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Varsta Flutter',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'GoogleSans',
      ),
      home: MyHomePage(title: 'Calculator Varsta Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DateTime _value = new DateTime.now();

  DateTime _date = new DateTime.now();

  String calcDif = '';
  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1910),
        lastDate: new DateTime.now());
    if (picked != null) setState(() => _value = picked);
  }

  void _calcAge() {
    Duration diffDate = _date.difference(_value);
    setState(() {
      calcDif = (diffDate.inDays / 365).floor().toString();
      String days =
          (diffDate.inDays - ((diffDate.inDays / 365).floor()) * 365).toString();
      calcDif = calcDif + " Ani " + days + " Zile ";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Align(
              alignment: Alignment.center,
              child: Text(
                'Introduceti varsta dvs:',
                style: TextStyle(fontSize: 48),
              ),
            ),
            new Align(
              alignment: Alignment.center,
              child: Text(
                '$calcDif',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new ElevatedButton(
                onPressed: _selectDate,
                child: new Text(
                  "Selectati data",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new ElevatedButton(
                onPressed: _calcAge,
                // tooltip: 'Increment',
                child: new Text(
                  "Calculare",
                  style: TextStyle(fontSize: 34),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
