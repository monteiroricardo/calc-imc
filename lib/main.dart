import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controlarPeso = new TextEditingController();
  TextEditingController controlarAltura = new TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = "Informe seus dados";
  void _resetFilds() {
    controlarAltura.text = "";
    controlarPeso.text = "";
    setState(() {
      _info = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    setState(() {
      double peso = double.parse(controlarPeso.text);
      double altura = double.parse(controlarAltura.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _info = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc > 18.6 && imc < 24.9) {
        _info = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc > 24.9 && imc < 29.9) {
        _info = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc > 29.9 && imc < 34.9) {
        _info = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc > 34.9 && imc < 39.9) {
        _info = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc > 40) {
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "CALCULADORA DE IMC",
            style: TextStyle(fontFamily: "Segoe UI"),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFilds,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            // para a tela rolar
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person,
                    size: 120.0,
                    color: Colors.green,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (Kg)",
                        labelStyle: TextStyle(
                          color: Colors.green,
                          fontFamily: "Segoe UI",
                        )),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25.0,
                      fontFamily: "Segoe UI",
                    ),
                    controller: controlarPeso,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(
                          color: Colors.green,
                          fontFamily: "Segoe UI",
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 25.0,
                          fontFamily: "Segoe UI"),
                      controller: controlarAltura,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua Altura!";
                        }
                      }),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            calculate();
                          }
                        },
                        color: Colors.green,
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "Segoe UI",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(_info,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25.0,
                        fontFamily: "Segoe UI",
                      ))
                ],
              ),
            )));
  }
}
