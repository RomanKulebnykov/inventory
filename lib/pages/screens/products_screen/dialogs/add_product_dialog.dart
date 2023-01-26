import 'package:flutter/material.dart';

import '../../../../utils/formatters.dart';
import '../../../../widgets/widgets.dart';

class AddProductDialog extends StatefulWidget {
  const AddProductDialog({Key? key}) : super(key: key);

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController name;
  late final TextEditingController code;
  late final TextEditingController defaultPrice;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    name = TextEditingController();
    code = TextEditingController();
    defaultPrice = TextEditingController(text: '0.0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                label: const Text('ProductName'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            TextFormField(
              controller: code,
              decoration: InputDecoration(
                label: const Text('Code'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: defaultPrice,
              decoration: InputDecoration(
                label: const Text('Product Price'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              inputFormatters: [TextInputCurrencyFormatter()],
            ),
            SubmitControlsRow(
              submitStr: 'Add Product',
              onSubmit: () {},
            ),
          ],
        ),
      ),
    );
  }
}
