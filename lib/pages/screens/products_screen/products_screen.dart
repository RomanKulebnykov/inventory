import 'package:flutter/material.dart';

import '../../../utils/device.dart';
import '../../../widgets/widgets.dart';
import 'dialogs/add_product_dialog.dart';
import 'widgets/product_list.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListMenu(
            onAddNewPress: () => _openAddNewProductDialog(context),
          ),
        ),
        const Expanded(
          child: ProductList(),
        ),
      ],
    );
  }

  _openAddNewProductDialog(BuildContext context) {
    if (Device.of(context).deviceType == DeviceType.phone) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (context) {
          return const AddProductDialog();
        },
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: AddProductDialog(),
            );
          },
        ),
      );
    }
  }
}
