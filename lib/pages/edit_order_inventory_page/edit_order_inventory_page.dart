import 'package:flutter/material.dart';
import 'package:inventory/pages/edit_order_inventory_page/edit_order_inventory_vm.dart';
import 'package:inventory/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EditOrderInventoryPage extends StatelessWidget {
  const EditOrderInventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EditOrderInventoryVM>(
      builder: (context, viewModel, child) {
        return Scaffold(
          key: viewModel.scaffoldKey,
          body: Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                SubmitControlsRow(
                  submitStr: 'Save Order',
                  onSubmit: viewModel.saveOrder,
                  onCancel: viewModel.editCanceled,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
