import 'package:flutter/material.dart';

class AddLossOrderDialog extends StatefulWidget {
  const AddLossOrderDialog({Key? key}) : super(key: key);

  @override
  State<AddLossOrderDialog> createState() => _AddEnterOrderDialogState();
}

class _AddEnterOrderDialogState extends State<AddLossOrderDialog> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add Loss Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
