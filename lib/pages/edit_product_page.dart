import 'package:flutter/material.dart';
import 'package:inventory/providers/edit_product_controller.dart';
import 'package:provider/provider.dart';

import '../utils/formatters.dart';
import '../widgets/widgets.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProductController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.title,
                    decoration: InputDecoration(
                      label: const Text('ProductName'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: controller.code,
                    decoration: InputDecoration(
                      label: const Text('Code'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.entryPrice,
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
                    onSubmit: controller.saveProduct,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
