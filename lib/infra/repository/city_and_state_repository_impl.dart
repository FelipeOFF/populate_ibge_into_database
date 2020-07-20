import 'package:desafio_mysql_with_dio/infra/dataset/i_citie_and_state_dataset.dart';
import 'package:desafio_mysql_with_dio/infra/dataset/i_city_dataset.dart';
import 'package:desafio_mysql_with_dio/infra/dataset/i_state_dataset.dart';
import 'package:desafio_mysql_with_dio/infra/entry/state.dart';
import 'package:desafio_mysql_with_dio/infra/entry/city.dart';
import 'package:desafio_mysql_with_dio/infra/entry/citie_and_state.dart';
import 'package:desafio_mysql_with_dio/infra/exception/parameter_is_null_exception.dart';

import 'i_city_and_state_repository.dart';

class CityAndStateRepositoryImpl implements ICityAndStateRepository {
  final ICitieAndStateDataset _citieAndState;
  final ICityDataset _cityDataset;
  final IStateDataset _stateDataset;

  CityAndStateRepositoryImpl(
    this._citieAndState,
    this._cityDataset,
    this._stateDataset,
  );

  @override
  Future<CitieAndState> insertCitiesAndState(
      CitieAndState citieAndState) async {
    if (citieAndState.state == null && citieAndState.cities?.isEmpty == true) {
      throw ParameterIsNullException('State or Cities is null');
    } else {
      var state = await insertState(citieAndState.state);
      var cities = await Stream.fromIterable(citieAndState.cities)
          .asyncMap((c) async => await insertCity(c))
          .toList();

      citieAndState.state = state;
      citieAndState.cities = cities;

      await _citieAndState.insertCitieAndState(citieAndState);

      return citieAndState;
    }
  }

  @override
  Future<City> insertCity(City city) async {
    if (city.nome == null) {
      throw ParameterIsNullException('City is null');
    } else {
      await _cityDataset.insertCity(city);
      return city;
    }
  }

  @override
  Future<State> insertState(State state) async {
    if (state.sigla == null) {
      throw ParameterIsNullException('State is null');
    } else {
      await _stateDataset.insertState(state);
      return state;
    }
  }

  @override
  Future<List<CitieAndState>> getCitiesAndStates() {
    return _citieAndState.getAllCitieAndState();
  }
}
