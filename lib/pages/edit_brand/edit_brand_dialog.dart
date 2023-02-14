import 'package:flutter/material.dart';
import 'package:inventory/pages/edit_brand/edit_brand_cubit.dart';
import 'package:inventory/pages/edit_brand/edit_brand_vm.dart';
import 'package:inventory/widgets/submit_controls_row.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_text_form_field.dart';
import '../../widgets/image_data_edit_view.dart';

class EditBrandDialog extends StatelessWidget {
  const EditBrandDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<EditBrandVM>(
            builder: (context, viewModel, child) {
              return Form(
                child: Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 150,
                      child: ImageDataEditView(
                        image: viewModel.imageData,
                        onImageChange: viewModel.replaceImage,
                        onImageRemoved: viewModel.removeImage,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      controller: viewModel.name,
                      label: 'Name',
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: viewModel.description,
                      minLines: 3,
                      maxLines: 3,
                      decoration: InputDecoration(
                        label: const Text('Description'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SubmitControlsRow(
                        submitStr: 'Save Brend',
                        onSubmit: () {
                          viewModel.saveBrand();
                        },
                        onCancel: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
