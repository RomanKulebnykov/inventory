import 'package:flutter/material.dart';

class CellCheckBox extends StatefulWidget {
  const CellCheckBox({
    super.key,
    required this.value,
    required this.onChange,
  });

  final void Function(bool value) onChange;
  final bool value;

  @override
  State<CellCheckBox> createState() => _CellCheckBoxState();
}

class _CellCheckBoxState extends State<CellCheckBox> {
  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  late bool value;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: value,
        onChanged: (newValue) {
          setState(() => value = newValue!);
          widget.onChange(value);
        });
  }
}
