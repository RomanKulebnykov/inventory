import 'package:flutter/material.dart';

class SubmitControlsRow extends StatelessWidget {
  const SubmitControlsRow({
    Key? key,
    required this.submitStr,
    required this.onSubmit,
  }) : super(key: key);

  final Function() onSubmit;
  final String submitStr;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.error,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.primary,
            ),
          ),
          onPressed: () {
            onSubmit();
            Navigator.of(context).pop();
          },
          child: Text(submitStr),
        ),
      ],
    );
  }
}
