import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:products_manager/products_manager.dart';

class ProductSearch extends StatelessWidget {
  const ProductSearch({
    Key? key,
    required this.onFind,
    required this.items,
  }) : super(key: key);

  final List<Product> items;
  final Function(Product item) onFind;
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Product>(
      items: items,
      itemAsString: (item) => item.title,
      onBeforeChange: (prevItem, nextItem) async {
        if (nextItem != null) {
          onFind(nextItem);
        }
        return false;
      },
    );
  }
}
