import 'dart:convert';

class State {
  int id;
  String state;

  State({
    this.id,
    this.state,
  });

  State copyWith({
    int id,
    String state,
  }) {
    return State(
      id: id ?? this.id,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'state': state,
    };
  }

  static State fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return State(
      id: map['id'],
      state: map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  static State fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'State(id: $id, state: $state)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is State && o.id == id && o.state == state;
  }

  @override
  int get hashCode => id.hashCode ^ state.hashCode;
}

class StateColumns {
  static final String TABLE_NAME = 'state';
  static final String ID = 'id';
  static final String STATE = 'state';
}
