import 'package:desafio_mysql_with_dio/infra/entry/city.dart';
import 'package:desafio_mysql_with_dio/infra/local/data/db.dart';

import 'i_city_dataset.dart';

class CityDatasetImpl implements ICityDataset {
  final DB _db;

  CityDatasetImpl(this._db);

  @override
  Future<List<City>> getAllCities() async {
    var connection = await _db.conn();
    var result = await connection.query(
      'SELECT ${CityColumns.ID}, ${CityColumns.CITIE} FROM ${CityColumns.TABLE_NAME};',
    );
    return result.map((row) => City.fromMap(row.fields));
  }

  @override
  Future<City> getCityById(int id) async {
    var connection = await _db.conn();
    var result = await connection.query(
      'select id, citie from ${CityColumns.TABLE_NAME} where id = ?;',
      [id],
    );
    var first = result.first;
    if (first == null) {
      return null;
    } else {
      return City.fromMap(first.fields);
    }
  }

  @override
  Future<int> insertCity(City city) async {
    var connection = await _db.conn();
    var results = await connection.query(
      'insert into ${CityColumns.TABLE_NAME} (${CityColumns.ID}, ${CityColumns.CITIE}) value(?, ?);',
      [
        city.id,
        city.nome,
      ],
    );
    return results.insertId;
  }
}
