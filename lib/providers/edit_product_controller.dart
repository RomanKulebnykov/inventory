import 'package:flutter/cupertino.dart';
import 'package:products_manager/products_manager.dart';
import 'package:uuid/uuid.dart';

class EditProductController extends ChangeNotifier {
  EditProductController({
    required this.onProductImageSave,
    required this.onProductSave,
    Product? editProduct,
  }) {
    if (editProduct != null) {
      id = editProduct.id;
      imagePath = editProduct.imagePath;
      title = TextEditingController(text: editProduct.title);
      code = TextEditingController(text: editProduct.code);
      article = TextEditingController(text: editProduct.articles.join(','));
      entryPrice = TextEditingController(text: '${editProduct.entryPrice}');
      sellingPrice = TextEditingController(text: '${editProduct.sellingPrice}');
      description = TextEditingController(text: editProduct.description);
      barCode = TextEditingController(text: editProduct.barCode);
    } else {
      id = const Uuid().v4();
      imagePath = null;
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
  final void Function(String image) onProductImageSave;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final String id;
  String? imagePath;
  late final TextEditingController title;
  late final TextEditingController code;
  late final TextEditingController article;
  late final TextEditingController entryPrice;
  late final TextEditingController sellingPrice;
  late final TextEditingController description;
  late final TextEditingController barCode;

  void saveProduct() {
    final savedProduct = Product(
      id: id,
      imagePath: imagePath,
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
