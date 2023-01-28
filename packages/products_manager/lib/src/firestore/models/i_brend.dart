import 'package:equatable/equatable.dart';

class IBrand extends Equatable {
  final String id;
  final String name;
  final String description;
  final String? logoImagePath;

  const IBrand({
    required this.id,
    required this.name,
    required this.description,
    required this.logoImagePath,
  });

  @override
  List<Object?> get props => [id, name, description, logoImagePath];
}
