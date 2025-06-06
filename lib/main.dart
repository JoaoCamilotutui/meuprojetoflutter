import 'package:flutter/material.dart';

void main() => runApp(IMCFacilApp());

class IMCFacilApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC FÁCIL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(

        // 🔴 Início da AppBar (faixa azul com título branco)
        appBar: AppBar(
          title: Text(
            'IMC FÁCIL',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          elevation: 4,
        ),
        // 🔴 Fim da AppBar

        body: IMCPage(),
      ),
    );
  }
}

class IMCPage extends StatefulWidget {
  @override
  _IMCPageState createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  String _resultado = '';
  String _classificacao = '';

  void _calcularIMC() {
    final double peso = double.tryParse(_pesoController.text) ?? 0;
    final double altura = double.tryParse(_alturaController.text) ?? 0;

    if (peso > 0 && altura > 0) {
      final imc = peso / (altura * altura);

      setState(() {
        _resultado = 'IMC: ${imc.toStringAsFixed(2)}';

        if (imc < 18.5) {
          _classificacao = 'Abaixo do peso';
        } else if (imc < 24.9) {
          _classificacao = 'Peso normal';
        } else if (imc < 29.9) {
          _classificacao = 'Sobrepeso';
        } else if (imc < 34.9) {
          _classificacao = 'Obesidade grau I';
        } else if (imc < 39.9) {
          _classificacao = 'Obesidade grau II';
        } else {
          _classificacao = 'Obesidade grau III';
        }
      });
    } else {
      setState(() {
        _resultado = 'Preencha os campos corretamente';
        _classificacao = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _pesoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Peso (kg)'),
          ),
          TextField(
            controller: _alturaController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Altura (m)'),
          ),
          SizedBox(height: 20),
          Align(
  alignment: Alignment.center,
  child: SizedBox(
    width: 180, // 👈 Ajuste essa largura como quiser
    child: ElevatedButton(
      onPressed: _calcularIMC,
      child: Text('Calcular'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16), // horizontal removido
        textStyle: TextStyle(fontSize: 18),
      ),
    ),
  ),
),
          SizedBox(height: 20),
          Text(
            _resultado,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            _classificacao,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          Text(
            'Atenção: Digite ponto para incluir decimais. ',
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 6),
          Text(
            'Observação: A tabela acima é uma referência geral. '
            'Em alguns casos, o IMC pode não ser um indicador preciso da saúde, '
            'especialmente para atletas ou pessoas com muita massa muscular. '
            'É sempre recomendado consultar um profissional de saúde para uma avaliação individualizada.',
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
