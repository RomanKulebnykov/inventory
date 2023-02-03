import 'package:domain_models/domain_models.dart';

class BrandModel extends IBrand {
  final String? logoImagePath;

  BrandModel({
    required super.id,
    required super.name,
    required super.description,
    this.logoImagePath,
  });

  @override
  List<Object?> get props => [super.props, logoImagePath];
}
