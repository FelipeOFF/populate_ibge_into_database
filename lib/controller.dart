import 'package:desafio_mysql_with_dio/infra/network/eventdataset/city_event_dataset_impl.dart';
import 'package:desafio_mysql_with_dio/infra/network/eventdataset/i_city_event_dataset.dart';
import 'package:desafio_mysql_with_dio/infra/network/eventdataset/i_state_event_dataset.dart';
import 'package:desafio_mysql_with_dio/infra/network/eventdataset/state_event_datasetImpl.dart';
import 'package:desafio_mysql_with_dio/infra/repository/city_and_state_repository_impl.dart';
import 'package:desafio_mysql_with_dio/infra/repository/i_city_and_state_repository.dart';
import 'infra/local/data/db.dart';
import 'infra/local/dataset/citie_and_state_dataset_impl.dart';
import 'infra/local/dataset/city_dataset_impl.dart';
import 'infra/local/dataset/i_citie_and_state_dataset.dart';
import 'infra/local/dataset/i_city_dataset.dart';
import 'infra/local/dataset/i_state_dataset.dart';
import 'infra/local/dataset/state_dataset_impl.dart';
import 'infra/network/client/client_dio.dart';

var db = DB();
var clientDio = ClientDio();
ICityDataset iCitieDataset = CityDatasetImpl(db);
IStateDataset iStateDataset = StateDatasetImpl(db);
ICitieAndStateDataset iCitieAndStateDataset = CitieAndStateDatasetImpl(db);
IStateEventDataset iStateEventDataset = StateEventDatasetImpl(clientDio);
ICityEventDataset iCityEventDataset = CityEventDatasetImpl(clientDio);
ICityAndStateRepository iCityAndStateRepository = CityAndStateRepositoryImpl(
  iCitieAndStateDataset,
  iCitieDataset,
  iStateDataset,
  iCityEventDataset,
  iStateEventDataset,
);

Future<void> teste() async {
  var states = await iCityAndStateRepository.getCitiesAndStatesEvent();

  for (var state in states) {
    for (var city in state.cities) {
      print('${state.state.sigla} - ${city.nome}');
    }
  }

  await db.close();
}

void run() {
  teste();
}
