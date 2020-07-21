import 'package:desafio_mysql_with_dio/infra/entry/state.dart';
import 'package:desafio_mysql_with_dio/infra/network/client/client_dio.dart';

import 'i_state_event_dataset.dart';

class StateEventDatasetImpl implements IStateEventDataset {
  final ClientDio _clientDio;

  StateEventDatasetImpl(this._clientDio);

  @override
  Future<List<State>> getStates() {
    return _clientDio.getStates();
  }
}
