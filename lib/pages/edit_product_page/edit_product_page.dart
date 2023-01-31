import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:inventory/providers/edit_product_controller.dart';
import 'package:provider/provider.dart';
import 'package:remote_data_storage/remote_data_storage.dart';

import '../../di.dart';
import '../../utils/formatters.dart';
import '../../widgets/widgets.dart';
import 'product_image_editor.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<EditProductController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// ----------------------------------------------------- HEAD
                  _buildHeadSection(controller),
                  const SizedBox(height: 16),

                  /// ----------------------------------------------------- BODY
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImageEditor(
                        onImageChange: (newImage) {
                          final remStorage = RemoteDataStorage(Di.getIt());
                          remStorage.saveFile(
                            filename: newImage.name,
                            extension: newImage.extension!,
                            bytes: newImage.bytes!,
                            type: FileType.productImage,
                          );
                        },
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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

  Widget _buildHeadSection(EditProductController controller) {
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
        const Text('BrendPlaceholder'),
      ],
    );
  }
}
