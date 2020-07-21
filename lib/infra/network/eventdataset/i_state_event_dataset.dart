import 'package:desafio_mysql_with_dio/infra/entry/state.dart';

abstract class IStateEventDataset {
  Future<List<State>> getStates();
}
