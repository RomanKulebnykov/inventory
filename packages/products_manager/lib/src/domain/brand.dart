

import '../firestore/models/i_brend.dart';

class Brand extends IBrand {
  final String? logImageURL;
  Brand({
    required super.id,
    required super.name,
    required super.description,
    required super.logoImagePath,
    this.logImageURL,
  });
  @override
  List<Object?> get props => [...super.props, logImageURL];
}
