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
    bool isChecked = false;
    return ResizableTable(
      persistance: persistance,
      withDividers: true,
      columns: [
        TabHeadCell(
          element: StatefulBuilder(
            builder: (context, setState) {
              return Checkbox(
                value: isChecked,
                onChanged: (value) => setState(() => isChecked = value!),
              );
            },
          ),
          idLabel: 'check',
          fixedWidth: 52,
          showInMenu: false,
        ),
        TabHeadCell(
          element: const Text('Image', overflow: TextOverflow.ellipsis),
          idLabel: 'image',
          fixedWidth: 50,
          showInMenu: false,
        ),
        TabHeadCell(
          element: const Text('Code', overflow: TextOverflow.ellipsis),
          idLabel: 'code',
        ),
        TabHeadCell(
          element: const Text('Article', overflow: TextOverflow.ellipsis),
          idLabel: 'article',
        ),
        TabHeadCell(
          element: const Text('Title', overflow: TextOverflow.ellipsis),
          idLabel: 'title',
        ),
        TabHeadCell(
          element: const Text('Entry Price', overflow: TextOverflow.ellipsis),
          idLabel: 'entryPrice',
        ),
        TabHeadCell(
          element: const Text('Selling Price', overflow: TextOverflow.ellipsis),
          idLabel: 'sellingPrice',
        ),
        TabHeadCell(
          element: const Text('Last Update', overflow: TextOverflow.ellipsis),
          idLabel: 'lastUpdate',
        ),
      ],
      rows: [
        for (final product in products)
          TabRow(
            cells: [
              TabCell(element: Checkbox(value: false, onChanged: (value) {})),
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
