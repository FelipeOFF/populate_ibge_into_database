import 'package:desafio_mysql_with_dio/infra/dataset/citie_and_state_dataset_impl.dart';
import 'package:desafio_mysql_with_dio/infra/dataset/city_dataset_impl.dart';
import 'package:desafio_mysql_with_dio/infra/dataset/i_citie_and_state_dataset.dart';
import 'package:desafio_mysql_with_dio/infra/dataset/i_city_dataset.dart';
import 'package:desafio_mysql_with_dio/infra/dataset/i_state_dataset.dart';
import 'package:desafio_mysql_with_dio/infra/dataset/state_dataset_impl.dart';
import 'package:desafio_mysql_with_dio/infra/entry/citie_and_state.dart';
import 'package:desafio_mysql_with_dio/infra/entry/city.dart';
import 'package:desafio_mysql_with_dio/infra/entry/state.dart';
import 'package:desafio_mysql_with_dio/infra/repository/city_and_state_repository_impl.dart';
import 'package:desafio_mysql_with_dio/infra/repository/i_city_and_state_repository.dart';

import 'infra/data/db.dart';

var db = DB();
ICityDataset iCitieDataset = CityDatasetImpl(db);
IStateDataset iStateDataset = StateDatasetImpl(db);
ICitieAndStateDataset iCitieAndStateDataset = CitieAndStateDatasetImpl(db);
ICityAndStateRepository iCityAndStateRepository = CityAndStateRepositoryImpl(
    iCitieAndStateDataset, iCitieDataset, iStateDataset);

Future<void> teste() async {
  var value = await iCityAndStateRepository.insertCitiesAndState(CitieAndState(
    state: State(
      id: 45,
      state: 'SP',
    ),
    cities: <City>[
      City(
        id: 24,
        citie: 'São Paulo',
      ),
    ],
  ));
  print('Value ${value}');
  var result = await iCitieAndStateDataset.getAllCitieAndState();
  print(result);

  await db.close();
}

void run() {
  teste();
}
