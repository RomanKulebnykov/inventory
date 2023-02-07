import 'package:domain_models/src/interfaces/i_entity.dart';

import 'i_entity_filter.dart';

abstract class IRepository {
  Stream<IEntity> stream(IEntityFilter? filter);
  Future<List<IEntity>> list(IEntityFilter? filter);
  Future<IEntity> getById(String id);
  Future<bool> save(IEntity entity);
  Future<bool> remove(String id);
}
