part of 'edit_product_cubit.dart';

abstract class EditProductState extends Equatable {
  EditProductState({
    required this.id,
    required this.title,
    required this.code,
    required this.article,
    required this.entryPrice,
    required this.sellingPrice,
    required this.description,
    required this.barCode,
    this.brandId,
    required this.editImageData,
  });
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final String id;
  final TextEditingController title;
  final TextEditingController code;
  final TextEditingController article;
  final TextEditingController entryPrice;
  final TextEditingController sellingPrice;
  final TextEditingController description;
  final TextEditingController barCode;

  final String? brandId;
  final EditImageData editImageData;
  @override
  List<Object?> get props => [];
}

class EditProductStateLoading extends EditProductState {
  final String loadingMessage;

  EditProductStateLoading(
    this.loadingMessage, {
    required super.id,
    required super.title,
    required super.code,
    required super.article,
    required super.entryPrice,
    required super.sellingPrice,
    required super.description,
    required super.barCode,
    required super.editImageData,
  });

  @override
  List<Object?> get props => [super.props, loadingMessage];
}

class EditProductStateSuccess extends EditProductState {
  EditProductStateSuccess({
    required super.id,
    required super.title,
    required super.code,
    required super.article,
    required super.entryPrice,
    required super.sellingPrice,
    required super.description,
    required super.barCode,
    required super.editImageData,
    this.brand,
  });

  final Brand? brand;
  ImageData? get imageData => editImageData.imageData;

  Product getProductFromState() {
    return Product(
      id,
      image: editImageData.imageData,
      title: title.text,
      code: code.text,
      articles: article.text.replaceAll(' ', '').split(','),
      entryPrice: double.parse(entryPrice.text),
      sellingPrice: double.parse(sellingPrice.text),
      description: description.text,
      barCode: barCode.text,
      // brend: _brand,
      brandId: brand?.id,
      lastUpdate: DateTime.now().toUtc(),
    );
  }

  @override
  List<Object?> get props => [super.props, brand];
}
