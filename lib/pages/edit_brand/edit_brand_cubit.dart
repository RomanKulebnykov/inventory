import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';
import 'package:uuid/uuid.dart';

part 'edit_brand_state.dart';

class EditBrandCubit extends Cubit<EditBrandState> {
  /// --------------------------------------------------- Helper Instance Getter
  factory EditBrandCubit.of(BuildContext context) {
    return context.read<EditBrandCubit>();
  }
  EditBrandCubit({
    required this.repository,
    Brand? editBrand,
    this.newBrendDidAdd,
  }) : super(
          editBrand == null
              ? EditBrandState(
                  id: const Uuid().v4(),
                  name: TextEditingController(),
                  description: TextEditingController(),
                  editImageData: EditImageData.fromImageData(null),
                )
              : EditBrandState(
                  id: editBrand.id,
                  name: TextEditingController(text: editBrand.name),
                  description:
                      TextEditingController(text: editBrand.description),
                  editImageData: EditImageData.fromImageData(editBrand.image),
                ),
        );

  final Function(Brand newBrend)? newBrendDidAdd;

  final BrandsRepository repository;

  void updateImage(PlatformFile newImage) async {
    state.editImageData.replace(newImage.bytes!);
    emit(state.copyWith());
  }

  void deleteImage() async {
    state.editImageData.remove();
    emit(state.copyWith());
  }

  Future<void> saveBrend() async {
    final newBrend = Brand(
      state.id,
      name: state.name.text,
      description: state.description.text,
      image: state.editImageData.imageData,
    );
    final result = await repository.save(
      newBrend,
      imageStatus: state.editImageData.status,
    );

    final String message;
    if (result == true) {
      message = 'OK';
      if (newBrendDidAdd != null) newBrendDidAdd!(newBrend);
    } else {
      message = 'Error';
    }
    emit(state.copyWith(snackBarMessage: message));
  }

  @override
  Future<void> close() {
    state.close();
    return super.close();
  }
}
