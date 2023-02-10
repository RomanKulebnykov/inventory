part of 'edit_brand_cubit.dart';

/// ------------------------------------------------------------- EditBrandState
class EditBrandState extends Equatable {
  final String id;
  final TextEditingController name;
  final TextEditingController description;
  final EditImageData editImageData;

  final String? snackBarMessage;

  const EditBrandState({
    required this.id,
    required this.name,
    required this.description,
    required this.editImageData,
    this.snackBarMessage,
  });

  void close() {
    name.dispose();
    description.dispose();
  }

  EditBrandState copyWith({
    String? snackBarMessage,
  }) {
    return EditBrandState(
      id: id,
      name: name,
      description: description,
      editImageData: editImageData,
      snackBarMessage: snackBarMessage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        editImageData,
        snackBarMessage,
      ];
}
