import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';
import 'package:uuid/uuid.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit({
    required ProductsRepository productsRepository,
    required BrandsRepository brandsRepository,
    required void Function(Product product) onSave,
    Product? editProduct,
  })  : _brandsRepository = brandsRepository,
        _productsRepository = productsRepository,
        super(_initialize(editProduct));

  final ProductsRepository _productsRepository;
  final BrandsRepository _brandsRepository;

  /// -------------------------------------------------------------- _initialize
  static EditProductState _initialize(Product? editProduct) {
    return editProduct == null
        ? EditProductState(
            onSave: (product) {},
            id: const Uuid().v4(),
            title: TextEditingController(),
            code: TextEditingController(),
            article: TextEditingController(),
            entryPrice: TextEditingController(text: '0.0'),
            sellingPrice: TextEditingController(text: '0.0'),
            description: TextEditingController(),
            barCode: TextEditingController(),
          )
        : EditProductState(
            onSave: (Product product) {},
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
          );
  }
}
