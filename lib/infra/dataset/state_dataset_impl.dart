import 'package:desafio_mysql_with_dio/infra/data/db.dart';
import 'package:desafio_mysql_with_dio/infra/entry/state.dart';

import 'i_state_dataset.dart';

class StateDatasetImpl implements IStateDataset {
  final DB _db;

  StateDatasetImpl(this._db);

  @override
  Future<List<State>> getAllState() async {
    var connection = await _db.conn();
    var result = await connection.query(
      'SELECT ${StateColumns.ID}, ${StateColumns.STATE} FROM ${StateColumns.TABLE_NAME};',
    );
    return result.map((row) => State.fromMap(row.fields));
  }

  @override
  Future<State> getStateById(int id) async {
    var connection = await _db.conn();
    var result = await connection.query(
      'select id, citie from ${StateColumns.TABLE_NAME} where id = ?;',
      [id],
    );
    var first = result.first;
    if (first == null) {
      return null;
    } else {
      return State.fromMap(first.fields);
    }
  }

  @override
  Future<int> insertState(State state) async {
    var connection = await _db.conn();
    var results = await connection.query(
      'insert into ${StateColumns.TABLE_NAME} (${StateColumns.ID}, ${StateColumns.STATE}) value(?, ?);',
      [
        state.id,
        state.sigla,
      ],
    );
    return results.insertId;
  }
}
