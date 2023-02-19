import 'package:flutter/material.dart';
import 'package:inventory/utils/formatters.dart';
import 'package:inventory/widgets/image_data_view.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:resizable_table/resizable_table.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.products,
    this.persistance,
  }) : super(key: key);

  final List<Product> products;
  final ResizableTablePersistance? persistance;
  @override
  Widget build(BuildContext context) {
    return ResizableTable(
      persistance: persistance,
      withDividers: true,
      columns: [
        TabHeadCell(text: 'Image', idLabel: 'image', fixedWidth: 60),
        TabHeadCell(text: 'Code', idLabel: 'code'),
        TabHeadCell(text: 'Article', idLabel: 'article'),
        TabHeadCell(text: 'Title', idLabel: 'title'),
        TabHeadCell(text: 'Entry Price', idLabel: 'entryPrice'),
        TabHeadCell(text: 'Selling Price', idLabel: 'sellingPrice'),
        TabHeadCell(text: 'Last Update', idLabel: 'lastUpdate'),
      ],
      rows: [
        for (final product in products)
          TabRow(
            cells: [
              TabCell(element: ImageDataView(imageData: product.image)),
              TabCell(element: Text(product.code)),
              TabCell(element: Text(product.articles.join(','))),
              TabCell(element: Text(product.title)),
              TabCell(
                element:
                    Text(AppFormatter.currencyFormatter(product.entryPrice)),
              ),
              TabCell(
                element:
                    Text(AppFormatter.currencyFormatter(product.sellingPrice)),
              ),
              TabCell(
                element:
                    Text(AppFormatter.dateFormat.format(product.lastUpdate)),
              ),
            ],
          )
      ],
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
