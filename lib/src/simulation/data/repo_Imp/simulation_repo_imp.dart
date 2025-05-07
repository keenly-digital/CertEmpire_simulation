import 'package:certempiree/core/config/api/api_result.dart';
import 'package:certempiree/src/simulation/data/data_sources/simulation_remote_data_src.dart';

import '../../domain/repos/auth_repo.dart';

class SimulationRepoImp extends AuthRepo {
  final SimulationDataSrc _simulationDataSrc;

  SimulationRepoImp(this._simulationDataSrc);

  @override
  Future<ApiResult<APIResponse<String?>>> getSimulationData(String req) async {
    return await getSimulationData(req);
  }
}
