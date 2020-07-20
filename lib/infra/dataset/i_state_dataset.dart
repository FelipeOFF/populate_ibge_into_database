import 'package:desafio_mysql_with_dio/infra/entry/state.dart';

abstract class IStateDataset {
  Future<int> insertState(State state);
  Future<List<State>> getAllState();
  Future<State> getStateById(int id);
}
