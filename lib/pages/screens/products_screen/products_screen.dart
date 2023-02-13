import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/pages/edit_product_page/edit_product_cubit.dart';

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
            return BlocProvider<EditProductCubit>(
              create: (context) => EditProductCubit(
                productsRepository: Di.getIt(),
                brandsRepository: Di.getIt(),
                onSave: (product) {},
              ),
              child: const EditProductPage(),
            );
          },
        ),
      );
    }
  }
}
