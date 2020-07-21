import 'package:desafio_mysql_with_dio/infra/entry/city.dart';

abstract class ICityDataset {
  Future<int> insertCity(City city);
  Future<bool> checkCityExist(int id);
  Future<City> getCityById(int id);
  Future<List<City>> getAllCities();
}
