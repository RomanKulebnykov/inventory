import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/pages/edit_brand/edit_brand_cubit.dart';
import 'package:inventory/widgets/submit_controls_row.dart';

import '../../widgets/image_data_edit_view.dart';

class EditBrandDialog extends StatelessWidget {
  const EditBrandDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<EditBrandCubit, EditBrandState>(
            builder: (context, state) {
              return Form(
                child: Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 150,
                      child: ImageDataEditView(
                        image: state.image,
                        onImageChange: EditBrandCubit.of(context).updateImage,
                        onImageRemoved: EditBrandCubit.of(context).deleteImage,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Builder(builder: (context) {
                      return BlocSelector<EditBrandCubit, EditBrandState,
                          String>(
                        selector: (state) {
                          return state.name.text;
                        },
                        builder: (context, state) {
                          return TextFormField(
                            controller: state,
                            decoration: InputDecoration(
                              label: const Text('Name'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: state.description,
                      minLines: 3,
                      maxLines: 3,
                      decoration: InputDecoration(
                        label: const Text('Description'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SubmitControlsRow(
            submitStr: 'Save Brend',
            onSubmit: () {
              EditBrandCubit.of(context).saveBrend();
            },
            onCancel: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
