import 'package:shared_kernel/src/i_aggregate_root.dart';

enum FetchPolicies {
  remoteOnly,
  remoteAndCache,
  localWithUpdate;
}

abstract class IDataSource<T extends IAggregateRoot, F extends IEntityFilter> {
  Future<List<T>> list(F filter);
  Future<T?> getById(String id);
  Future<bool> save(T entity);
  Future<bool> remove(String id);
}

abstract class IEntityFilter {
  // List<FilterCondition> get conditions;
  // bool isSatisfiedBy(T candidate);
}

abstract class IRepository<T extends IAggregateRoot, F extends IEntityFilter> {
  IRepository({
    required this.policies,
    required this.local,
    required this.remote,
  });

  final FetchPolicies policies;

  final IDataSource<T, F> local;
  final IDataSource<T, F> remote;

  Stream<T> stream(F filter);
  Future<List<T>> list(F filter);
  Future<T> getById(String id);
  Future<bool> save(T entity);
  Future<bool> remove(String id);
}
