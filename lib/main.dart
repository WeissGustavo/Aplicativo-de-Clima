import 'package:clima/theme/theme.dart';
import 'package:clima/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(PrevisaoTempo());
}

class PrevisaoTempo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      title: 'Previsão do Tempo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
    );
  }
}
