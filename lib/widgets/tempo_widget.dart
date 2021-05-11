import 'dart:ui';

import 'package:clima/model/tempoModel.dart';
import 'package:flutter/material.dart';

class Tempo extends StatelessWidget {
  final TempoData temperatura;

  Tempo({Key key, @required this.temperatura}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          'https://openweathermap.org/img/w/${temperatura.icon}.png',
          fit: BoxFit.fill,
          width: 80.0,
        ),
        Text(
          '${temperatura.temp.toStringAsFixed(0)}°C',
          style: TextStyle(fontSize: 50.0),
        ),
        Text(
          temperatura.desc,
          style: TextStyle(fontSize: 30.0),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Mínima de Hoje: ${temperatura.tempMin.toStringAsFixed(0)}°C",
          style: TextStyle(fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
        Text(
          "Máxima de Hoje: ${temperatura.tempMax.toStringAsFixed(0)}°C",
          style: TextStyle(fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
        Text(
          "Sensação Térmica: ${temperatura.sensacao.toStringAsFixed(0)}°C",
          style: TextStyle(fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
        Text(
          "Umidade do Ar: ${temperatura.umidade.toString()}%",
        ),
      ],
    );
  }
}
