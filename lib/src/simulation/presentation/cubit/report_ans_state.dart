import 'package:equatable/equatable.dart';

import '../../data/models/file_content_model.dart';
import '../../data/models/question_model.dart';

class ReportAnswerState extends Equatable {
  final Question? question;
  final List<int> selectedOptionIndices;

  const ReportAnswerState({
    this.question,
    this.selectedOptionIndices = const [],
  });

  @override
  List<Object?> get props => [question, selectedOptionIndices];

  ReportAnswerState copyWith({
    Question? question,
    List<int>? selectedOptionIndices,
  }) {
    return ReportAnswerState(
      question: question ?? this.question,
      selectedOptionIndices: selectedOptionIndices ?? this.selectedOptionIndices,
    );
  }
}
