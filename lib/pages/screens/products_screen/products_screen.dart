import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:provider/provider.dart';

import '../../../blocs/products_catalog_bloc/products_catalog_bloc.dart';
import '../../../di.dart';
import '../../../utils/device.dart';
import '../../../widgets/widgets.dart';

import '../../edit_product_page/edit_product_vm.dart';
import '../../edit_product_page/edit_product_page.dart';
import 'widgets/product_list.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCatalogBloc, ProductsCatalogState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListMenu(
                onAddNewPress: () => _openAddNewProductDialog(context),
              ),
            ),
            Builder(builder: (context) {
              if (state is ProductsCatalogShowProducts) {
                return Expanded(
                  child: ProductList(products: state.productsList),
                );
              } else {
                return const Center(child: SpinKitWave(color: Colors.blue));
              }
            }),
          ],
        );
      },
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
            return ChangeNotifierProvider<EditProductVM>(
              create: (context) => EditProductVM(
                productsRepository: Di.getIt(),
                brandsRepository: Di.getIt(),
                onProductSave: (Product product) {},
              ),
              child: const EditProductPage(),
            );
          },
        ),
      );
    }
  }
}
