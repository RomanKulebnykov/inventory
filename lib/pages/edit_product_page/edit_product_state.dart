part of 'edit_product_cubit.dart';

class EditProductState extends Equatable {
  EditProductState({
    required this.onSave,
    required this.id,
    required this.title,
    required this.code,
    required this.article,
    required this.entryPrice,
    required this.sellingPrice,
    required this.description,
    required this.barCode,
  });

  final void Function(Product product) onSave;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final String id;
  final TextEditingController title;
  final TextEditingController code;
  final TextEditingController article;
  final TextEditingController entryPrice;
  final TextEditingController sellingPrice;
  final TextEditingController description;
  final TextEditingController barCode;

  late final Brand? _brand;
  Brand? get brand => _brand?.copyWith();

  void setBrand(Brand? selectedBrand) {
    _brand = selectedBrand;
  }

  late final ImageData _imageData;

  Product getProductFromState() {
    return Product(
      id,
      image: _imageData,
      title: title.text,
      code: code.text,
      articles: article.text.replaceAll(' ', '').split(','),
      entryPrice: double.parse(entryPrice.text),
      sellingPrice: double.parse(sellingPrice.text),
      description: description.text,
      barCode: barCode.text,
      // brend: _brand,
      brandId: _brand?.id,
      lastUpdate: DateTime.now().toUtc(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        code,
        article,
        entryPrice,
        sellingPrice,
        description,
        barCode,
      ];
}
