import 'package:shared_kernel/shared_kernel.dart';

class Brand extends IAggregateRoot {
  final String name;
  final String description;
  final ImageData image;
  Brand(
    super.id, {
    required this.name,
    required this.description,
    required this.image,
  });

  @override
  List<Object?> get props => [super.props, name, description, image];

  Brand copyWith({
    String? id,
    String? name,
    String? description,
    ImageData? image,
  }) {
    return Brand(
      id ?? super.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }
}
