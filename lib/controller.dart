import 'package:desafio_mysql_with_dio/infra/repository/city_and_state_repository_impl.dart';
import 'package:desafio_mysql_with_dio/infra/repository/i_city_and_state_repository.dart';
import 'infra/local/data/db.dart';
import 'infra/local/dataset/citie_and_state_dataset_impl.dart';
import 'infra/local/dataset/city_dataset_impl.dart';
import 'infra/local/dataset/i_citie_and_state_dataset.dart';
import 'infra/local/dataset/i_city_dataset.dart';
import 'infra/local/dataset/i_state_dataset.dart';
import 'infra/local/dataset/state_dataset_impl.dart';

var db = DB();
ICityDataset iCitieDataset = CityDatasetImpl(db);
IStateDataset iStateDataset = StateDatasetImpl(db);
ICitieAndStateDataset iCitieAndStateDataset = CitieAndStateDatasetImpl(db);
ICityAndStateRepository iCityAndStateRepository = CityAndStateRepositoryImpl(
    iCitieAndStateDataset, iCitieDataset, iStateDataset);

Future<void> teste() async {
  await db.close();
}

void run() {
  teste();
}
