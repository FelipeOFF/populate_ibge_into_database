import 'package:desafio_mysql_with_dio/infra/entry/citie_and_state.dart';
import 'package:desafio_mysql_with_dio/infra/entry/city.dart';
import 'package:desafio_mysql_with_dio/infra/entry/state.dart';
import 'package:desafio_mysql_with_dio/infra/local/data/db.dart';
import 'package:mysql1/mysql1.dart';

import 'i_citie_and_state_dataset.dart';

class CitieAndStateDatasetImpl implements ICitieAndStateDataset {
  final DB _db;

  CitieAndStateDatasetImpl(this._db);

  @override
  Future<List<CitieAndState>> getAllCitieAndState() async {
    var connection = await _db.conn();
    var result = await connection.query(
      '''
        select c.${CityColumns.ID}, c.${CityColumns.CITIE}, s.${StateColumns.ID}, s.${StateColumns.STATE} from ${CityColumns.TABLE_NAME} c
        inner join ${CitieAndStateColumns.TABLE_NAME} cs on cs.${CitieAndStateColumns.ID_CITIE} = c.${CityColumns.ID}
        inner join ${StateColumns.TABLE_NAME} s on cs.${CitieAndStateColumns.ID_STATE} = s.${StateColumns.ID};
      ''',
    );

    return _fromRow(result);
  }

  @override
  Future<CitieAndState> getCitieAndStateByIdOfState(int id) async {
    var connection = await _db.conn();
    var result = await connection.query(
      '''
        select c.${CityColumns.ID}, c.${CityColumns.CITIE}, s.${StateColumns.ID}, s.${StateColumns.STATE} from ${CitieAndStateColumns.TABLE_NAME} cs
        inner join ${CityColumns.TABLE_NAME} c on c.${CityColumns.ID} = cs.${CitieAndStateColumns.ID_CITIE}
        inner join ${StateColumns.TABLE_NAME} s on s.${StateColumns.ID} = cs.${CitieAndStateColumns.ID_STATE}
        where cs.${CitieAndStateColumns.ID_STATE} = ?;
      ''',
      [
        id,
      ],
    );

    return _fromRow(result).first;
  }

  @override
  Future<int> insertCitieAndState(CitieAndState citieAndState) async {
    var connection = await _db.conn();
    var idState = citieAndState.state.id;
    var idsCitys = citieAndState.cities.map((c) => c.id).toList();

    for (var cid in idsCitys) {
      await connection.query(
        'insert into ${CitieAndStateColumns.TABLE_NAME} (${CitieAndStateColumns.ID_STATE}, ${CitieAndStateColumns.ID_CITIE}) value(?, ?);',
        [idState, cid],
      );
    }

    return idState;
  }

  List<CitieAndState> _fromRow(Results results) {
    var result = results.fold(<State, List<City>>{},
        (Map<State, List<City>> previousValue, row) {
      var key = State(id: row[2], sigla: row[3]);
      var city = City(id: row[0], nome: row[1]);
      if (previousValue.containsKey(key)) {
        previousValue[key].add(city);
      } else {
        previousValue[key] = [city];
      }
      return previousValue;
    });
    return result.entries
        .map((entry) => CitieAndState(
              state: entry.key,
              cities: entry.value,
            ))
        .toList();
  }
}
