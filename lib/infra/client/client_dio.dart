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

  Future<State> getState
}
