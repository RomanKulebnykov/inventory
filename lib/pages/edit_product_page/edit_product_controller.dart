import 'package:domain_models/domain_models.dart';
import 'package:file_helpers/file_helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:products_manager/products_manager.dart';
import 'package:uuid/uuid.dart';

class EditProductController extends ChangeNotifier {
  EditProductController({
    required this.manager,
    // required this.onProductSave,
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

      _brand = editProduct.brend;
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

      _brand = null;
    }
  }
  final ProductsManager manager;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void _showMessage(String text) {
    ScaffoldMessenger.of(scaffoldKey.currentState!.context).showSnackBar(
      SnackBar(content: Text(text), showCloseIcon: true),
    );
  }

  late final String id;
  late final TextEditingController title;
  late final TextEditingController code;
  late final TextEditingController article;
  late final TextEditingController entryPrice;
  late final TextEditingController sellingPrice;
  late final TextEditingController description;
  late final TextEditingController barCode;

  /// ------------------------------------------------------------ Product Brand
  late Brand? _brand;
  Brand? get brand => _brand?.copyWith();

  void onBrandChange(Brand? selectedBrand) {
    print('fff');
    _brand = selectedBrand;
  }

  List<Brand> getAvailableBrends() {
    return [
      Brand(id: 'id1', name: '1', description: 'description1'),
      Brand(id: 'id2', name: '2', description: 'description2'),
    ];
  }

  /// ------------------------------------------------------------ Product Image
  late final ImageData _image;
  ImageData get image => _image.copyWith();

  void updateProductImage(PlatformFile newImage) async {
    _image.replace(newImage.name, newImage.bytes!);
    notifyListeners();
  }

  void deleteProductImage() async {
    _image.remove();
    notifyListeners();
  }

  /// -------------------------------------------------------------- saveProduct
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // final void Function(Product product) onProductSave;
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
      brend: _brand,
      lastUpdate: DateTime.now().toUtc(),
    );
    _showMessage('Add product: ${savedProduct.title}');
    // manager.saveProduct(savedProduct);
    // onProductSave(savedProduct);
  }

  /// ------------------------------------------------------------------ dispose
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
