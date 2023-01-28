import 'package:flutter/material.dart';
import 'package:inventory_manager/inventory_manager.dart';

import 'package:provider/provider.dart';
import '../../../../providers/edit_product_order_controller.dart';
import '../../../../providers/product_orders_provider.dart';
import '../../../../widgets/buttons/circle_button.dart';
import '../dialogs/add_enter_order_dialog.dart';

class EnterOrdersScreen extends StatelessWidget {
  const EnterOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Head section
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter Orders',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),

        /// Order list section
        ///
        Expanded(
          child: Consumer<ProductOrdersProvider<OrderInventoryEnter>>(
            builder: (context, productOrders, child) {
              return ListView.builder(
                itemCount: productOrders.count,
                itemBuilder: (context, index) {
                  final productOrder = productOrders.orders[index];
                  return ListTile(
                    title: Text(productOrder.id),
                  );
                },
              );
            },
          ),
        ),

        /// Controls Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleButton(
                    iconColor: Colors.white,
                    filledColor: Colors.green,
                    borderColor: Colors.transparent,
                    iconData: Icons.add,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isDismissible: false,
                        builder: (context) {
                          return ChangeNotifierProvider<
                              EditProductOrderController>(
                            create: (context) => EditProductOrderController(),
                            child: const AddEnterOrderDialog(),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 4),
                  CircleButton(
                    iconColor: Colors.white,
                    filledColor: Colors.grey,
                    borderColor: Colors.transparent,
                    iconData: Icons.filter_list,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
