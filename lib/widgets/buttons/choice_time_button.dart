import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChoiceTimeButton extends StatelessWidget {
  const ChoiceTimeButton({
    Key? key,
    required this.time,
    required this.timeFormat,
    required this.timeChange,
    this.label,
  }) : super(key: key);

  final String? label;
  final TimeOfDay time;
  final DateFormat timeFormat;
  final void Function(TimeOfDay date) timeChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) Text(label!),
        // const SizedBox(width: 4),
        TextButton(
          onPressed: () async {
            final result = await showTimePicker(
              context: context,
              initialTime: time,
            );
            if (result != null) timeChange(result);
          },
          child: Text(time.format(context)),
        ),
      ],
    );
  }
}
