import 'package:done_exercise/components/custom_elevated_button.dart';
import 'package:done_exercise/components/custom_outline_button.dart';
import 'package:done_exercise/core/blocs/booking/booking_bloc.dart';
import 'package:done_exercise/utils/strings.dart';
import 'package:flutter/material.dart';

class BookingBudgetFormBody extends StatelessWidget {
  const BookingBudgetFormBody({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final BookingBloc bloc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0)
                .copyWith(top: 23.0, bottom: 61.0),
            child: Text(
              Strings.budgetIntro,
              key: const Key('budget_intro_text_key'),
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _BudgetButtonList(
              bloc: bloc,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 22.0),
            child: CustomElevatedButton(
              label: Strings.continueText,
              key: const Key('budget_advance_button_key'),
              onPressed: () => bloc.add(BookingNextStepEvent()),
            ),
          ),
        ],
      ),
    );
  }
}

class _BudgetButtonList extends StatefulWidget {
  const _BudgetButtonList({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final BookingBloc bloc;

  @override
  __BudgetButtonListState createState() => __BudgetButtonListState();
}

class __BudgetButtonListState extends State<_BudgetButtonList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.bloc.budgets
          .map(
            (e) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomOutlinedButton(
                  key: Key(e),
                  label: e,
                  borderColor: e == widget.bloc.budget
                      ? Theme.of(context).accentColor
                      : null,
                  onPressed: () {
                    widget.bloc.add(
                      BookingBudgetFormEvent(
                        budget: e,
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(height: 8)
              ],
            ),
          )
          .toList(),
    );
  }
}
