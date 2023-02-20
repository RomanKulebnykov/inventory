import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resizable_table.dart';
import 'resizable_table_view_model.dart';

/// ============================================================= ResizableTable
class ResizableTable extends StatelessWidget {
  ResizableTable({
    super.key,
    required this.columns,
    required this.rows,
    this.persistance,
    this.isCheckable = true,
    this.withDividers = true,
    this.rowHeight = 20,
  }) : assert(rows.every((element) => element.cells.length == columns.length));

  final List<TabHeadCell> columns;
  final List<TabRow> rows;
  final ResizableTablePersistance? persistance;
  final bool withDividers;
  final bool isCheckable;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResizableTableViewModel>(
      create: (context) => ResizableTableViewModel(
        headCells: columns,
        rows: rows,
        rowHeight: rowHeight,
        withDivider: withDividers,
        isCheckable: isCheckable,
        persistance: persistance,
      ),
      child: const _ResizableTableView(),
    );
  }
}

/// ========================================================= ResizableTableView
class _ResizableTableView extends StatelessWidget {
  const _ResizableTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ResizableTableViewModel>(
      builder: (context, viewModel, child) {
        return Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MouseRegion(
                  onEnter: (event) => viewModel.setShowControlElements(true),
                  onExit: (event) => viewModel.setShowControlElements(false),
                  child: Row(
                    children: [
                      viewModel.headRowView,
                      // const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: viewModel.menu,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: IntrinsicWidth(
                      child: Column(children: [
                        if (viewModel.withDivider) const Divider(),
                        ...viewModel.rowViews,
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
