import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
class NumberPickerDemo extends StatefulWidget {
  @override
  _NumberPickerDemoState createState() => _NumberPickerDemoState();
}

class _NumberPickerDemoState extends State<NumberPickerDemo> {
  int _currentIntValue = 10;
  double _currentDoubleValue = 3.0;
  late NumberPicker integerNumberPicker;
  late NumberPicker decimalNumberPicker;

  _handleValueChanged(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue = value);
      } else {
        setState(() => _currentDoubleValue = value);
      }
    }
  }

  _handleValueChangedExternally(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue = value);
        integerNumberPicker.animateInt(value);
      } else {
        setState(() => _currentDoubleValue = value);
        decimalNumberPicker.animateDecimalAndInteger(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    integerNumberPicker = new NumberPicker.integer(
      initialValue: _currentIntValue,
      minValue: 0,
      maxValue: 100,
      step: 10,
      onChanged: _handleValueChanged,
    );
    //build number picker for decimal values
    decimalNumberPicker = new NumberPicker.decimal(
        initialValue: _currentDoubleValue,
        minValue: 1,
        maxValue: 5,
        decimalPlaces: 2,
        onChanged: _handleValueChanged);
    //scaffold the full homepage
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Number Picker Demo'),
          centerTitle:true,
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              integerNumberPicker,
              RaisedButton(
                onPressed: () => _showIntegerDialog(),
                child: new Text("Int Value: $_currentIntValue"),
                color: Colors.grey[300],
              ),
              decimalNumberPicker,
              RaisedButton(
                onPressed: () => _showDoubleDialog(),
                child: new Text("Decimal Value: $_currentDoubleValue"),
                color: Colors.pink[100],

              ),
            ],
          ),
        ));
  }
  Future _showIntegerDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 100,
          step: 10,
          initialIntegerValue: _currentIntValue,
          title: new Text("Pick a int value"),
        );
      },
    ).then(_handleValueChangedExternally);
  }
  Future _showDoubleDialog() async {
    await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.decimal(
          minValue: 1,
          maxValue: 5,
          decimalPlaces: 2,
          initialDoubleValue: _currentDoubleValue,
          title: new Text("Pick a decimal value"),
        );
      },
    ).then(_handleValueChangedExternally);
  }
}