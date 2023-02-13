import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';
import 'package:uuid/uuid.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit({
    required ProductsRepository productsRepository,
    required BrandsRepository brandsRepository,
    required this.onSave,
    Product? editProduct,
  })  : _brandsRepository = brandsRepository,
        _productsRepository = productsRepository,
        super(_initialize(editProduct));

  factory EditProductCubit.of(BuildContext context) {
    return context.read<EditProductCubit>();
  }

  final ProductsRepository _productsRepository;
  final BrandsRepository _brandsRepository;

  final void Function(Product product) onSave;

  void setBrand(Brand? selectedBrand) {}

  Future<List<Brand>> getAvailableBrends() async {
    return await _brandsRepository.list(BrandFilter());
  }

  Future<void> saveProduct() async {}

  /// -------------------------------------------------------------- _initialize
  static EditProductStateSuccess _initialize(Product? editProduct) {
    return editProduct == null
        ? EditProductStateSuccess(
            id: const Uuid().v4(),
            title: TextEditingController(),
            code: TextEditingController(),
            article: TextEditingController(),
            entryPrice: TextEditingController(text: '0.0'),
            sellingPrice: TextEditingController(text: '0.0'),
            description: TextEditingController(),
            barCode: TextEditingController(),
            editImageData: EditImageData.fromImageData(null),
          )
        : EditProductStateSuccess(
            id: editProduct.id,
            title: TextEditingController(
              text: editProduct.title,
            ),
            code: TextEditingController(
              text: editProduct.code,
            ),
            article: TextEditingController(
              text: editProduct.articles.join(','),
            ),
            entryPrice: TextEditingController(
              text: '${editProduct.entryPrice}',
            ),
            sellingPrice: TextEditingController(
              text: '${editProduct.sellingPrice}',
            ),
            description: TextEditingController(
              text: editProduct.description,
            ),
            barCode: TextEditingController(
              text: editProduct.barCode,
            ),
            editImageData: EditImageData.fromImageData(editProduct.image),
          );
  }
}
