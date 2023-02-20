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
    final testProducts = List<Product>.generate(20, (index) => products.first);
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
          isPinned: true,
        ),
        TabHeadCell(
          element: const HeadCellText(text: 'Image'),
          idLabel: 'image',
          fixedWidth: 50,
          isPinned: true,
        ),
        TabHeadCell(
          element: const HeadCellText(text: 'Code'),
          idLabel: 'code',
        ),
        TabHeadCell(
          element: const HeadCellText(text: 'Article'),
          idLabel: 'article',
        ),
        TabHeadCell(
          element: const HeadCellText(text: 'Title'),
          idLabel: 'title',
        ),
        TabHeadCell(
          element: const HeadCellText(text: 'Entry Price'),
          idLabel: 'entryPrice',
        ),
        TabHeadCell(
          element: const HeadCellText(text: 'Selling Price'),
          idLabel: 'sellingPrice',
        ),
        TabHeadCell(
          element: const HeadCellText(text: 'Last Update'),
          idLabel: 'lastUpdate',
        ),
      ],
      rows: [
        for (final product in testProducts)
          TabRow(
            cells: [
              TabCell(
                idColumn: 'check',
                element: Checkbox(value: false, onChanged: (value) {}),
              ),
              TabCell(
                idColumn: 'image',
                element: ImageDataView(imageData: product.image),
              ),
              TabCell(
                idColumn: 'code',
                element: Text(product.code),
              ),
              TabCell(
                idColumn: 'article',
                element: Text(product.articles.join(',')),
              ),
              TabCell(
                idColumn: 'title',
                element: Text(product.title),
              ),
              TabCell(
                idColumn: 'entryPrice',
                element: Text(AppFormatter.currency(product.entryPrice)),
              ),
              TabCell(
                idColumn: 'sellingPrice',
                element: Text(AppFormatter.currency(product.sellingPrice)),
              ),
              TabCell(
                idColumn: 'lastUpdate',
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
