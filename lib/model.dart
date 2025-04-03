class ChatRequest {
  final String message;
  final bool useGraph;

  ChatRequest({required this.message, this.useGraph = true});

  // Manual JSON serialization
  factory ChatRequest.fromJson(Map<String, dynamic> json) {
    return ChatRequest(
      message: json['message'] as String,
      useGraph: json['useGraph'] ?? true, // Default to true if not provided
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'useGraph': useGraph};
  }
}

class Parameters {
  final int age;
  final String gender;
  final double weight;
  final double height;
  final int heartRate;
  final int respiratoryRate;
  final double bodyTemperature;
  final int oxygenSaturation;
  final int systolicBloodPressure;
  final int diastolicBloodPressure;
  final String consciousnessLevel;
  final double? derivedBmi;
  final int? derivedPulsePressure;
  final double? derivedMap;
  final int? derivedHrv;
  final int? urineOutput;

  Parameters({
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.heartRate,
    required this.respiratoryRate,
    required this.bodyTemperature,
    required this.oxygenSaturation,
    required this.systolicBloodPressure,
    required this.diastolicBloodPressure,
    required this.consciousnessLevel,
    this.derivedBmi,
    this.derivedPulsePressure,
    this.derivedMap,
    this.derivedHrv,
    this.urineOutput,
  });

  // Manual JSON serialization
  factory Parameters.fromJson(Map<String, dynamic> json) {
    return Parameters(
      age: json['age'] as int,
      gender: json['gender'] as String,
      weight: json['weight'] as double,
      height: json['height'] as double,
      heartRate: json['heartRate'] as int,
      respiratoryRate: json['respiratoryRate'] as int,
      bodyTemperature: (json['bodyTemperature'] as num).toDouble(),
      oxygenSaturation: json['oxygenSaturation'] as int,
      systolicBloodPressure: json['systolicBloodPressure'] as int,
      diastolicBloodPressure: json['diastolicBloodPressure'] as int,
      consciousnessLevel: json['consciousnessLevel'] as String,
      derivedBmi: (json['derivedBmi'] as num?)?.toDouble(),
      derivedPulsePressure: json['derivedPulsePressure'] as int?,
      derivedMap: (json['derivedMap'] as num?)?.toDouble(),
      derivedHrv: json['derivedHrv'] as int?,
      urineOutput: json['urineOutput'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'gender': gender,
      'weight': weight,
      'height': height,
      'heartRate': heartRate,
      'respiratoryRate': respiratoryRate,
      'bodyTemperature': bodyTemperature,
      'oxygenSaturation': oxygenSaturation,
      'systolicBloodPressure': systolicBloodPressure,
      'diastolicBloodPressure': diastolicBloodPressure,
      'consciousnessLevel': consciousnessLevel,
      'derivedBmi': derivedBmi,
      'derivedPulsePressure': derivedPulsePressure,
      'derivedMap': derivedMap,
      'derivedHrv': derivedHrv,
      'urineOutput': urineOutput,
    };
  }
}

class ResponseData {
  final bool success;
  final Map<String, dynamic>? response;

  ResponseData({required this.success, this.response});
}
