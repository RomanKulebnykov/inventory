import 'package:flutter/material.dart';
import 'package:resizable_table/src/head_menu.dart';
import 'package:resizable_table/src/tab_head_row.dart';

import '../resizable_table.dart';

class ResizableTableViewModel extends ChangeNotifier {
  ResizableTableViewModel(this._columns, this._rows, {this.withDivider = true});

  final List<TabHeadCell> _columns;
  final List<TabRow> _rows;
  final bool withDivider;

  int get columnLength => _columns.length;
  int get rowLength => _rows.length;

  Widget get menu => Visibility(
        visible: showControlsElement,
        child: HeadMenu(columns: _columns, onChange: onShowColumnChange),
      );

  List<TabRowView> get rowViews {
    return [
      for (final row in _rows)
        TabRowView(
          hasDivider: true,
          cells: List<TabCellView>.generate(row.cells.length, (index) {
            return TabCellView(
              text: row.cells[index].text,
              width: _columns[index].width,
              isShow: _columns[index].isShow,
            );
          }),
        )
    ];
  }

  TabHeadRowView get headRowView {
    return TabHeadRowView(
      cells: List<TabHeadCellView>.generate(
        columnLength,
        (index) {
          final column = _columns[index];
          return TabHeadCellView(
            text: column.text,
            isEnable: column.isShow,
            onWidthUpdate: (newWidth) => onColumnWidthChange(index, newWidth),
            isSHowDragElement: showControlsElement,
          );
        },
      ),
    );
  }

  void onShowColumnChange(TabHeadCell column, bool value) {
    column.isShow = value;
    notifyListeners();
  }

  void onColumnWidthChange(int index, double width) {
    _columns[index].width = width;
    notifyListeners();
  }

  bool showControlsElement = false;
  void setShowControlElements(bool isShow) {
    showControlsElement = isShow;
    notifyListeners();
  }
}
