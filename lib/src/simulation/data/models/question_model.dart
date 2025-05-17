import 'package:collection/collection.dart'; // For SetEquality
import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_model.freezed.dart';

part 'question_model.g.dart';

@freezed
class Question with _$Question {
  const factory Question({
    required int id,
    @Default('') String fileId,
    @Default(0) int q,
    @Default('') String caseStudyId,
    @Default('') String topicId,
    @Default('') String questionText,
    @Default('') String questionDescription,
    String? questionImageURL,
    String? answerImageURL,
    @Default([]) List<String?> options,
    @Default([]) List<int> correctAnswerIndices,
    @Default('') String answerDescription,
    @Default('') String answerExplanation,
    @Default(false) bool isMultiSelect,
    List<int>? userAnswerIndices,
    @Default(false) bool isAttempted,
    @Default(false) bool showAnswer,
    int? timeTaken,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}

@freezed
class Option with _$Option {
  const factory Option({
    @Default('') String text,
    String? imageUrl,
  }) = _Option;

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
}

extension QuestionHelpers on Question {
  /// Reset the question state
  Question resetAnswer() {
    return copyWith(
      userAnswerIndices: null,
      isAttempted: false,
      timeTaken: null,
    );
  }

  bool isNew() {
    return id == 1;
  }

  bool hasTopic() {
    return (topicId.isNotEmpty &&
        topicId != "00000000-0000-0000-0000-000000000000");
  }

  bool hasCaseStudy() {
    return (caseStudyId.isNotEmpty &&
        caseStudyId != "00000000-0000-0000-0000-000000000000");
  }

  List<int> get correctAnswerIndicesOneBased =>
      correctAnswerIndices.map((index) => index + 1).toList();


  bool hasValidQuestionImage() {
    if (questionImageURL == null || questionImageURL!.isEmpty) return false;

    final uri = Uri.tryParse(questionImageURL!);
    return uri != null && uri.hasAbsolutePath && (uri.isScheme("http") || uri.isScheme("https"));
  }


  /// Reset the question state
  Question resetQuestion() {
    return copyWith(
      id: -1,
      answerDescription: '',
      answerExplanation: '',
      isMultiSelect: false,
      questionText: '',
      questionDescription: '',
      questionImageURL: null,
      answerImageURL: null,
      options: [],
      correctAnswerIndices: [],
      showAnswer: false,
      userAnswerIndices: null,
      isAttempted: false,
      timeTaken: null,
    );
  }

  /// Get options with highlighting (correct, selected, etc.)
  List<Map<String, dynamic>> getHighlightedOptions() {
    return options.asMap().entries.map((entry) {
      int index = entry.key;
      String text = entry.value ?? "";
      return {
        'text': text,
        'isCorrect': correctAnswerIndices.contains(index),
        'isSelected': userAnswerIndices?.contains(index) ?? false,
      };
    }).toList();
  }

  /// Calculate the score for this question
  int calculateScore() {
    return isAnswerCorrect() ? 5 : 0; // Adjust the score logic as needed
  }

  /// Check if the user's answers are correct
  bool isAnswerCorrect() {
    if (!isAttempted || userAnswerIndices == null) return false;

    if (isMultiSelect) {
      return const SetEquality<int>().equals(
        userAnswerIndices!.toSet(),
        correctAnswerIndices.toSet(),
      );
    } else {
      return userAnswerIndices!.length == 1 &&
          userAnswerIndices!.first == correctAnswerIndices.first;
    }
  }
}

extension QuestionBuilder on Question {
  /// Helper methods for incremental construction

  /// Set or update the `id`
  Question withId(int id) => copyWith(id: id);

  Question withFileId(String fileId) => copyWith(fileId: fileId);

  /// Set or update the `questionText`
  Question withQuestionText(String questionText) =>
      copyWith(questionText: questionText);

  /// Set or update the `questionDescription`
  Question withQuestionDescription(String questionDescription) =>
      copyWith(questionDescription: questionDescription);

  /// Set or update the `imageURL`
  Question withImageURL(String? imageURL) =>
      copyWith(questionImageURL: imageURL);

  /// Set or update the `options`
  Question withOptions(List<String> options) => copyWith(options: options);

  /// Set or update the `correctAnswerIndices`
  Question withCorrectAnswerIndices(List<int> correctAnswerIndices) =>
      copyWith(correctAnswerIndices: correctAnswerIndices);

  /// Set or update the `answerDescription`
  Question withAnswerDescription(String answerDescription) =>
      copyWith(answerDescription: answerDescription);

  /// Set or update the `explanation`
  Question withExplanation(String explanation) =>
      copyWith(answerExplanation: explanation);

  /// Set or update the `isMultiSelect`
  Question withIsMultiSelect(bool isMultiSelect) =>
      copyWith(isMultiSelect: isMultiSelect);

  /// Set or update the `userAnswerIndices`
  Question withUserAnswerIndices(List<int>? userAnswerIndices) =>
      copyWith(userAnswerIndices: userAnswerIndices);

  /// Set or update the `isAttempted`
  Question withIsAttempted(bool isAttempted) =>
      copyWith(isAttempted: isAttempted);

  /// Set or update the `showAnswer`
  Question withShowAnswer(bool showAnswer) => copyWith(showAnswer: showAnswer);

  /// Set or update the `timeTaken`
  Question withTimeTaken(int? timeTaken) => copyWith(timeTaken: timeTaken);
}
