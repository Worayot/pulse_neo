import 'package:flutter/material.dart';
import 'package:pulse/text_form_field.dart';

class FormBox extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? description;
  final bool showRequiredIndicator;

  const FormBox({
    super.key,
    required this.title,
    required this.controller,
    this.description,
    this.showRequiredIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: (screenWidth - 16) * 0.5,
                height: 55,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xff095D7E),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    bottomLeft: const Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    if (description != null && description!.isNotEmpty)
                      Text(
                        description!,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                  ],
                ),
              ),

              Expanded(
                child: MyTextFormField(
                  controller: controller,
                  showRequiredIndicator: showRequiredIndicator,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
