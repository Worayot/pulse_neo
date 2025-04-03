import 'package:pulse/model.dart';
import 'package:pulse/send_form_req.dart';

Future<ResponseData> sendForm(Parameters params) async {
  Map<String, dynamic>? response = await sendFormRequest(params);

  if (response != null) {
    print("Response: ${response['text']}");

    if (response['image'] != null) {
      print("Received an image (base64)");
    }

    return ResponseData(
      success: true,
      response: response,
    ); // Successfully received a response
  } else {
    print("Failed to get a response.");
    return ResponseData(
      success: false,
      response: null,
    ); // Failed to get a response
  }
}
