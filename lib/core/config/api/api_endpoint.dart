enum ApiEndpoint {
  getSimulationData,
  reportQuestion,
  getAllReports,
  reportAnswer,
  viewRejectReason,
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
      case ApiEndpoint.reportAnswer:
        return 'Report/ReportAnswer';
      case ApiEndpoint.viewRejectReason:
        return 'Report/ViewRejectReason';
    }
  }
}
