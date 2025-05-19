enum ApiEndpoint {
  getSimulationData,
  reportQuestion,
  getAllReports,
  reportAnswer,
  viewRejectReason,
  getUserRewards,
  withdrawReward,
  getAllTasks,
}

extension ApiEndpointPath on ApiEndpoint {
  String get path {
    switch (this) {
      case ApiEndpoint.getSimulationData:
        return 'Simulation/PracticeOnline';
      case ApiEndpoint.reportQuestion:
        return 'Report/SubmitReport';
      case ApiEndpoint.getAllReports:
        return 'Report/GetAllReports';
      case ApiEndpoint.getUserRewards:
        return '/MyReward/GetUserRewards';
      case ApiEndpoint.reportAnswer:
        return 'Report/ReportAnswer';
      case ApiEndpoint.viewRejectReason:
        return 'Report/ViewRejectReason';
      case ApiEndpoint.withdrawReward:
        return 'MyReward/Withdraw';
      case ApiEndpoint.getAllTasks:
        return 'MyTask/GetAllTasks';
    }
  }
}
