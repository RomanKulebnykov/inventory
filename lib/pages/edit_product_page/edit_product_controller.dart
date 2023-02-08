import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';
import 'package:uuid/uuid.dart';

class EditProductController extends ChangeNotifier {
  EditProductController({
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

      // _brand = editProduct.brend;
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

  void setBrand(Brand? selectedBrand) {
    _brand = selectedBrand;
    notifyListeners();
  }

  List<Brand> getAvailableBrends() {
    return [
      Brand(
        'id1',
        name: '1',
        description: 'description1',
        image: ImageData(),
      ),
      Brand(
        'id2',
        name: '2',
        description: 'description2',
        image: ImageData(),
      ),
    ];
  }

  /// ------------------------------------------------------------ Product Image
  late final ImageData _image;
  ImageData get image => _image.copyWith();

  void setProductImage(PlatformFile newImage) async {
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
      id,
      image: _image,
      title: title.text,
      code: code.text,
      articles: article.text.replaceAll(' ', '').split(','),
      entryPrice: double.parse(entryPrice.text),
      sellingPrice: double.parse(sellingPrice.text),
      description: description.text,
      barCode: barCode.text,
      // brend: _brand,
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
