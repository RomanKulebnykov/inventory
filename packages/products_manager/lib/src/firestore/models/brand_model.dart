import 'package:domain_models/domain_models.dart';

class BrandModel extends IBrand {
  BrandModel({
    required super.id,
    required super.name,
    required super.description,
    required super.logoImagePath,
  });
}
