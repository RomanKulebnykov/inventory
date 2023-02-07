import 'package:shared_kernel/src/i_domain_event.dart';

abstract class IDomainEventHandler<T extends IDomainEvent> {
  Type getEventType() => T.runtimeType;

  Future<void> processEvent(T event);
}
