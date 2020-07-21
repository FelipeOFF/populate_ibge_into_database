import 'package:mysql1/mysql1.dart';

class DB {
  static final DB _db = DB._internal();

  MySqlConnection _connection;

  final ConnectionSettings _settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'root',
    db: 'states_and_cities',
  );

  factory DB() {
    return _db;
  }

  DB._internal() {
    conn();
  }

  Future<MySqlConnection> conn() async {
    _connection ??= await MySqlConnection.connect(_settings);
    return _connection;
  }

  Future<void> close() async {
    await _connection?.close();
    _connection = null;
  }
}
