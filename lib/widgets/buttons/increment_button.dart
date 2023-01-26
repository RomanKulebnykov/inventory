import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// TODO: Has bug for update parse value
class IncrementButton extends StatelessWidget {
  IncrementButton({
    Key? key,
    required this.onChange,
    required this.value,
    this.maxValue = 5,
    this.minValue = 0,
  }) : super(key: key);

  final void Function(int value) onChange;
  final int value;
  final int maxValue;
  final int minValue;

  late final _valueTextController = TextEditingController(text: '$value');
  late final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _decrement,
          icon: const Icon(Icons.remove),
          color: Theme.of(context).colorScheme.primary,
        ),
        IntrinsicWidth(
          child: TextFormField(
            controller: _valueTextController,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: _parseValue,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(),
              border: InputBorder.none,
            ),
          ),
        ),
        IconButton(
          onPressed: _increment,
          icon: const Icon(Icons.add),
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  void _increment() {
    _focusNode.unfocus();
    if (value < maxValue) {
      final newValue = value + 1;
      _valueTextController.text = newValue.toString();
      onChange(newValue);
    }
  }

  void _decrement() {
    _focusNode.unfocus();
    if (value > minValue) {
      final newValue = value - 1;
      _valueTextController.text = newValue.toString();
      onChange(newValue);
    }
  }

  void _parseValue(String strValue) {
    final newValue = int.tryParse(_valueTextController.text);
    if (newValue != null && newValue < maxValue && newValue > minValue) {
      onChange(newValue);
    } else {
      print(strValue);
      _valueTextController.text = value.toString();
    }
  }
}
