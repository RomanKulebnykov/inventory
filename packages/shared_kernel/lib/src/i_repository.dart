import 'package:shared_kernel/src/i_aggregate_root.dart';

abstract class IRepository {
  Stream<IAggregateRoot> stream(IEntityFilter? filter);
  Future<List<IAggregateRoot>> list(IEntityFilter? filter);
  Future<IAggregateRoot> getById(String id);
  Future<bool> save(IAggregateRoot entity);
  Future<bool> remove(String id);
}

abstract class IEntityFilter<T> {
  // List<FilterCondition> get conditions;
  bool isSatisfiedBy(T candidate);
}
