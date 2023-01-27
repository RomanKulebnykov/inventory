// import 'package:dropdown_search/dropdown_search.dart';
//
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// import '../../models/brend.dart';
// import 'brend_logo_image.dart';
//
// class ChoiceBrendWidget extends StatefulWidget {
//   const ChoiceBrendWidget({
//     Key? key,
//     required this.onChange,
//     this.initialSelected,
//   }) : super(key: key);
//
//   final void Function(Brend? brend) onChange;
//   final Brend? initialSelected;
//
//   @override
//   State<ChoiceBrendWidget> createState() => _ChoiceBrendWidgetState();
// }
//
// class _ChoiceBrendWidgetState extends State<ChoiceBrendWidget> {
//   @override
//   void initState() {
//     super.initState();
//     selected = widget.initialSelected;
//   }
//
//   Brend? selected;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         IconButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: const Text("Добавить нового производителя"),
//                   content: AddNewBrendWidget(
//                     onAdd: (newBrend) {
//                       setState(() {
//                         selected = newBrend;
//                         widget.onChange(newBrend);
//                       });
//                     },
//                   ),
//                 );
//               },
//             );
//           },
//           icon: const FaIcon(FontAwesomeIcons.circlePlus),
//           color: Colors.green,
//         ),
//         // const SizedBox(width: 2),
//         Expanded(
//           child: DropdownSearch<Brend>(
//             asyncItems: (text) => ProductController().getBrends(),
//             onChanged: (val) {
//               selected = val;
//               widget.onChange(val);
//             },
//             selectedItem: selected,
//             compareFn: (p1, p2) => p1.name == p2.name,
//             itemAsString: (val) => val.name,
//             dropdownButtonProps: const IconButtonProps(
//                 icon: Icon(
//               Icons.expand_circle_down_outlined,
//               size: 18,
//             )),
//             // dropdownBuilder: (context, item) {
//             //   if (item?.imageURL != null) {
//             //     return BrendLogoImage(
//             //       height: 15,
//             //       width: 25,
//             //       url: item!.imageURL,
//             //     );
//             //   }
//             //   if (item != null) {
//             //     return Text(item.name);
//             //   }
//             //   return Container();
//             // },
//             popupProps: PopupProps.menu(
//               itemBuilder: (context, item, isSelected) {
//                 Color itemColor = isSelected ? Colors.blue : Colors.black;
//                 FontWeight weight =
//                     isSelected ? FontWeight.bold : FontWeight.normal;
//
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         item.name,
//                         style: TextStyle(
//                           color: itemColor,
//                           fontWeight: weight,
//                           fontSize: 16,
//                         ),
//                       ),
//                       BrendLogoImage(height: 30, width: 50, url: item.imageURL),
//                     ],
//                   ),
//                 );
//               },
//               showSearchBox: true,
//               showSelectedItems: true,
//               searchFieldProps: const TextFieldProps(
//                 decoration: InputDecoration(
//                   isDense: true,
//                   labelText: "Поиск ",
//                 ),
//               ),
//             ),
//             dropdownSearchDecoration: InputDecoration(
//               label: const Text('Бренд'),
//               isDense: true,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class AddNewBrendWidget extends StatefulWidget {
//   const AddNewBrendWidget({
//     Key? key,
//     this.onAdd,
//   }) : super(key: key);
//
//   final void Function(Brend newBrand)? onAdd;
//   @override
//   State<AddNewBrendWidget> createState() => _AddNewBrendWidgetState();
// }
//
// class _AddNewBrendWidgetState extends State<AddNewBrendWidget> {
//   @override
//   void initState() {
//     super.initState();
//     _name = TextEditingController();
//     _description = TextEditingController();
//     _formKey = GlobalKey();
//   }
//
//   late final TextEditingController _name;
//   late final TextEditingController _description;
//   String? _logoPath;
//   PlatformFile? _choicesLogo;
//
//   bool _isNameContains = false;
//   late final GlobalKey<FormState> _formKey;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 270,
//       width: 320,
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Form(
//         autovalidateMode: AutovalidateMode.always,
//         key: _formKey,
//         child: Column(
//           children: [
//             Column(
//               children: [
//                 TextFormField(
//                   controller: _name,
//                   labelText: 'Название',
//                   maxLines: 1,
//                   onTap: () => _isNameContains = false,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return "Поле не должно быть пустым";
//                     }
//                     if (value.length < 2) {
//                       return "Имя не может быть короче 2х символов";
//                     }
//                     if (_isNameContains) {
//                       return "Бренд с таким названием уже добавлен";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 TextFormField(
//                   isDense: false,
//                   controller: _description,
//                   labelText: 'Описание',
//                   minLines: 4,
//                   maxLines: 4,
//                   maxLength: 200,
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   // crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     BrendLogoImage(bytes: _choicesLogo?.bytes, url: _logoPath),
//                     // const Spacer(),
//                     const SizedBox(
//                       width: 70,
//                     ),
//                     AppButton(
//                       text: "Изображение",
//                       type: AppButtonType.info,
//                       onPressed: () async {
//                         FilePickerResult? pickResult =
//                             await FilePicker.platform.pickFiles(
//                           type: FileType.image,
//                         );
//                         if (pickResult != null) {
//                           setState(() => _choicesLogo = pickResult.files.first);
//                         }
//                       },
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 AppButton(
//                   text: "Добавить",
//                   type: AppButtonType.accept,
//                   onPressed: () async {
//                     if (_name.text.isNotEmpty) {
//                       _isNameContains =
//                           await ProductController().isContainsBrend(_name.text);
//                     }
//                     if (_formKey.currentState!.validate()) {
//                       String? fileUrl;
//                       if (_choicesLogo != null) {
//                         fileUrl = await FStorageController.saveImage(
//                           name: _name.text,
//                           file: _choicesLogo!,
//                           type: StorageType.brendLogo,
//                         );
//                       }
//                       Brend newBrend = Brend(
//                         name: _name.text,
//                         description: _description.text,
//                         logoPath: fileUrl,
//                       );
//
//                       await ProductController().addBrend(newBrend);
//                       if (widget.onAdd != null) widget.onAdd!(newBrend);
//                       if (!mounted) return;
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 AppButton(
//                   text: "Отмена",
//                   type: AppButtonType.reject,
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
