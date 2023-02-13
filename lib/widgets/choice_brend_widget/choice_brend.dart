import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:products_catalog/products_catalog.dart';

import '../image_data_view.dart';

class ChoiceBrend extends StatelessWidget {
  const ChoiceBrend({
    super.key,
    required this.brands,
    required this.onSelect,
  });

  final Future<List<Brand>> brands;
  final Function(Brand? brand) onSelect;
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Brand>(
      itemAsString: (item) => item.name,
      asyncItems: (text) => brands,
      onChanged: onSelect,
      popupProps: PopupProps.menu(
        itemBuilder: (context, item, isSelected) {
          return Row(
            children: [
              ImageDataView(imageData: item.image, height: 30, width: 15),
              Text(item.name),
            ],
          );
        },
      ),
    );
  }
}
