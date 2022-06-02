class City {
  final String name;

  const City({
    required this.name,
  });

  //from map
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return 'City{name: $name}';
  }
}
