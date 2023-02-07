import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'i_domain_event.dart';

abstract class IEntity extends Equatable {
  final String id;
  final List<IDomainEvent> events;

  IEntity(
    String? id, {
    List<IDomainEvent>? events,
  })  : id = id ?? Uuid().v4(),
        events = events ?? [];

  @override
  List<Object?> get props => [id, events];
}

abstract class IIdentifier {
  final String id;

  IIdentifier(this.id);
}

abstract class IValueObject extends Equatable {}

abstract class IAggregateRoot extends IEntity {
  IAggregateRoot(super.id);
}
