class Brend {
  String id;
  String name;
  String description;
  String? logoURL;

  Brend({
    required this.id,
    required this.name,
    required this.description,
    required this.logoURL,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logoUrl': logoURL,
    };
  }

  factory Brend.fromMap(Map<String, dynamic> map) {
    return Brend(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      logoURL: map['logoUrl'] as String?,
    );
  }
}
