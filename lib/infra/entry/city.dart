import 'dart:convert';

class City {
  int id;
  String citie;

  City({
    this.id,
    this.citie,
  });

  City copyWith({
    int id,
    String citie,
  }) {
    return City(
      id: id ?? this.id,
      citie: citie ?? this.citie,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'citie': citie,
    };
  }

  static City fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return City(
      id: map['id'],
      citie: map['citie'],
    );
  }

  String toJson() => json.encode(toMap());

  static City fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'City(id: $id, citie: $citie)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is City && o.id == id && o.citie == citie;
  }

  @override
  int get hashCode => id.hashCode ^ citie.hashCode;
}

class CityColumns {
  static final String TABLE_NAME = 'citie';
  static final String ID = 'id';
  static final String CITIE = 'citie';
}
