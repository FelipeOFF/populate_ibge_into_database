import 'package:desafio_mysql_with_dio/infra/entry/citie_and_state.dart';
import 'package:desafio_mysql_with_dio/infra/entry/city.dart';
import 'package:desafio_mysql_with_dio/infra/entry/state.dart';

abstract class ICityAndStateRepository {
  Future<City> insertCity(City city);
  Future<State> insertState(State state);
  Future<CitieAndState> insertCitiesAndState(CitieAndState citieAndState);
  Future<List<CitieAndState>> getCitiesAndStates();
}
