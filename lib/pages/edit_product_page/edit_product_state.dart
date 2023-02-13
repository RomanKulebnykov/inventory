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
    this.brand,
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

  final Brand? brand;

  final EditImageData editImageData;
  @override
  List<Object?> get props => [];
}

class EditProductStateLoading extends EditProductState {
  final String loadingMessage;

  EditProductStateLoading(this.loadingMessage);
  @override
  List<Object?> get props => [super.props, loadingMessage];
}

class EditProductStateSuccess extends EditProductState {
  EditProductStateSuccess({
    required this.id,
    required this.title,
    required this.code,
    required this.article,
    required this.entryPrice,
    required this.sellingPrice,
    required this.description,
    required this.barCode,
    this.brand,
    required this.editImageData,
  });

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
  List<Object?> get props => [
        super.props,
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
