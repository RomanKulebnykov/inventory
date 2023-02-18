import 'package:flutter/material.dart';
import 'package:resizable_table/resizable_table.dart';

class HeadMenu extends StatelessWidget {
  const HeadMenu({
    Key? key,
    required this.columns,
    required this.onChange,
  }) : super(key: key);

  final List<TabHeadCell> columns;
  final void Function(TabHeadCell column, bool value) onChange;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: const Icon(Icons.settings, color: Colors.blue),
      itemBuilder: (BuildContext context) {
        return columns.map<PopupMenuItem>(
          (column) {
            bool isChecked = column.isShow;
            return PopupMenuItem(
              padding: const EdgeInsets.all(0),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return CheckboxListTile(
                    title: Text(column.text),
                    value: isChecked,
                    onChanged: (val) {
                      onChange(column, val!);
                      setState(() => isChecked = val);
                    },
                  );
                },
              ),
            );
          },
        ).toList();
      },
    );
  }
}
