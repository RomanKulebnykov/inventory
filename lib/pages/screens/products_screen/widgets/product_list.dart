import 'package:flutter/material.dart';
import 'package:inventory/blocs/products_catalog_bloc/products_catalog_bloc.dart';
import 'package:inventory/models/product_presentation.dart';
import 'package:inventory/utils/formatters.dart';
import 'package:inventory/widgets/image_data_view.dart';
import 'package:resizable_table/resizable_table.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.products,
    this.persistance,
  }) : super(key: key);

  final List<ProductPresentation> products;
  final ResizableTablePersistance? persistance;

  @override
  Widget build(BuildContext context) {
    final testProducts =
        List<ProductPresentation>.generate(20, (index) => products.first);

    return ResizableTable(
      persistance: persistance,
      withDividers: true,
      columns: [
        TabHeadCell(
          element: CellCheckBox(value: false, onChange: (value) {}),
          idLabel: 'check',
          fixedWidth: 52,
          isPinned: true,
        ),
        TabHeadCell(
          element: const CellText(text: 'Image'),
          idLabel: 'image',
          fixedWidth: 50,
          isPinned: true,
        ),
        TabHeadCell(
          element: const CellText(text: 'Code'),
          idLabel: 'code',
        ),
        TabHeadCell(
          element: const CellText(text: 'Article'),
          idLabel: 'article',
        ),
        TabHeadCell(
          element: const CellText(text: 'Title'),
          idLabel: 'title',
        ),
        TabHeadCell(
          element: const CellText(text: 'Entry Price'),
          idLabel: 'entryPrice',
        ),
        TabHeadCell(
          element: const CellText(text: 'Selling Price'),
          idLabel: 'sellingPrice',
        ),
        TabHeadCell(
          element: const CellText(text: 'Last Update'),
          idLabel: 'lastUpdate',
        ),
        TabHeadCell(
          element: const CellText(text: 'Brand'),
          idLabel: 'brand',
        ),
      ],
      rows: [
        for (final product in products)
          TabRow(
            onTap: () => ProductsCatalogBloc.addEvent(
                context, ProductsCatalogEditProductEvent(product.toProduct)),
            cells: [
              TabCell(
                idColumn: 'check',
                element: CellCheckBox(value: false, onChange: (value) {}),
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
              TabCell(
                idColumn: 'brand',
                element: ImageDataView(imageData: product.brand?.image),
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
