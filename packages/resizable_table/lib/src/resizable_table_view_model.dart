import 'package:flutter/material.dart';
import 'package:resizable_table/src/head_menu.dart';
import 'package:resizable_table/src/tab_head_row.dart';

import '../resizable_table.dart';

class ResizableTableViewModel extends ChangeNotifier {
  ResizableTableViewModel({
    required List<TabHeadCell> headCells,
    required List<TabRow> rows,
    this.persistance,
    required this.rowHeight,
    required this.isCheckable,
    this.withDivider = true,
  })  : _rows = rows,
        _headCells = headCells {
    loadStates();
  }

  Future<void> loadStates() async {
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
  final ResizableTablePersistance? persistance;

  final bool withDivider;
  final double rowHeight;
  final bool isCheckable;

  int get columnLength => _headCells.length;
  int get rowLength => _rows.length;

  Widget get menu => Visibility(
        visible: showControlsElement,
        child: HeadMenu(columns: _headCells, onChange: onShowColumnChange),
      );

  TabHeadRowView get headRowView => TabHeadRowView(
        cells: [..._generateHeadCells()],
      );

  List<TabRowView> get rowViews => [
        for (final row in _rows)
          TabRowView(
            hasDivider: true,
            cells: [
              // _generateCheckedCell((value) {}),
              ..._generateRowCells(row)
            ],
          )
      ];

  TabCellView _generateCheckedCell(Function(bool? value) onChange) {
    return TabCellView(
      width: 50,
      element: Checkbox(
        value: false,
        onChanged: onChange,
      ),
      isShow: true,
      height: rowHeight,
    );
  }

  List<TabCellView> _generateRowCells(TabRow row) {
    return List<TabCellView>.generate(row.cells.length, (index) {
      return TabCellView(
        element: row.cells[index].element,
        width: _headCells[index].width,
        height: rowHeight,
        isShow: _headCells[index].isShow,
      );
    });
  }

  List<TabHeadCellView> _generateHeadCells() {
    return List<TabHeadCellView>.generate(
      columnLength,
      (index) {
        final headCell = _headCells[index];
        return TabHeadCellView(
          minWidth: headCell.minWidth,
          maxWidth: headCell.maxWidth,
          width: headCell.width,
          element: headCell.element,
          isEnable: headCell.isShow,
          isSHowDragElement: headCell.fixedWidth == null && showControlsElement,
          onWidthUpdate: (newWidth) => onColumnWidthUpdate(index, newWidth),
          onWidthUpdateFinish: () => onColumnWidthUpdateFinish(headCell),
        );
      },
    );
  }

  /// ------------------------------------------------------- onShowColumnChange
  void onShowColumnChange(TabHeadCell column, bool value) {
    column.isShow = value;
    persistance?.saveState(
      name: column.idLabel,
      state: ResizableState(column.width, value),
    );
    notifyListeners();
  }

  /// ------------------------------------------------ onColumnWidthUpdateFinish
  void onColumnWidthUpdateFinish(TabHeadCell headCell) {
    persistance?.saveState(
      name: headCell.idLabel,
      state: ResizableState(headCell.width, headCell.isShow),
    );
  }

  /// ------------------------------------------------------ onColumnWidthUpdate
  void onColumnWidthUpdate(int index, double width) {
    _headCells[index].width = width;
    notifyListeners();
  }

  /// ------------------------------------------------------ showControlsElement
  bool showControlsElement = false;
  void setShowControlElements(bool isShow) {
    showControlsElement = isShow;
    notifyListeners();
  }
}
