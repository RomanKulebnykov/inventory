import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChoiceDateButton extends StatelessWidget {
  const ChoiceDateButton({
    Key? key,
    required this.date,
    required this.dateChange,
    required this.dateFormat,
    this.label,
  }) : super(key: key);

  final String? label;
  final DateTime date;
  final DateFormat dateFormat;
  final void Function(DateTime date) dateChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) Text(label!),
        // const SizedBox(width: 4),
        TextButton(
          onPressed: () async {
            final result = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: date.subtract(
                const Duration(days: 365 * 5),
              ),
              lastDate: date.add(
                const Duration(days: 365 * 5),
              ),
            );
            if (result != null) {
              dateChange(result);
            }
          },
          child: Text(dateFormat.format(date)),
        ),
      ],
    );
  }
}
