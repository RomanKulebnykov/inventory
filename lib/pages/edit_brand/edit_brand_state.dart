part of 'edit_brand_cubit.dart';

/// ------------------------------------------------------------- EditBrandState
class EditBrandState extends Equatable {
  final String id;
  final TextEditingController name;
  final TextEditingController description;
  final ImageData image;

  final String? snackBarMessage;

  const EditBrandState({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    this.snackBarMessage,
  });

  void close() {
    name.dispose();
    description.dispose();
  }

  @override
  List<Object?> get props => [id, name, description, image, snackBarMessage];

  EditBrandState copyWith({
    String? id,
    ImageData? image,
    String? snackBarMessage,
  }) {
    return EditBrandState(
      id: id ?? this.id,
      name: name,
      description: description,
      image: image ?? this.image,
      snackBarMessage: snackBarMessage ?? this.snackBarMessage,
    );
  }
}
