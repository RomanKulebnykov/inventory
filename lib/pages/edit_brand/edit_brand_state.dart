part of 'edit_brand_cubit.dart';

/// ------------------------------------------------------------- EditBrandState
class EditBrandState extends Equatable {
  final String id;
  final TextEditingController name;
  final TextEditingController description;
  final ImageData image;

  const EditBrandState({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  void close() {
    name.dispose();
    description.dispose();
  }

  @override
  List<Object?> get props => [id, name, description, image];

  EditBrandState copyWith({
    String? id,
    TextEditingController? name,
    TextEditingController? description,
    ImageData? image,
  }) {
    return EditBrandState(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }
}
