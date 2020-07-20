import 'package:desafio_mysql_with_dio/infra/entry/citie_and_state.dart';

abstract class ICitieAndStateDataset {
  Future<CitieAndState> getCitieAndStateByIdOfState(int id);
  Future<List<CitieAndState>> getAllCitieAndState();
  Future<int> insertCitieAndState(CitieAndState citieAndState);
}
