class Vitals {
  List<String> temperature;
  List<String> heartRate;
  List<String> respirationRate;
  List<String> bloodPressure;

  Vitals(
      {required this.temperature,
      required this.heartRate,
      required this.respirationRate,
      required this.bloodPressure});

  Vitals.fromJson(Map<String, dynamic> json)
      : this(
          temperature: json['temperature'],
          heartRate: json['heartRate'],
          respirationRate: json['respirationRate'],
          bloodPressure: json['bloodPressure'],
        );


  @override
  String toString() {
    return 'Vitals{temperature: $temperature, heartRate: $heartRate, respirationRate: $respirationRate, bloodPressure: $bloodPressure}';
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'heartRate': heartRate,
      'respirationRate': respirationRate,
      'bloodPressure': bloodPressure,
    };
  }
}
