import 'package:resizable_table/resizable_table.dart';

class PersistanceMemory extends ResizableTablePersistance {
  PersistanceMemory(super.tableName);

  final Map<String, ResizableState> states = {};

  @override
  Future<ResizableState?> loadState({required String name}) async {
    return states.containsKey(name) ? states[name] : null;
  }

  @override
  Future<void> saveState({
    required String name,
    required ResizableState state,
  }) async {
    states[name] = state;
  }
}
