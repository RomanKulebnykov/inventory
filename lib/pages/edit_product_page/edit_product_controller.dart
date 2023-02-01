import 'package:domain_models/domain_models.dart';
import 'package:file_helpers/file_helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class EditProductController extends ChangeNotifier {
  EditProductController({
    required this.onProductSave,
    Product? editProduct,
  }) {
    if (editProduct != null) {
      id = editProduct.id;
      _image = editProduct.image.copyWith();
      title = TextEditingController(text: editProduct.title);
      code = TextEditingController(text: editProduct.code);
      article = TextEditingController(text: editProduct.articles.join(','));
      entryPrice = TextEditingController(text: '${editProduct.entryPrice}');
      sellingPrice = TextEditingController(text: '${editProduct.sellingPrice}');
      description = TextEditingController(text: editProduct.description);
      barCode = TextEditingController(text: editProduct.barCode);
    } else {
      id = const Uuid().v4();
      _image = ImageData();
      title = TextEditingController();
      code = TextEditingController();
      article = TextEditingController();
      entryPrice = TextEditingController(text: '0.0');
      sellingPrice = TextEditingController(text: '0.0');
      description = TextEditingController();
      barCode = TextEditingController();
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final String id;
  late final TextEditingController title;
  late final TextEditingController code;
  late final TextEditingController article;
  late final TextEditingController entryPrice;
  late final TextEditingController sellingPrice;
  late final TextEditingController description;
  late final TextEditingController barCode;

  final void Function(Product product) onProductSave;

  late ImageData _image;
  ImageData get image => _image.copyWith();

  void updateProductImage(PlatformFile newImage) async {
    _image =
        _image.addReplaceImage(name: newImage.name, bytes: newImage.bytes!);
    notifyListeners();
  }

  void deleteProductImage() async {
    _image = _image.markNeedRemove();
    notifyListeners();
  }

  void saveProduct() {
    final savedProduct = Product(
      id: id,
      image: _image,
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
