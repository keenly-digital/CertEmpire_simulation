import 'package:equatable/equatable.dart';



import '../../../data/models/file_content_model.dart';



sealed class SimulationInitState extends Equatable {}



class SimulationState extends SimulationInitState {

final FileContent? simulationData;

final bool loading;

final bool success;

final String? errorMessage;

final int? totalItemLength;



SimulationState({

this.simulationData,

this.loading = false,

this.success = false,

this.errorMessage,

this.totalItemLength

});



SimulationState copyWith({

FileContent? simulationData,

bool? loading,

bool? success,

String? errorMessage,

int? totalItemLength,

}) {

return SimulationState(

simulationData: simulationData ?? this.simulationData,

totalItemLength: totalItemLength ?? this.totalItemLength,

loading: loading ?? this.loading,

success: success ?? this.success,

errorMessage: errorMessage ?? this.errorMessage,

);

}



@override

List<Object?> get props => [simulationData, loading, success, errorMessage,totalItemLength];

}