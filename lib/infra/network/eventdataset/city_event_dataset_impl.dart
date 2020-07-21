import 'package:desafio_mysql_with_dio/infra/entry/city.dart';
import 'package:desafio_mysql_with_dio/infra/network/client/client_dio.dart';

import 'i_city_event_dataset.dart';

class CityEventDatasetImpl implements ICityEventDataset {
  final ClientDio _clientDio;

  CityEventDatasetImpl(this._clientDio);

  @override
  Future<List<City>> getCitiesByState(int id) {
    return _clientDio.getCities(id);
  }
}
