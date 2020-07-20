import 'dart:convert';

class State {
  int id;
  String sigla;

  State({
    this.id,
    this.sigla,
  });

  State copyWith({
    int id,
    String sigla,
  }) {
    return State(
      id: id ?? this.id,
      sigla: sigla ?? this.sigla,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sigla': sigla,
    };
  }

  static State fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return State(
      id: map['id'],
      sigla: map['sigla'],
    );
  }

  String toJson() => json.encode(toMap());

  static State fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'State(id: $id, sigla: $sigla)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is State && o.id == id && o.sigla == sigla;
  }

  @override
  int get hashCode => id.hashCode ^ sigla.hashCode;
}

class StateColumns {
  static final String TABLE_NAME = 'state';
  static final String ID = 'id';
  static final String STATE = 'sigla';
}
