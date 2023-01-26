import 'package:flutter/material.dart';
import 'package:inventory_manager/inventory_manager.dart';
import 'package:provider/provider.dart';

import '../../../../providers/product_orders.dart';
import '../../../../widgets/buttons/circle_button.dart';
import '../dialogs/add_loss_order_dialog.dart';

class LossOrdersScreen extends StatelessWidget {
  const LossOrdersScreen({Key? key}) : super(key: key);

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
                'Loss Orders',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),

        /// Order list section
        ///
        Expanded(
          child: Consumer<ProductOrders<OrderInventoryLoss>>(
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
                          return const AddLossOrderDialog();
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
