import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';

class BrandModel {
  final String id;
  final String name;
  final String? description;
  final String? logoImagePath;

  BrandModel({
    required this.id,
    required this.name,
    required this.description,
    this.logoImagePath,
  });
}
