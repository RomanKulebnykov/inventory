import 'package:flutter/cupertino.dart';
import 'package:inventory/models/product_model.dart';
import 'package:uuid/uuid.dart';

class EditProductController extends ChangeNotifier {
  EditProductController({
    Product? editProduct,
  }) {
    if (editProduct != null) {
      id = editProduct.id;
      imageUrl = editProduct.imageUrl;
      title = TextEditingController(text: editProduct.title);
      code = TextEditingController(text: editProduct.code);
      title = TextEditingController(text: editProduct.article.join(','));
      entryPrice = TextEditingController(text: '${editProduct.entryPrice}');
      sellingPrice = TextEditingController(text: '${editProduct.sellingPrice}');
      description = TextEditingController(text: editProduct.description);
      barCode = TextEditingController(text: editProduct.barCode);
    } else {
      id = const Uuid().v4();
      imageUrl = null;
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
  String? imageUrl;
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
      imageUrl: imageUrl,
      title: title.text,
      code: code.text,
      article: article.text.replaceAll(' ', '').split(','),
      entryPrice: double.parse(entryPrice.text),
      sellingPrice: double.parse(sellingPrice.text),
      description: description.text,
      barCode: barCode.text,
    );
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
