import 'package:flutter/material.dart';
import 'package:auto_suggestion_text_field/model/text_field_prop.dart';
import 'package:auto_suggestion_text_field/suggestion_text_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Suggest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Auto Suggest TextField'),
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
  final _dummySuggestionNames = [
    "Shantae Zook",
    "Sandie Curtis",
    "Kary Janssen",
    "Millard Murray",
    "Rocio Golightly",
    "Cesar Davi",
    "Trinh Eurich",
    "Bethel Roney",
    "Harland Bridgewater",
    "Camie Behr",
    "Cleo Bruck",
    "Alexandra Burgoyne",
    "Debora Crossett",
    "Latina Drye",
    "Palma Guillen",
    "Trenton Burgo",
    "Frankie Sifford",
    "Charley Carboni",
    "Dannielle Pietila",
    "Jenni Hardrick"
  ];

  @override
  Widget build(BuildContext context) {
    final props = TextFieldProperties(
      data: _dummySuggestionNames,
      hint: "Jesse",
      fieldHeight: 90,
      error: "No matching name available",
      onValueSelect: (value) => onSuggestionSelected(value),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SuggestionTextField(props: props),
      ),
    );
  }

  onSuggestionSelected(String value) => print("Value selected is: $value");
}
