import 'package:flutter/material.dart';
import 'package:inventory/blocs/products/products_bloc.dart';
import 'package:inventory/pages/edit_product_page/edit_product_controller.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../utils/device.dart';
import '../../../widgets/widgets.dart';

import '../../edit_product_page/edit_product_page.dart';
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
          return const EditProductPage();
        },
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider<EditProductController>(
              create: (context) => EditProductController(
                  // onProductSave: (product) {
                  //   // ProductsProvider.read(context)
                  //   //     .saveProduct(newProduct: product);
                  //   ProductsBloc.addEvent(context, SaveProductEvent(product));
                  // },
                  ),
              child: const EditProductPage(),
            );
          },
        ),
      );
    }
  }
}
