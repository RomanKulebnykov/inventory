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
  }) {
    initializeStates(headCells, rows);
  }

  Future<void> initializeStates(
    List<TabHeadCell> headCells,
    List<TabRow> rows,
  ) async {
    final updatedHeadCells = <TabHeadCell>[];
    for (var headCell in headCells) {
      // if (headCell.fixedWidth != null) continue;
      final state = await persistance?.loadState(name: headCell.idLabel);
      if (state != null) {
        headCell.isShow = state.isShow;
        headCell.width = state.width;
        updatedHeadCells.add(
          TabHeadCell(
              idLabel: headCell.idLabel,
              element: headCell.element,
              isShow: state.isShow,
              width: state.width),
        );
      } else {
        updatedHeadCells.add(headCell);
      }
    }
    _headCells = updatedHeadCells;
    _rows = rows;
    notifyListeners();
  }

  List<TabHeadCell> _headCells = [];
  List<TabRow> _rows = [];
  final ResizableTablePersistance? persistance;

  final bool withDivider;
  final double rowHeight;
  final bool isCheckable;

  int get columnLength => _headCells.length;
  int get rowLength => _rows.length;

  Widget get menu => Visibility(
        visible: showControlsElement,
        child: HeadMenu(
            columns: _headCells
                .where((element) => element.showInMenu == true)
                .toList(),
            onChange: onShowColumnChange),
      );

  TabHeadRowView get headRowView => TabHeadRowView(
        cells: List<TabHeadCellView>.generate(
          columnLength,
          (index) {
            final headCell = _headCells[index];
            return TabHeadCellView(
              minWidth: headCell.minWidth,
              maxWidth: headCell.maxWidth,
              width: headCell.width,
              element: headCell.element,
              isEnable: headCell.isShow,
              isSHowDragElement:
                  headCell.fixedWidth == null && showControlsElement,
              onWidthUpdate: (newWidth) => onColumnWidthUpdate(index, newWidth),
              onWidthUpdateFinish: () => onColumnWidthUpdateFinish(headCell),
            );
          },
        ),
      );

  List<TabRowView> get rowViews => [
        for (final row in _rows)
          TabRowView(
            hasDivider: true,
            cells: List<TabCellView>.generate(row.cells.length, (index) {
              return TabCellView(
                element: row.cells[index].element,
                width: _headCells[index].width,
                height: rowHeight,
                isShow: _headCells[index].isShow,
              );
            }),
          )
      ];

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
