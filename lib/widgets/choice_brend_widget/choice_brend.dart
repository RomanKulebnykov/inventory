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
      dropdownBuilder: (context, selectedItem) {
        if (selectedItem == null) return Container();
        return _buildSnowCurrent(selectedItem, context);
      },
      popupProps: PopupProps.menu(
        itemBuilder: (context, item, isSelected) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildInlinePopupItem(item, context),
          );
        },
      ),
    );
  }

  Widget _buildSnowCurrent(Brand brand, BuildContext context) {
    return brand.image != null
        ? ImageDataView(imageData: brand.image, height: 30, width: 60)
        : Text(
            brand.name.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge,
          );
  }

  Widget _buildInlinePopupItem(Brand brand, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ImageDataView(imageData: brand.image, height: 30, width: 60),
        Text(
          brand.name.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          color: Colors.amber,
        ),
      ],
    );
  }
}
