part of 'edit_brand_cubit.dart';

/// ------------------------------------------------------------- EditBrandState
class EditBrandState extends Equatable {
  final String id;
  final TextEditingController name;
  final TextEditingController description;
  final ImageData? _image;

  final UpdateImageParam updateImageParam;

  ImageData? get image => _image;

  final String? snackBarMessage;

  EditBrandState({
    required this.id,
    required this.name,
    required this.description,
    ImageData? image,
    UpdateImageParam? updateImageParam,
    this.snackBarMessage,
  })  : _image = image,
        updateImageParam = updateImageParam ?? UpdateImageParamNone();

  void close() {
    name.dispose();
    description.dispose();
  }

  @override
  List<Object?> get props => [id, name, description, image, snackBarMessage];

  EditBrandState copyWith({
    String? id,
    ImageData? image,
    UpdateImageParam? updateImageParam,
    String? snackBarMessage,
  }) {
    return EditBrandState(
      id: id ?? this.id,
      name: name,
      description: description,
      image: image ?? this.image,
      updateImageParam: updateImageParam ?? this.updateImageParam,
      snackBarMessage: snackBarMessage,
    );
  }
}
