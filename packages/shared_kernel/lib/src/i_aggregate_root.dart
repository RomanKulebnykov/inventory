import '../shared_kernel.dart';

abstract class IAggregateRoot extends IEntity {
  IAggregateRoot(super.id);
  void addDomainEvent(IDomainEvent event) =>
      DomainEventProcessor.sendEvent(event);
}
