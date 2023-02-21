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
    required this.withDivider,
  }) {
    initializeStates(headCells, rows);
  }

  /// --------------------------------------------------------- initializeStates
  Future<void> initializeStates(
    List<TabHeadCell> headCells,
    List<TabRow> rows,
  ) async {
    List<TabHeadCell>? updatedHeadCells;
    final states = await persistance?.loadState();
    if (states != null && states.length == headCells.length) {
      updatedHeadCells = [];
      for (final state in states) {
        final headCell = headCells.firstWhere((e) => e.idLabel == state.id);
        updatedHeadCells.add(
          TabHeadCell(
            idLabel: state.id,
            width: state.width,
            isShow: state.isShow,
            element: headCell.element,
            isPinned: headCell.isPinned,
            fixedWidth: headCell.fixedWidth,
            minWidth: headCell.minWidth,
            maxWidth: headCell.maxWidth,
          ),
        );
      }
    }
    _headCells = updatedHeadCells ?? headCells;
    _rows = rows;
    notifyListeners();
  }

  /// =================================================================== FIELDS
  final ResizableTablePersistance? persistance;
  final bool withDivider;
  final double rowHeight;
  final bool isCheckable;

  List<TabHeadCell> _headCells = [];
  List<TabRow> _rows = [];

  /// ============================================================= VIEW GETTERS
  int get columnLength => _headCells.length;
  int get rowLength => _rows.length;

  /// --------------------------------------------------------------------- menu
  Widget get menu => Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: showControlsElement,
        child: HeadMenu(
          columns: _headCells.where((e) => e.isPinned == false).toList(),
          onChange: onShowColumnChange,
        ),
      );

  /// -------------------------------------------------------------- headRowView
  TabHeadRowView get headRowView => TabHeadRowView(
        cells: [
          for (final headCell in _headCells)
            TabHeadCellView(
              key: ValueKey(headCell.idLabel),
              idLabel: headCell.idLabel,
              minWidth: headCell.fixedWidth ?? headCell.minWidth,
              maxWidth: headCell.fixedWidth ?? headCell.maxWidth,
              width: headCell.width,
              element: headCell.element,
              isEnable: headCell.isShow,
              isPinned: headCell.isPinned,
              isSHowDragElement: showControlsElement,
            )
        ],
      );

  /// ----------------------------------------------------------------- rowViews
  List<TabRowView> get rowViews {
    return _rows.map<TabRowView>((row) {
      return TabRowView(
        onTap: row.onTap,
        heightLightListColor: row.heightLightListColor,
        hasDivider: withDivider,
        cells: _headCells.map<TabCellView>((headCell) {
          final cell =
              row.cells.firstWhere((cell) => cell.idColumn == headCell.idLabel);
          return TabCellView(
            width: headCell.width,
            element: cell.element,
            isShow: headCell.isShow,
            height: rowHeight,
          );
        }).toList(),
      );
    }).toList();
  }

  /// ---------------------------------------------------------------- onReorder

  void onColumnReorder(int oldIndex, int newIndex) {
    if (_headCells[oldIndex].isPinned || _headCells[newIndex].isPinned) return;
    final replacedCell = _headCells.removeAt(oldIndex);
    if (oldIndex < newIndex) {
      _headCells.insert(newIndex - 1, replacedCell);
    } else {
      _headCells.insert(newIndex, replacedCell);
    }
    notifyListeners();
    _saveTableState();
  }

  /// ------------------------------------------------------- onShowColumnChange
  void onShowColumnChange(TabHeadCell column, bool value) {
    column.isShow = value;
    notifyListeners();
    _saveTableState();
  }

  /// ------------------------------------------------------ showControlsElement
  bool showControlsElement = false;
  void setShowControlElements(bool isShow) {
    showControlsElement = isShow;
    notifyListeners();
  }

  /// ------------------------------------------------------ onColumnWidthUpdate
  void onColumnWidthUpdate(String idLabel, double width) {
    _headCells.firstWhere((e) => e.idLabel == idLabel).width = width;
    notifyListeners();
  }

  /// ------------------------------------------------ onColumnWidthUpdateFinish
  void onColumnWidthUpdateFinish(String idLabel, double width) {
    _saveTableState();
  }

  Future<void> _saveTableState() async {
    persistance?.saveState(
      states: _headCells
          .map<ColumnState>((e) => ColumnState(e.idLabel, e.width, e.isShow))
          .toList(),
    );
  }
}
