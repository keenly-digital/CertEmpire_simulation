

abstract class SimulationEvent {}

class FetchSimulationDataEvent extends SimulationEvent {
  final String? fieldId;
  final int pageNumber;

  FetchSimulationDataEvent({this.fieldId, this.pageNumber = 1});
}

class ShowAnswerEvent extends SimulationEvent {
  final int? questionIndex;

  ShowAnswerEvent({this.questionIndex});
}
