// import 'package:flutter/material.dart';
//
// class SectionNavigationMenu extends StatefulWidget {
//   const SectionNavigationMenu({
//     Key? key,
//     required this.elements,
//     required this.selected,
//   }) : super(key: key);
//
//   final List<SectionMenuItem> elements;
//   final int selected;
//   @override
//   State<SectionNavigationMenu> createState() => _SectionNavigationMenuState();
// }
//
// class _SectionNavigationMenuState extends State<SectionNavigationMenu> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           for (final element in widget.elements)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4),
//               child: TextButton(
//                 onPressed: element.onPress,
//                 child: Text(element.label),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class SectionMenuItem {
//   final String label;
//   final Function() onPress;
//
//   const SectionMenuItem({
//     required this.label,
//     required this.onPress,
//   });
// }
