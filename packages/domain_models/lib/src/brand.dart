import 'package:file_helpers/file_helpers.dart';

import 'i_brend.dart';

class Brand extends IBrand {
  final ImageData? image;
  Brand({
    required super.id,
    required super.name,
    required super.description,
    this.image,
  });

  @override
  List<Object?> get props => [super.props, image];

  Brand copyWith({
    String? id,
    String? name,
    String? description,
    ImageData? image,
  }) {
    return Brand(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }
}
