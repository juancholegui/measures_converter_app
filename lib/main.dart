import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>{
  double _numberFrom;
  String _startMeasure;
  String _convertedMeasure;
  String _resultMessage;

  final List<String> _measures = ['meters', 'kilometers', 'grams', 'kilograms', 'feet','miles', 'pounds (lbs)', 'ounces'];

  final Map<String, int> _measuresMap = {
    'meters' : 0,
    'kilometers' : 1,
    'grams' : 2,
    'kilograms' : 3,
    'feet' : 4,
    'miles' : 5,
    'pounds (lbs)' : 6,
    'ounces' : 7,
  };

  final dynamic _formulas = {
    '0' : [1,0.001,0,0,3.28084,0.000621371,0,0],
    '1' : [1000,1,0,0,3280.84,0.621371,0,0],
    '2' : [0,0,1,0.0001,0,0,0.00220462,0.035274],
    '3' : [0,0,1000,1,0,0,2.20462,35.274],
    '4' : [0.3048,0.0003048,0,0,1,0.000189394,0,0],
    '5' : [1609.34, 1.60934,0,0,5280,1,0,0],
    '6' : [0,0,453.592,0.453592,0,0,1,16],
    '7' : [0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
  };

  @override
  void initState(){
    _numberFrom = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      final TextStyle inputStyle = TextStyle(
        fontSize: 20,
        color: Colors.blue[900],
      );

      final TextStyle labelStyle = TextStyle(
        fontSize: 24,
        color: Colors.grey[700],
      );

      return MaterialApp(
        title: 'Measures converter',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Measures Converter'),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children:[
                  Spacer(),

                  //Value text
                  Text(
                    'Value',
                    style: labelStyle,
                  ),
                  Spacer(),

                  //Input data
                  TextField(
                    style: inputStyle,
                    decoration: InputDecoration(
                      hintText: 'Please insert the measure to be converted',
                    ),
                      onChanged: (text){
                        var rv = double.tryParse(text);
                        if (rv != null){
                          setState((){
                          _numberFrom = rv;
                          });
                        }
                      },
                    ),
                    Spacer(),

                  //Text from
                  Text(
                    'From',
                    style: labelStyle,
                  ),

                  //Measures
                  DropdownButton(
                    isExpanded: true,
                    items: _measures.map((String value){
                      return DropdownMenuItem<String>(
                        value: _startMeasure,
                        child: Text(value),);
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        _startMeasure = value;
                      });
                    },
                    value: _startMeasure,
                  ),
                  Spacer(),

                  //Text to
                  Text(
                    'To',
                    style: labelStyle,
                  ),
                  Spacer(),

                  //List converted Measures
                  DropdownButton(
                    isExpanded: true,
                    items: _measures.map((String value){
                      return DropdownMenuItem<String>(
                        value: _convertedMeasure,
                        child: Text(value),);
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        _convertedMeasure = value;
                      });
                    },
                    value: _convertedMeasure,
                  ),

                  //Raised Button
                  Spacer(flex: 2,),
                    RaisedButton(
                      child: Text('Convert', style: labelStyle,),
                      onPressed: () {
                        if(_startMeasure.isEmpty || _convertedMeasure.isEmpty || _numberFrom == 0){
                          return;
                        }else{
                          convert(_numberFrom, _startMeasure, _convertedMeasure);
                        }
                      },
                    ),
                  Spacer(flex: 2,),

                  //Text From
                  Text ((_resultMessage == null) ? '' : _resultMessage,
                  style: labelStyle,),
                  Spacer(flex: 8,),
                ],
              ),
            ),
          ),
        ),
      );
    }

  void convert(double value, String from, String to){
    int nFrom = _measuresMap[from];
    int nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()] [nTo];
    var result = value * multiplier;

    if(result == 0){
      _resultMessage = 'This convertion can´t be performed';
    }else{
      _resultMessage = '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
    }
    setState((){
      _resultMessage = _resultMessage;
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
