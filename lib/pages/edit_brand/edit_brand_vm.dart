import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';
import 'package:uuid/uuid.dart';

class EditBrandVM extends ChangeNotifier {
  EditBrandVM({
    required this.repository,
    Brand? editBrand,
    this.newBrendDidAdd,
  }) {
    if (editBrand != null) {
      id = editBrand.id;
      name = TextEditingController(text: editBrand.name);
      description = TextEditingController(text: editBrand.description);
      editImageData = EditImageData.fromImageData(editBrand.image);
    } else {
      id = const Uuid().v4();
      name = TextEditingController();
      description = TextEditingController();
      editImageData = EditImageData.fromImageData(null);
    }
  }

  final BrandsRepository repository;

  final Function(Brand newBrend)? newBrendDidAdd;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late final String id;
  late final TextEditingController name;
  late final TextEditingController description;

  late final EditImageData editImageData;
  ImageData? get imageData => editImageData.imageData;
  void replaceImage(PlatformFile file) {
    if (file.bytes != null) {
      editImageData.replace(file.bytes!);
      notifyListeners();
    }
  }

  void removeImage() {
    editImageData.remove();
    notifyListeners();
  }

  Future<void> saveBrand() async {
    final savedBrend = Brand(
      id,
      name: name.text,
      description: description.text,
      image: editImageData.imageData,
    );

    final result = await repository.save(
      savedBrend,
      updateParam: editImageData.updateParam,
    );
    if (result == true && newBrendDidAdd != null) newBrendDidAdd!(savedBrend);
  }

  Future<void> deleteBrend() async {
    repository.remove(id);
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    super.dispose();
  }
}
