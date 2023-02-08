import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/pages/edit_brand/edit_brand_cubit.dart';
import 'package:inventory/pages/edit_brand/edit_brand_dialog.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import '../../utils/theme.dart';
import '../../widgets/choice_brend_widget/choice_brend.dart';
import 'edit_product_controller.dart';
import '../../utils/formatters.dart';
import '../../widgets/widgets.dart';
import '../../widgets/image_data_edit_view.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<EditProductController>(
      builder: (context, controller, child) {
        return Scaffold(
          key: controller.scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///TODO: TEST
                  ElevatedButton(onPressed: () {}, child: const Text('Test')),

                  /// ----------------------------------------------------- HEAD
                  _buildHeadSection(context, controller),
                  const SizedBox(height: 16),

                  /// ----------------------------------------------------- BODY
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageDataEditView(
                        image: controller.image,
                        onImageChange: controller.setProductImage,
                        onImageRemoved: controller.deleteProductImage,
                      ),
                      const Spacer(flex: 3),
                      _buildLeftSection(controller),
                      const Spacer(),
                      _buildRightSection(controller),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// --------------------------------------------------- BOTTOM
                  TextFormField(
                    minLines: 3,
                    maxLines: 3,
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
                    onSubmit: controller.saveProduct,
                    onCancel: () {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// ------------------------------------------------------- _buildRightSection
  Widget _buildRightSection(EditProductController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 150,
          maxWidth: 200,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller.entryPrice,
              decoration: InputDecoration(
                label: const Text('Entry price'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              inputFormatters: [TextInputCurrencyFormatter()],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.sellingPrice,
              decoration: InputDecoration(
                label: const Text('Selling price'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              inputFormatters: [TextInputCurrencyFormatter()],
            ),
          ],
        ),
      ),
    );
  }

  /// -------------------------------------------------------- _buildLeftSection
  Widget _buildLeftSection(EditProductController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 200,
          maxWidth: 300,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller.code,
              decoration: InputDecoration(
                label: const Text('Code'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.article,
              decoration: InputDecoration(
                label: const Text('Articles'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller.barCode,
              decoration: InputDecoration(
                label: const Text('Bar Code'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// -------------------------------------------------------- _buildHeadSection
  Widget _buildHeadSection(
      BuildContext context, EditProductController controller) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller.title,
            decoration: InputDecoration(
              label: const Text('ProductName'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
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
                    return BlocProvider(
                      create: (context) => EditBrandCubit(
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
                brands: controller.getAvailableBrends(),
                onSelect: controller.setBrand,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
