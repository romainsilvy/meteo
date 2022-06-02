class City {
  final int id;
  final String name;

  const City({
    required this.id,
    required this.name,
  });

  //from map
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'City{id: $id, name: $name}';
  }
}
