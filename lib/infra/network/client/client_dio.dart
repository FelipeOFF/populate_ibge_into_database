import 'package:desafio_mysql_with_dio/infra/entry/city.dart';
import 'package:desafio_mysql_with_dio/infra/entry/state.dart';
import 'package:dio/dio.dart';

class ClientDio {
  static final ClientDio _clientDio = ClientDio._internal();

  Dio _dio;

  factory ClientDio() {
    return _clientDio;
  }

  ClientDio._internal() {
    _dio = Dio(BaseOptions(baseUrl: 'https://servicodados.ibge.gov.br/'));
  }

  Future<State> getState() async {
    var result = await _dio.get('/api/v1/localidades/estados');
    if (result.data is Map<String, dynamic>) return State.fromJson(result.data);
  }

  Future<List<City>> getCities(int stateId) async {
    var result =
        await _dio.get('/api/v1/localidades/estados/$stateId/distritos');
    if (result.data is List && result.data.first is Map<String, dynamic>)
      return result.data.map((v) => City.fromJson(v));
  }
}
