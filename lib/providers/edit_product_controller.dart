import 'dart:typed_data';

import 'package:domain_models/domain_models.dart';
import 'package:file_helpers/file_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class EditProductController extends ChangeNotifier {
  EditProductController({
    required this.onProductImageUpdate,
    required this.onProductSave,
    Product? editProduct,
  }) {
    if (editProduct != null) {
      id = editProduct.id;
      image = editProduct.image;
      title = TextEditingController(text: editProduct.title);
      code = TextEditingController(text: editProduct.code);
      article = TextEditingController(text: editProduct.articles.join(','));
      entryPrice = TextEditingController(text: '${editProduct.entryPrice}');
      sellingPrice = TextEditingController(text: '${editProduct.sellingPrice}');
      description = TextEditingController(text: editProduct.description);
      barCode = TextEditingController(text: editProduct.barCode);
    } else {
      id = const Uuid().v4();
      image = null;
      title = TextEditingController();
      code = TextEditingController();
      article = TextEditingController();
      entryPrice = TextEditingController(text: '0.0');
      sellingPrice = TextEditingController(text: '0.0');
      description = TextEditingController();
      barCode = TextEditingController();
    }
  }

  final void Function(Product product) onProductSave;
  final String Function(String name, Uint8List bytes) onProductImageUpdate;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final String id;
  late final TextEditingController title;
  late final TextEditingController code;
  late final TextEditingController article;
  late final TextEditingController entryPrice;
  late final TextEditingController sellingPrice;
  late final TextEditingController description;
  late final TextEditingController barCode;

  bool isImageBeenUpdate = false;
  ImageData? image;

  void saveProduct() {
    if (isImageBeenUpdate) {}
    final savedProduct = Product(
      id: id,
      image: image,
      title: title.text,
      code: code.text,
      articles: article.text.replaceAll(' ', '').split(','),
      entryPrice: double.parse(entryPrice.text),
      sellingPrice: double.parse(sellingPrice.text),
      description: description.text,
      barCode: barCode.text,
      lastUpdate: DateTime.now().toUtc(),
    );
    onProductSave(savedProduct);
  }

  @override
  void dispose() {
    title.dispose();
    code.dispose();
    article.dispose();
    entryPrice.dispose();
    sellingPrice.dispose();
    description.dispose();
    barCode.dispose();
    super.dispose();
  }
}
