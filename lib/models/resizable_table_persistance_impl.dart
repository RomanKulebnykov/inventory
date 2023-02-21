import 'package:resizable_table/resizable_table.dart';

class PersistanceMemory extends ResizableTablePersistance {
  PersistanceMemory(super.tableName);

  final Map<String, List<ColumnState>> tables = {};

  @override
  Future<List<ColumnState>?> loadState() async {
    return tables[super.tableName];
  }

  @override
  Future<void> saveState({required List<ColumnState> states}) async {
    tables[super.tableName] = states;
  }
}
