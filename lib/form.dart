import 'package:flutter/material.dart';
import 'package:pulse/chat_screen.dart';
import 'package:pulse/form_box.dart';
import 'package:pulse/model.dart';
import 'package:pulse/send_form.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _consciousnessController =
      TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _sBPController = TextEditingController();
  final TextEditingController _dBPController = TextEditingController();
  final TextEditingController _urineController = TextEditingController();
  final TextEditingController _rrController = TextEditingController();
  final TextEditingController _oxygenSaturationController =
      TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _derivedHRVController = TextEditingController();
  final TextEditingController _derivedBloodPressureController =
      TextEditingController();
  final TextEditingController _derivedMapController = TextEditingController();
  final TextEditingController _derivedBMIController = TextEditingController();

  final List<TextEditingController> _requiredControllers = [];

  @override
  void initState() {
    super.initState();
    _requiredControllers.addAll([
      _consciousnessController,
      _heartRateController,
      _temperatureController,
      _sBPController,
      _dBPController,
      _urineController,
      _rrController,
      _oxygenSaturationController,
      _genderController,
      _weightController,
      _heightController,
    ]);
  }

  void _submitForm() {
    bool allRequiredFilled = true;
    List<String> emptyFields = [];

    for (final controller in _requiredControllers) {
      if (controller.text.trim().isEmpty) {
        allRequiredFilled = false;
        // Find the title associated with this controller (not the most efficient way, but works for this example)
        String title = '';
        if (controller == _consciousnessController) title = "Consciousness";
        if (controller == _heartRateController) title = "Heart rate";
        if (controller == _temperatureController) title = "Temperature";
        if (controller == _sBPController) title = "Systolic Blood Pressure";
        if (controller == _dBPController) title = "Diastolic Blood Pressure";
        if (controller == _urineController) title = "Urine output";
        if (controller == _rrController) title = "Respiratory rate";
        if (controller == _oxygenSaturationController)
          title = "Oxygen Saturation";
        if (controller == _ageController) title = "Age";
        if (controller == _genderController) title = "Gender";
        if (controller == _weightController) title = "Weight";
        if (controller == _heightController) title = "Height";
        if (controller == _derivedHRVController) title = "Derived HRV";
        if (controller == _derivedBloodPressureController)
          title = "Derived Blood Pressure";
        if (controller == _derivedMapController) title = "Derived Map";
        if (controller == _derivedBMIController) title = "Derived BMI";
        emptyFields.add(title);
      }
    }

    if (allRequiredFilled) {
      // Collect all the form values
      final consciousness = _consciousnessController.text.trim();
      final heartRate = _heartRateController.text.trim();
      final temperature = _temperatureController.text.trim();
      final sBP = _sBPController.text.trim();
      final dBP = _dBPController.text.trim();
      final urine = _urineController.text.trim();
      final rr = _rrController.text.trim();
      final oxygenSaturation = _oxygenSaturationController.text.trim();
      final age = _ageController.text.trim();
      final gender = _genderController.text.trim();
      final weight = _weightController.text.trim();
      final height = _heightController.text.trim();
      final derivedHRV = _derivedHRVController.text.trim();
      final derivedBloodPressure = _derivedBloodPressureController.text.trim();
      final derivedMap = _derivedMapController.text.trim();
      final derivedBMI = _derivedBMIController.text.trim();

      Parameters params = Parameters(
        age: int.parse(age),
        gender: gender,
        heartRate: int.parse(heartRate),
        respiratoryRate: int.parse(rr),
        bodyTemperature: double.parse(temperature),
        oxygenSaturation: int.parse(oxygenSaturation),
        systolicBloodPressure: int.parse(sBP),
        diastolicBloodPressure: int.parse(dBP),
        consciousnessLevel: consciousness,
        urineOutput: int.parse(urine),
        weight: double.parse(weight),
        height: double.parse(height),
        derivedHrv: int.tryParse(derivedHRV),
        derivedBmi: double.tryParse(derivedBMI),
        derivedMap: double.tryParse(derivedMap),
        derivedPulsePressure: int.tryParse(derivedBloodPressure),
      );

      sendForm(params).then((responseData) {
        if (responseData.success) {
          // Use the response data
          print("Received Text: ${responseData.response?['text']}");

          if (responseData.response?['image'] != null) {
            print(
              "Received Image (base64): ${responseData.response?['image']}",
            );
          }

          // Navigate to ChatScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(res: responseData),
            ),
          );
        } else {
          // Handle failure case
          print("Failed to send form, no navigation.");
        }
      });
    } else {
      // Show a warning dialog
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Warning'),
              content: Text(
                'Please fill out all the required fields marked with an asterisk (*).\n\nEmpty fields: ${emptyFields.join(", ")}',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  @override
  void dispose() {
    _consciousnessController.dispose();
    _heartRateController.dispose();
    _temperatureController.dispose();
    _sBPController.dispose();
    _dBPController.dispose();
    _urineController.dispose();
    _rrController.dispose();
    _oxygenSaturationController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _derivedBMIController.dispose();
    _derivedBloodPressureController.dispose();
    _derivedHRVController.dispose();
    _derivedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffCCECEE),
      appBar: AppBar(
        backgroundColor: Color(0xff095D7E),
        title: const Text(
          'Pulse',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffCCECEE),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Form",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "* Must Contain",
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ),
              ),
              FormBox(
                title: "Age",
                controller: _ageController,
                showRequiredIndicator: true,
              ),
              FormBox(
                title: "Gender",
                controller: _genderController,
                showRequiredIndicator: true,
                description: "(Male/ Female)",
              ),
              FormBox(
                title: "Weight",
                controller: _weightController,
                showRequiredIndicator: true,
                description: "(kg)",
              ),
              FormBox(
                title: "Height",
                controller: _heightController,
                description: "(m)",
                showRequiredIndicator: true,
              ),
              FormBox(
                title: "Consciousness",
                controller: _consciousnessController,
                showRequiredIndicator: true,
              ),
              FormBox(
                title: "Heart rate",
                controller: _heartRateController,
                showRequiredIndicator: true,
                description: "(bpm)",
              ),
              FormBox(
                title: "Temperature",
                controller: _temperatureController,
                showRequiredIndicator: true,
                description: "(deg Celsius)",
              ),
              FormBox(
                title: "Systolic Blood Pressure",
                controller: _sBPController,
                showRequiredIndicator: true,
              ),
              FormBox(
                title: "Diastolic Blood Pressure",
                controller: _dBPController,
                showRequiredIndicator: true,
              ),
              FormBox(
                title: "Urine output",
                controller: _urineController,
                showRequiredIndicator: true,
              ),
              FormBox(
                title: "Respiratory rate",
                controller: _rrController,
                showRequiredIndicator: true,
              ),
              FormBox(
                title: "Oxygen Saturation",
                controller: _oxygenSaturationController,
                description: "(while giving oxygen)",
                showRequiredIndicator: true,
              ),
              FormBox(
                title: "Derived BMI",
                controller: _derivedBMIController,
                showRequiredIndicator: false,
              ),
              FormBox(
                title: "Derived Blood Pressure",
                controller: _derivedBloodPressureController,
                showRequiredIndicator: false,
              ),
              FormBox(
                title: "Derived HRV",
                controller: _derivedHRVController,
                showRequiredIndicator: false,
              ),
              FormBox(
                title: "Derived Map",
                controller: _derivedMapController,
                showRequiredIndicator: false,
              ),

              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff095D7E),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
