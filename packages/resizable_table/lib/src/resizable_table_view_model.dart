import 'package:flutter/material.dart';
import 'package:resizable_table/src/head_menu.dart';
import 'package:resizable_table/src/tab_head_row.dart';

import '../resizable_table.dart';

class ResizableTableViewModel extends ChangeNotifier {
  ResizableTableViewModel(
    this._headCells,
    this._rows, {
    this.persistance,
    this.withDivider = true,
  }) {
    initSizes();
  }

  Future<void> initSizes() async {
    for (var headCell in _headCells) {
      if (headCell.fixedWidth != null) continue;
      final state = await persistance?.loadState(name: headCell.idLabel);
      if (state != null) {
        headCell.isShow = state.isShow;
        headCell.width = state.width;
      }
    }
    notifyListeners();
  }

  final List<TabHeadCell> _headCells;
  final List<TabRow> _rows;
  final bool withDivider;
  final ResizableTablePersistance? persistance;

  int get columnLength => _headCells.length;
  int get rowLength => _rows.length;

  Widget get menu => Visibility(
        visible: showControlsElement,
        child: HeadMenu(columns: _headCells, onChange: onShowColumnChange),
      );

  List<TabRowView> get rowViews => [
        for (final row in _rows)
          TabRowView(
            hasDivider: true,
            cells: List<TabCellView>.generate(row.cells.length, (index) {
              return TabCellView(
                element: row.cells[index].element,
                width: _headCells[index].width,
                isShow: _headCells[index].isShow,
              );
            }),
          )
      ];

  TabHeadRowView get headRowView => TabHeadRowView(
        cells: List<TabHeadCellView>.generate(
          columnLength,
          (index) {
            final headCell = _headCells[index];
            return TabHeadCellView(
              minWidth: headCell.minWidth,
              maxWidth: headCell.maxWidth,
              width: headCell.width,
              text: headCell.text,
              isEnable: headCell.isShow,
              isSHowDragElement:
                  headCell.fixedWidth == null && showControlsElement,
              onWidthUpdate: (newWidth) => onColumnWidthUpdate(index, newWidth),
              onWidthUpdateFinish: () => onColumnWidthUpdateFinish(headCell),
            );
          },
        ),
      );

  void onShowColumnChange(TabHeadCell column, bool value) {
    column.isShow = value;
    persistance?.saveState(
      name: column.idLabel,
      state: ResizableState(column.width, value),
    );
    notifyListeners();
  }

  void onColumnWidthUpdateFinish(TabHeadCell headCell) {
    persistance?.saveState(
      name: headCell.idLabel,
      state: ResizableState(headCell.width, headCell.isShow),
    );
  }

  void onColumnWidthUpdate(int index, double width) {
    _headCells[index].width = width;
    notifyListeners();
  }

  bool showControlsElement = false;
  void setShowControlElements(bool isShow) {
    showControlsElement = isShow;
    notifyListeners();
  }
}
