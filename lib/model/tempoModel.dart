class TempoData {
  final double temp;
  final double sensacao;
  final double tempMax;
  final double tempMin;
  final String desc;
  final String icon;
  final int umidade;

  TempoData(
      {this.temp,
      this.sensacao,
      this.tempMax,
      this.tempMin,
      this.desc,
      this.icon,
      this.umidade});

  factory TempoData.fromJson(Map<String, dynamic> json) {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

    return TempoData(
        temp: json['main']['temp'].toDouble(),
        sensacao: json['main']['feels_like'].toDouble(),
        tempMin: json['main']['temp_min'].toDouble(),
        tempMax: json['main']['temp_max'].toDouble(),
        umidade: json['main']['humidity'].toInt(),
        desc: capitalize(json['weather'][0]['description']),
        icon: json['weather'][0]['icon']);
  }
}
