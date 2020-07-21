import 'package:desafio_mysql_with_dio/infra/entry/state.dart';
import 'package:desafio_mysql_with_dio/infra/entry/city.dart';
import 'package:desafio_mysql_with_dio/infra/entry/citie_and_state.dart';
import 'package:desafio_mysql_with_dio/infra/exception/parameter_is_null_exception.dart';
import 'package:desafio_mysql_with_dio/infra/local/dataset/i_citie_and_state_dataset.dart';
import 'package:desafio_mysql_with_dio/infra/local/dataset/i_city_dataset.dart';
import 'package:desafio_mysql_with_dio/infra/local/dataset/i_state_dataset.dart';
import 'package:desafio_mysql_with_dio/infra/network/eventdataset/i_city_event_dataset.dart';
import 'package:desafio_mysql_with_dio/infra/network/eventdataset/i_state_event_dataset.dart';

import 'i_city_and_state_repository.dart';

class CityAndStateRepositoryImpl implements ICityAndStateRepository {
  final ICitieAndStateDataset _citieAndState;
  final ICityDataset _cityDataset;
  final IStateDataset _stateDataset;
  final ICityEventDataset _cityEventDataset;
  final IStateEventDataset _stateEventDataset;

  CityAndStateRepositoryImpl(
    this._citieAndState,
    this._cityDataset,
    this._stateDataset,
    this._cityEventDataset,
    this._stateEventDataset,
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

  @override
  Future<List<CitieAndState>> getCitiesAndStatesEvent() async {
    var citiesAndStatesRegisterred = await getCitiesAndStates();

    if (citiesAndStatesRegisterred.isEmpty) {
      var states = await _stateEventDataset.getStates();

      for (final state in states) {
        print('insert State ${state.sigla}');
        var stateSaved = await insertState(state);
        print('Get Cities from state');
        var cities = await getCitiesByState(state.id);
        var listOfCitiesSaved = <City>[];
        for (final city in cities) {
          print('Insert city ${city.nome}');
          var citySaved = await insertCity(city);
          listOfCitiesSaved.add(citySaved);
        }
        await insertCitiesAndState(
            CitieAndState(state: stateSaved, cities: listOfCitiesSaved));
      }

      return await getCitiesAndStates();
    } else {
      return citiesAndStatesRegisterred;
    }
  }

  @override
  Future<List<City>> getCitiesByState(int id) async =>
      await _cityEventDataset.getCitiesByState(id);
}
