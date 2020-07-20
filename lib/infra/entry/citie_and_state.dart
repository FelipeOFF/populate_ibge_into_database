import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:desafio_mysql_with_dio/infra/entry/city.dart';
import 'package:desafio_mysql_with_dio/infra/entry/state.dart';

class CitieAndState {
  List<City> cities;
  State state;

  CitieAndState({
    this.cities,
    this.state,
  });

  CitieAndState copyWith({
    List<City> cities,
    State state,
  }) {
    return CitieAndState(
      cities: cities ?? this.cities,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cities': cities?.map((x) => x?.toMap())?.toList(),
      'state': state?.toMap(),
    };
  }

  static CitieAndState fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CitieAndState(
      cities: List<City>.from(map['cities']?.map((x) => City.fromMap(x))),
      state: State.fromMap(map['state']),
    );
  }

  String toJson() => json.encode(toMap());

  static CitieAndState fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'CitieAndState(cities: $cities, state: $state)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return o is CitieAndState &&
        listEquals(o.cities, cities) &&
        o.state == state;
  }

  @override
  int get hashCode => cities.hashCode ^ state.hashCode;
}

class CitieAndStateColumns {
  static final String TABLE_NAME = 'citie_and_state';
  static final String ID_CITIE = 'id_citie';
  static final String ID_STATE = 'id_state';
}
