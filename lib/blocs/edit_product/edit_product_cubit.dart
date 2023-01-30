import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:products_manager/products_manager.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit({
    required void Function(Product product) onSave,
    Product? editProduct,
  }) : super(
          editProduct == null
              ? CreateProduct(onSave: onSave)
              : EditProduct(editProduct: editProduct, onSave: onSave),
        );
}
