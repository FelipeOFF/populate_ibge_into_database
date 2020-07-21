import 'package:desafio_mysql_with_dio/infra/entry/city.dart';

abstract class ICityEventDataset {
  Future<List<City>> getCitiesByState(int id);
}
