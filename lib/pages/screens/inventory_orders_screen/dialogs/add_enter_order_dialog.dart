import 'package:flutter/material.dart';
import 'package:inventory_manager/inventory_manager.dart';

import 'package:provider/provider.dart';

import '../../../../providers/edit_product_order_controller.dart';
import '../../../../providers/product_orders_provider.dart';
import '../../../../providers/products_provider.dart';
import '../../../../utils/formatters.dart';
import '../../../../widgets/widgets.dart';

class AddEnterOrderDialog extends StatelessWidget {
  const AddEnterOrderDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<EditProductOrderController>(
        builder: (context, controller, child) {
          return Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ChoiceDateButton(
                              label: 'Date:',
                              dateFormat: AppFormatter.dateFormat,
                              date: controller.date,
                              dateChange: controller.updateDate,
                            ),
                            ChoiceTimeButton(
                              label: 'Time:',
                              time: controller.time,
                              timeFormat: AppFormatter.timeFormat,
                              timeChange: controller.updateTime,
                            ),
                          ],
                        ),
                        ProductSearchList(
                          orderItems: controller.orderItems,
                          onItemUpdated: controller.updateOrderItem,
                        ),
                        ProductSearch(
                          items: ProductsProvider.watch(context).items,
                          onFind: controller.addOrderItem,
                        ),
                      ],
                    ),
                  ),
                ),
                SubmitControlsRow(
                  onSubmit: () {
                    final order = OrderInventoryEnter(
                      id: controller.id,
                      dateTime: controller.dateTime,
                      status: controller.status,
                      items: controller.orderItems,
                    );
                    ProductOrdersProvider<OrderInventoryEnter>.read(context)
                        .addOrder(newOrder: order);
                  },
                  submitStr: 'Add Enter Order',
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
