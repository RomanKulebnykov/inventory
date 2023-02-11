import 'dart:typed_data';

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
                  name: TextEditingController(
                    text: editBrand.name,
                  ),
                  description: TextEditingController(
                    text: editBrand.description,
                  ),
                  editImageData: EditImageData.fromImageData(
                    editBrand.image,
                  ),
                ),
        );

  final Function(Brand newBrend)? newBrendDidAdd;

  final BrandsRepository repository;

  /// -------------------------------------------------------------- updateImage
  void updateImage(PlatformFile newImage) async {
    state.replaceImage(newImage.bytes!);
    emit(state.copyWith());
  }

  /// -------------------------------------------------------------- deleteImage
  void deleteImage() async {
    state.removeImage();
    emit(state.copyWith());
  }

  /// ---------------------------------------------------------------- saveBrend
  Future<void> saveBrend() async {
    final savedBrend = state.getBrandFromState();
    final result = await repository.save(
      savedBrend,
      updateParam: state.editImageData.updateParam,
    );
    if (result == true && newBrendDidAdd != null) newBrendDidAdd!(savedBrend);
    emit(state.copyWith(snackBarMessage: _saveMessage(result)));
  }

  Future<void> deleteBrend() async {
    repository.remove(state.id, removedImage: state.editImageData.imageData);
  }

  String _saveMessage(bool result) {
    if (result == true) {
      return 'OK';
    } else {
      return 'Error';
    }
  }

  @override
  Future<void> close() {
    state.close();
    return super.close();
  }
}
