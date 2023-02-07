import 'package:shared_kernel/shared_kernel.dart';

class DomainEventProcessor {
  DomainEventProcessor._internal() : _handlers = [];
  static final DomainEventProcessor _processor =
      DomainEventProcessor._internal();

  final List<IDomainEventHandler> _handlers;

  static void registerHandler(IDomainEventHandler handler) {
    _processor._handlers.add(handler);
  }

  static void sendEvent(IDomainEvent event) async {
    for (final handler in _processor._handlers) {
      if (event.runtimeType == handler.getEventType()) {
        await handler.processEvent(event);
      }
    }
  }
}
