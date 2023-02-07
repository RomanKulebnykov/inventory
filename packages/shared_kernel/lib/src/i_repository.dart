import 'package:shared_kernel/src/i_aggregate_root.dart';

abstract class IRepository<T extends IAggregateRoot, F extends IEntityFilter> {
  Stream<T> stream(F filter);
  Future<List<T>> list(F filter);
  Future<T> getById(String id);
  Future<bool> save(T entity);
  Future<bool> remove(String id);
}

abstract class IEntityFilter {
  // List<FilterCondition> get conditions;
  // bool isSatisfiedBy(T candidate);
}
