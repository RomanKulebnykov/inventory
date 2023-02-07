import 'package:equatable/equatable.dart';
import 'package:shared_kernel/src/domain_events_processor.dart';
import 'package:uuid/uuid.dart';

import 'i_domain_event.dart';

abstract class IEntity extends Equatable {
  const IEntity(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

abstract class IIdentifier {
  final String id;

  IIdentifier(this.id);
}
