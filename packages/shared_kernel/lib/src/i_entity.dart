import 'package:equatable/equatable.dart';

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
