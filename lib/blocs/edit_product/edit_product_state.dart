part of 'edit_product_cubit.dart';

abstract class EditProductState extends Equatable {
  EditProductState({required this.onSave});

  final void Function(Product product) onSave;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final String id;
  late final String? imagePath;
  late final String title;
  late final String code;
  late final String article;
  late final String entryPrice;
  late final String sellingPrice;
  late final String description;
  late final String barCode;

  void saveProduct() {
    final savedProduct = Product(
      id: id,
      imagePath: imagePath,
      title: title,
      code: code,
      articles: article.replaceAll(' ', '').split(','),
      entryPrice: double.parse(entryPrice),
      sellingPrice: double.parse(sellingPrice),
      description: description,
      barCode: barCode,
      lastUpdate: DateTime.now().toUtc(),
    );
    onSave(savedProduct);
  }
}

class EditProduct extends EditProductState {
  EditProduct({
    required super.onSave,
    required this.editProduct,
  });

  final Product editProduct;

  @override
  List<Object> get props => [editProduct];
}

class CreateProduct extends EditProductState {
  CreateProduct({required super.onSave});

  @override
  List<Object> get props => [];
}
