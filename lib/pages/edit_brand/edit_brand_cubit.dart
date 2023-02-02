import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:file_helpers/file_helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'edit_brand_state.dart';

class EditBrandCubit extends Cubit<EditBrandState> {
  /// --------------------------------------------------- Helper Instance Getter
  factory EditBrandCubit.of(BuildContext context) {
    return context.read<EditBrandCubit>();
  }
  EditBrandCubit({
    Brand? editBrand,
    this.newBrendDidAdd,
  }) : super(
          editBrand == null
              ? EditBrandState(
                  id: const Uuid().v4(),
                  name: TextEditingController(),
                  description: TextEditingController(),
                  image: ImageData(),
                )
              : EditBrandState(
                  id: editBrand.id,
                  name: TextEditingController(text: editBrand.name),
                  description:
                      TextEditingController(text: editBrand.description),
                  image: editBrand.image,
                ),
        );

  final Function(Brand newBrend)? newBrendDidAdd;

  void updateImage(PlatformFile newImage) async {
    final updImage = state.image..replace(newImage.name, newImage.bytes!);
    emit(state.copyWith(image: updImage.copyWith()));
  }

  void deleteImage() async {
    final updImage = state.image..remove();
    emit(state.copyWith(image: updImage.copyWith()));
  }

  Future<void> saveBrend() async {
    final newBrend = Brand(
      id: state.id,
      name: state.name.text,
      description: state.description.text,
      image: state.image,
    );
    if (newBrendDidAdd != null) newBrendDidAdd!(newBrend);
  }

  @override
  Future<void> close() {
    state.close();
    return super.close();
  }
}
