import 'package:done_exercise/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.label,
    this.initialValue,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  final String? label;
  final String? initialValue;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      style: Theme.of(context).textTheme.headline6,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: CustomColors.textFieldBorder),
      ),
    );
  }
}
