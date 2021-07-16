import 'package:done_exercise/components/custom_elevated_button.dart';
import 'package:done_exercise/components/custom_text_form_field.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/utils/strings.dart';
import 'package:flutter/material.dart';

class BookingNameFormBody extends StatelessWidget {
  BookingNameFormBody({Key? key, required this.bloc}) : super(key: key);

  final BookingBloc bloc;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0)
                .copyWith(top: 23.0, bottom: 42.0),
            child: Text(
              Strings.bookingIntro,
              key: const ValueKey('name_intro_text_key'),
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 19.0, right: 21.0, bottom: 22.0),
            child: Form(
              key: _formKey,
              child: CustomTextFormField(
                key: const ValueKey('name_form_field_key'),
                onChanged: (value) => bloc.add(
                  BookingNameFormEvent(name: value),
                ),
                initialValue: bloc.state.booking.fullName,
                label: Strings.fullName,
                validator: (v) {
                  if (bloc.fullName.isEmpty) {
                    return Strings.nameError;
                  }
                },
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 19.0, right: 21.0, bottom: 22.0),
            child: CustomElevatedButton(
                key: const ValueKey('name_form_button_key'),
                label: Strings.continueText,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    bloc.add(BookingNextStepEvent());
                  }
                }),
          ),
        ],
      ),
    );
  }
}
