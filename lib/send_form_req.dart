import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pulse/model.dart';

Future<Map<String, dynamic>?> sendFormRequest(Parameters params) async {
  Map<String, dynamic> data = {
    "age": params.age,
    "gender": params.gender,
    "weight": params.weight,
    "height": params.height,
    "heart_rate": params.heartRate,
    "respiratory_rate": params.respiratoryRate,
    "body_temperature": params.bodyTemperature,
    "oxygen_saturation": params.oxygenSaturation,
    "systolic_blood_pressure": params.systolicBloodPressure,
    "diastolic_blood_pressure": params.diastolicBloodPressure,
    "consciousness_level": params.consciousnessLevel,
    "urine_output": params.urineOutput,
    "derived_bmi": params.derivedBmi, // ✅ Fixed key
    "derived_pulse_pressure": params.derivedPulsePressure,
    "derived_map": params.derivedMap,
    "derived_hrv": params.derivedHrv,
  };

  // Remove null fields
  data.removeWhere((key, value) => value == null);

  try {
    final response = await http.post(
      // Uri.parse('$url/form'),
      Uri.parse('https://8aa6-34-124-171-37.ngrok-free.app/form'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Request failed with status: ${response.statusCode}");
      print("Response body: ${response.body}");
      return null;
    }
  } catch (e) {
    print("Error sending request: $e");
    return null;
  }
}
