import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:products_catalog/products_catalog.dart';

import '../image_data_view.dart';

class ChoiceBrend extends StatelessWidget {
  const ChoiceBrend({
    super.key,
    required this.onSelect,
    this.asyncItems,
    required this.selected,
  });

  final Future<Brand?> selected;
  final Function(Brand? brand) onSelect;
  final Future<List<Brand>> Function(String)? asyncItems;

  static const _height = 30.0;
  static const _width = 60.0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Brand?>(
        future: selected,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DropdownSearch<Brand>(
              selectedItem: snapshot.data,
              asyncItems: asyncItems,
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
          } else {
            return const SpinKitWave(
              color: Colors.blue,
              size: _height,
            );
          }
        });
  }

  /// -------------------------------------------------------- _buildSnowCurrent
  Widget _buildSnowCurrent(Brand brand, BuildContext context) {
    return brand.image != null
        ? ImageDataView(
            imageData: brand.image,
            height: _height,
            width: _width,
          )
        : Text(
            brand.name.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge,
          );
  }

  /// ---------------------------------------------------- _buildInlinePopupItem
  Widget _buildInlinePopupItem(Brand brand, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ImageDataView(
          imageData: brand.image,
          height: _height,
          width: _width,
        ),
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
