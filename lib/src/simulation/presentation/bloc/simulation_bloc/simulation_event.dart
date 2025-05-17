import '../../../data/models/file_content_model.dart';

abstract class SimulationEvent {}

class FetchSimulationDataEvent extends SimulationEvent {
  final String? fieldId;

  FetchSimulationDataEvent({this.fieldId});
}

class ShowAnswerEvent extends SimulationEvent {
  final int? questionIndex;

  ShowAnswerEvent({this.questionIndex});
}

