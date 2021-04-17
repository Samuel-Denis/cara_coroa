import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _info = "Infome seus dados";

  void _resetfield() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
    _info = "Informe seus dados";
  });
  }

  void _calcular() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _info = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _info = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc <= 34.9) {
        _info = "(Obesidade Grau I ${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _info = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc > 40) {
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculador de IMC"),
          centerTitle: true,
          backgroundColor: Colors.tealAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetfield)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 150,
                  color: Colors.tealAccent,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso Kg",
                      labelStyle: TextStyle(color: Colors.tealAccent)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.tealAccent, fontSize: 25),
                  controller: weightController,
                  validator: (value) {
                    if ( value.isEmpty){
                      return "Insira seu Peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura CM",
                      labelStyle: TextStyle(color: Colors.tealAccent)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.tealAccent, fontSize: 25),
                  controller: heightController,
                  validator: (value) {
                   if ( value.isEmpty){
                     return "Insira sua Altura";
                   }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        if ( _formKey.currentState.validate()){
                          _calcular();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.1),
                      ),
                      color: Colors.tealAccent,
                    ),
                  ),
                ),
                Text(
                  _info,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.tealAccent, fontSize: 25),
                )
              ],
            ),
          ),
        ));
  }
}
