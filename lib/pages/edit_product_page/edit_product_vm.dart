import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';
import 'package:uuid/uuid.dart';

class EditProductVM extends ChangeNotifier {
  EditProductVM({
    required this.onProductSave,
    required ProductsRepository productsRepository,
    required BrandsRepository brandsRepository,
    Product? editProduct,
  })  : _productsRepository = productsRepository,
        _brandsRepository = brandsRepository {
    if (editProduct != null) {
      id = editProduct.id;
      _editImageData = EditImageData.fromImageData(editProduct.image);
      title = TextEditingController(text: editProduct.title);
      code = TextEditingController(text: editProduct.code);
      article = TextEditingController(text: editProduct.articles.join(','));
      entryPrice = TextEditingController(text: '${editProduct.entryPrice}');
      sellingPrice = TextEditingController(text: '${editProduct.sellingPrice}');
      description = TextEditingController(text: editProduct.description);
      barCode = TextEditingController(text: editProduct.barCode);

      _brandId = editProduct.brandId;
    } else {
      id = const Uuid().v4();
      _editImageData = EditImageData.fromImageData(null);
      title = TextEditingController();
      code = TextEditingController();
      article = TextEditingController();
      entryPrice = TextEditingController(text: '0.0');
      sellingPrice = TextEditingController(text: '0.0');
      description = TextEditingController();
      barCode = TextEditingController();

      _brandId = null;
    }
  }

  final ProductsRepository _productsRepository;
  final BrandsRepository _brandsRepository;

  final void Function(Product product) onProductSave;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late final String id;
  late final TextEditingController title;
  late final TextEditingController code;
  late final TextEditingController article;
  late final TextEditingController entryPrice;
  late final TextEditingController sellingPrice;
  late final TextEditingController description;
  late final TextEditingController barCode;

  /// ------------------------------------------------------------ Product Brand
  String? _brandId;

  void setBrand(Brand? selectedBrand) {
    _brandId = selectedBrand?.id;
    notifyListeners();
  }

  Future<Brand?> get brand => _brandId != null
      ? _brandsRepository.getById(_brandId!)
      : Future.value(null);

  Future<List<Brand>> getAvailableBrends(String searchText) async {
    return await _brandsRepository.list(BrandFilter());
  }

  /// ------------------------------------------------------------ Product Image
  late final EditImageData _editImageData;
  ImageData? get image => _editImageData.imageData;
  void setProductImage(PlatformFile file) async {
    if (file.bytes != null) {
      _editImageData.replace(file.bytes!);
      notifyListeners();
    }
  }

  void deleteProductImage() async {
    _editImageData.remove();
    notifyListeners();
  }

  Future<void> saveProduct() async {
    final savedProduct = Product(
      id,
      image: _editImageData.imageData,
      title: title.text,
      code: code.text,
      articles: article.text.replaceAll(' ', '').split(','),
      entryPrice: double.parse(entryPrice.text),
      sellingPrice: double.parse(sellingPrice.text),
      description: description.text,
      barCode: barCode.text,
      brandId: _brandId,
      lastUpdate: DateTime.now().toUtc(),
    );
    await _productsRepository.save(
      savedProduct,
      updateParam: _editImageData.updateParam,
    );

    _showMessage('Add product: ${savedProduct.title}');
  }

  /// ----------------------------------------------------------- Private Method
  void _showMessage(String text) {
    ScaffoldMessenger.of(scaffoldKey.currentState!.context).showSnackBar(
      SnackBar(
        content: Text(text),
        showCloseIcon: true,
        closeIconColor: Colors.red,
      ),
    );
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
