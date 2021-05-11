import 'dart:convert';
import 'package:clima/model/tempoModel.dart';
import 'package:clima/widgets/tempo_widget.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  TempoData tempoData;
  Location location = new Location();
  List<double> coords;
  @override
  void initState() {
    super.initState();
    carregaTempoCoord();
  }

  List<String> _cidades = [
    'Aracaju',
    'Belém',
    'Belo Horizonte',
    'Boa Vista',
    'Brasilia',
    'Campo Grande',
    'Cuiaba',
    'Curitiba',
    'Florianópolis',
    'Fortaleza',
    'Goiânia',
    'João Pessoa',
    'Macapá',
    'Maceió',
    'Manaus',
    'Natal',
    'Palmas',
    'Porto Alegre',
    'Porto Velho',
    'Recife',
    'Rio Branco',
    'Rio de Janeiro',
    'Salvador',
    'São Luiz',
    'São Paulo',
    'Teresina',
    'Vitoria'
  ];

  String _cidadeSelecionada = "São Paulo";

  carregaTempoNome() async {
    setState(() {
      isLoading = true;
    });

    String appid = 'c0589ff140ba6dfebdd7b43985fb6867';
    String lang = 'pt_br';
    String units = 'metric';

    final tempoResponse = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$_cidadeSelecionada&appid=$appid&units=$units&lang=$lang'));

    print("foi");
    if (tempoResponse.statusCode == 200) {
      return setState(() {
        tempoData = TempoData.fromJson(jsonDecode(tempoResponse.body));
        isLoading = false;
      });
    }
  }

  Future<List<double>> _getLocation() async {
    List<double> result = [];
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) return null;

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied)
      _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) return null;

    var loc = await location.getLocation();

    result.add(loc.latitude);
    result.add(loc.longitude);

    return result;
  }

  carregaTempoCoord() async {
    setState(() {
      isLoading = true;
    });
    coords = await _getLocation();
    String appid = 'c0589ff140ba6dfebdd7b43985fb6867';
    String lang = 'pt_br';
    String units = 'metric';
    final tempoResponse = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${coords[0]}&lon=${coords[1]}&appid=$appid&units=$units&lang=$lang'));
    if (tempoResponse.statusCode == 200) {
      return setState(() {
        tempoData = TempoData.fromJson(jsonDecode(tempoResponse.body));
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_cidadeSelecionada),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SearchableDropdown.single(
              items: _cidades
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _cidadeSelecionada = value;
                  carregaTempoNome();
                });
              },
              displayClearIcon: false,
              value: _cidadeSelecionada,
              icon: Icon(Icons.location_on),
              isExpanded: true,
              closeButton: "Fechar",
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 4.0,
                            valueColor: new AlwaysStoppedAnimation(Colors.blue),
                          )
                        : tempoData != null
                            ? Tempo(temperatura: tempoData)
                            : Container(
                                child: Text(
                                "Sem Dados",
                                style: Theme.of(context).textTheme.headline4,
                              ))),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
