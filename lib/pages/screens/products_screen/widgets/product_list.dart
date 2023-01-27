import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/products.dart';
import '../../../../utils/formatters.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
      builder: (context, products, child) {
        return ListView.builder(
          itemCount: products.count,
          itemBuilder: (context, index) {
            final product = products.items[index];
            return ListTile(
              title: Text(product.title),
              trailing: Text(
                AppFormatter.currencyFormatter(product.entryPrice),
              ),
              subtitle: const ProductStatsRow(),
            );
          },
        );
      },
    );
  }
}

class ProductStatsRow extends StatelessWidget {
  const ProductStatsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text('Amount: 0'),
        SizedBox(width: 8),
        Text('Reserve: 0'),
        SizedBox(width: 8),
        Text('Pending: 0'),
      ],
    );
  }
}
