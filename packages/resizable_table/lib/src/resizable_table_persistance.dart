abstract class ResizableTablePersistance {
  ResizableTablePersistance(this.tableName);

  final String tableName;

  Future<void> saveState({required List<ColumnState> states});
  Future<List<ColumnState>?> loadState();
}

class ColumnState {
  ColumnState(this.id, this.width, this.isShow);
  final String id;
  final double width;
  final bool isShow;
}
