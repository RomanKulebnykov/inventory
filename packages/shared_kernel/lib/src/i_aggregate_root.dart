import '../shared_kernel.dart';

abstract class IAggregateRoot extends IEntity {
  const IAggregateRoot(super.id);
  void addDomainEvent(IDomainEvent event) =>
      DomainEventProcessor.sendEvent(event);
}
