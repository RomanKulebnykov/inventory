import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resizable_table.dart';
import 'resizable_table_view_model.dart';

/// ResizableTable
class ResizableTable extends StatelessWidget {
  ResizableTable({
    super.key,
    required this.columns,
    required this.rows,
    this.withDividers = true,
    this.persistance,
  }) : assert(rows.every((element) => element.cells.length == columns.length));

  final List<TabHeadCell> columns;
  final List<TabRow> rows;
  final bool withDividers;
  final ResizableTablePersistance? persistance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResizableTableViewModel>(
      create: (context) => ResizableTableViewModel(
        columns,
        rows,
        withDivider: withDividers,
        persistance: persistance,
      ),
      child: const _ResizableTableView(),
    );
  }
}

/// ResizableTableView
class _ResizableTableView extends StatelessWidget {
  const _ResizableTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ResizableTableViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            MouseRegion(
              onEnter: (event) => viewModel.setShowControlElements(true),
              onExit: (event) => viewModel.setShowControlElements(false),
              child: Row(
                children: [
                  viewModel.headRowView,
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: viewModel.menu,
                  ),
                ],
              ),
            ),
            if (viewModel.withDivider) const Divider(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.rowLength,
              itemBuilder: (context, index) {
                return viewModel.rowViews[index];
              },
            ),
          ],
        );
      },
    );
  }
}
