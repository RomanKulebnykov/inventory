import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:inventory/pages/edit_brand/edit_brand_dialog.dart';
import 'package:inventory/pages/edit_brand/edit_brand_vm.dart';
import 'package:inventory/pages/edit_product_page/edit_product_vm.dart';
import 'package:inventory/widgets/app_text_form_field.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import '../../utils/theme.dart';
import '../../widgets/choice_brend_widget/choice_brend.dart';
import '../../utils/formatters.dart';
import '../../widgets/widgets.dart';
import '../../widgets/image_data_edit_view.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProductVM>(
      builder: (context, viewModel, child) {
        return Scaffold(
          key: viewModel.scaffoldKey,
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ///TODO: TEST
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: const Text('Test'),
                    // ),

                    /// --------------------------------------------------- HEAD
                    Row(
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            controller: viewModel.title,
                            label: 'ProductName',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            IconButton(
                              color: AppTheme.addElementColor,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ChangeNotifierProvider<EditBrandVM>(
                                      create: (context) => EditBrandVM(
                                        repository: Di.getIt(),
                                        // newBrendDidAdd: controller.setBrand,
                                      ),
                                      child: const EditBrandDialog(),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.add_circle),
                            ),
                            SizedBox(
                              width: 150,
                              child: ChoiceBrend(
                                asyncItems: viewModel.getAvailableBrends,
                                selected: viewModel.brand,
                                onSelect: viewModel.setBrand,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// --------------------------------------------------- BODY
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageDataEditView(
                          image: viewModel.image,
                          onImageChange: viewModel.setProductImage,
                          onImageRemoved: viewModel.deleteProductImage,
                        ),
                        const Spacer(flex: 3),

                        /// --------------------------------------- LEFT SECTION
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 200,
                              maxWidth: 300,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppTextFormField(
                                  controller: viewModel.code,
                                  label: 'Code',
                                ),
                                const SizedBox(height: 16),
                                AppTextFormField(
                                  label: 'Articles',
                                  controller: viewModel.article,
                                ),
                                const SizedBox(height: 16),
                                AppTextFormField(
                                  controller: viewModel.barCode,
                                  label: 'Bar Code',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),

                        /// -------------------------------------- RIGHT SECTION
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 150,
                              maxWidth: 200,
                            ),
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                AppTextFormField(
                                  controller: viewModel.entryPrice,
                                  label: 'Entry price',
                                  inputFormatters: [
                                    TextInputCurrencyFormatter()
                                  ],
                                ),
                                const SizedBox(height: 16),
                                AppTextFormField(
                                  controller: viewModel.sellingPrice,
                                  label: 'Selling price',
                                  inputFormatters: [
                                    CurrencyTextInputFormatter(symbol: '')
                                    // TextInputCurrencyFormatter()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// ------------------------------------------------- BOTTOM
                    TextFormField(
                      minLines: 3,
                      maxLines: 3,
                      controller: viewModel.description,
                      decoration: InputDecoration(
                        label: const Text('Description'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Spacer(),
                    SubmitControlsRow(
                      submitStr: 'Add Product',
                      onSubmit: viewModel.saveProduct,
                      onCancel: viewModel.editCancelled,
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
