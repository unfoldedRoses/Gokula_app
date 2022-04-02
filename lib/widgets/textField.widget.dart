import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GTextField extends StatelessWidget {
  const GTextField(
      {Key? key, required this.label, required this.name, this.validator})
      : super(key: key);

  final String label;
  final String name;
  final dynamic validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: FormBuilderTextField(
        name: name,
        // validator: FormBuilderValidators.compose(
        //     [FormBuilderValidators.required(context)]),
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey.shade300,
            label: Text(label),
            hintText: 'Enter ' + label),
      ),
    );
  }
}
