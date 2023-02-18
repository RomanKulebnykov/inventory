abstract class ResizableTablePersistance {
  ResizableTablePersistance(this.tableName);

  final String tableName;

  Future<void> saveState({required String name, required ResizableState state});
  Future<ResizableState?> loadState({required String name});
}

class ResizableState {
  ResizableState(this.width, this.isShow);
  final double width;
  final bool isShow;
}
