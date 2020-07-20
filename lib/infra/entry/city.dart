import 'dart:convert';

class City {
  int id;
  String nome;

  City({
    this.id,
    this.nome,
  });

  City copyWith({
    int id,
    String nome,
  }) {
    return City(
      id: id ?? this.id,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  static City fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return City(
      id: map['id'],
      nome: map['nome'],
    );
  }

  String toJson() => json.encode(toMap());

  static City fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'City(id: $id, nome: $nome)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is City && o.id == id && o.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode;
}

class CityColumns {
  static final String TABLE_NAME = 'citie';
  static final String ID = 'id';
  static final String CITIE = 'nome';
}
