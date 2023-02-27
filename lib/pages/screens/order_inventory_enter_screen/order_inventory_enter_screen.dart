import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inventory/blocs/bloc/order_inventory_bloc/order_inventory_bloc.dart';
import 'package:inventory/pages/edit_order_inventory_page/edit_order_inventory_page.dart';
import 'package:inventory/pages/edit_order_inventory_page/edit_order_inventory_vm.dart';
import 'package:inventory/pages/screens/order_inventory_enter_screen/order_inventory_enter_list.dart';
import 'package:inventory/widgets/widgets.dart';
import 'package:provider/provider.dart';

class OrderInventoryEnterScreen extends StatelessWidget {
  const OrderInventoryEnterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderInventoryEnterBloc, OrderInventoryEnterState>(
      listener: (context, state) {
        if (state is OrderInventoryEnterEditOrder) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ChangeNotifierProvider<EditOrderInventoryVM>(
                  create: (context) => EditOrderInventoryVM(
                    onOrderSave: (order) {
                      OrderInventoryEnterBloc.addEvent(
                        context,
                        OrderInventoryEnterReloadEvent(),
                      );
                      Navigator.of(context).pop();
                    },
                    onEditCancelled: () {
                      OrderInventoryEnterBloc.addEvent(
                        context,
                        OrderInventoryEnterReloadEvent(),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                  child: const EditOrderInventoryPage(),
                );
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListMenu(
              onAddNewPress: () {
                OrderInventoryEnterBloc.addEvent(
                  context,
                  OrderInventoryEnterAddNewOrderEvent(),
                );
              },
            ),
          ),
          Builder(
            builder: (context) {
              if (state is OrderInventoryEnterShowOrders) {
                return Expanded(
                  child: OrderInventoryEnterList(orders: state.orders),
                );
              } else {
                return const Center(child: SpinKitWave(color: Colors.blue));
              }
            },
          ),
        ]);
      },
    );
  }
}
