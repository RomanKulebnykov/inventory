import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:provider/provider.dart';

import '../../../blocs/products_catalog_bloc/products_catalog_bloc.dart';
import '../../../di.dart';
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
        print(state);
        if (state is ProductsCatalogEditProduct) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ChangeNotifierProvider<EditProductVM>(
                  create: (context) => EditProductVM(
                    productsRepository: Di.getIt(),
                    brandsRepository: Di.getIt(),
                    onProductSave: (Product product) {
                      ProductsCatalogBloc.addEvent(
                        context,
                        ProductsCatalogReloadProductsEvent(),
                      );
                      Navigator.of(context).pop();
                    },
                    onEditCancelled: () {
                      ProductsCatalogBloc.addEvent(
                        context,
                        ProductsCatalogReloadProductsEvent(),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                  child: const EditProductPage(),
                );
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListMenu(
                onAddNewPress: () {
                  ProductsCatalogBloc.addEvent(
                    context,
                    ProductsCatalogAddNewProductEvent(),
                  );
                },
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
}
