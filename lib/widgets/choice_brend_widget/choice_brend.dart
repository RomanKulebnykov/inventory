import 'package:domain_models/domain_models.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ChoiceBrend extends StatelessWidget {
  const ChoiceBrend({
    super.key,
    required this.brands,
    required this.onSelect,
  });

  final List<Brand> brands;
  final Function(Brand? brand) onSelect;
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Brand>(
      itemAsString: (item) => item.name,
      items: brands,
      onChanged: onSelect,
    );
  }
}
