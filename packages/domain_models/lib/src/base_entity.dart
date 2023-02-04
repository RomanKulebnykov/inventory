import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class BaseEntity extends Equatable {
  final String id;
  final List<BaseDomainEvent> events;

  BaseEntity(
    String? id, {
    List<BaseDomainEvent>? events,
  })  : id = id ?? Uuid().v4(),
        events = events ?? [];

  @override
  List<Object?> get props => [id, events];
}

abstract class BaseDomainEvent {}
