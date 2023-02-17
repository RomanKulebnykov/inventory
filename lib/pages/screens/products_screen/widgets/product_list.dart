import 'package:flutter/material.dart';
import 'package:products_catalog/products_catalog.dart';

import '../../../../utils/formatters.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.title),
          trailing: Text(AppFormatter.currencyFormatter(0)),
          subtitle: const ProductStatsRow(),
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
        Text('Amount: 1'),
        SizedBox(width: 8),
        Text('Reserve: 0'),
        SizedBox(width: 8),
        Text('Pending: 0'),
      ],
    );
  }
}
