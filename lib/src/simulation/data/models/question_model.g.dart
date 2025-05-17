// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      id: (json['id'] as num).toInt(),
      fileId: json['fileId'] as String? ?? '',
      q: (json['q'] as num?)?.toInt() ?? 0,
      caseStudyId: json['caseStudyId'] as String? ?? '',
      topicId: json['topicId'] as String? ?? '',
      questionText: json['questionText'] as String? ?? '',
      questionDescription: json['questionDescription'] as String? ?? '',
      questionImageURL: json['questionImageURL'] as String?,
      answerImageURL: json['answerImageURL'] as String?,
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => e as String?)
              .toList() ??
          const [],
      correctAnswerIndices:
          (json['correctAnswerIndices'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      answerDescription: json['answerDescription'] as String? ?? '',
      answerExplanation: json['answerExplanation'] as String? ?? '',
      isMultiSelect: json['isMultiSelect'] as bool? ?? false,
      userAnswerIndices:
          (json['userAnswerIndices'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList(),
      isAttempted: json['isAttempted'] as bool? ?? false,
      showAnswer: json['showAnswer'] as bool? ?? false,
      timeTaken: (json['timeTaken'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileId': instance.fileId,
      'q': instance.q,
      'caseStudyId': instance.caseStudyId,
      'topicId': instance.topicId,
      'questionText': instance.questionText,
      'questionDescription': instance.questionDescription,
      'questionImageURL': instance.questionImageURL,
      'answerImageURL': instance.answerImageURL,
      'options': instance.options,
      'correctAnswerIndices': instance.correctAnswerIndices,
      'answerDescription': instance.answerDescription,
      'answerExplanation': instance.answerExplanation,
      'isMultiSelect': instance.isMultiSelect,
      'userAnswerIndices': instance.userAnswerIndices,
      'isAttempted': instance.isAttempted,
      'showAnswer': instance.showAnswer,
      'timeTaken': instance.timeTaken,
    };

_$OptionImpl _$$OptionImplFromJson(Map<String, dynamic> json) => _$OptionImpl(
  text: json['text'] as String? ?? '',
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$$OptionImplToJson(_$OptionImpl instance) =>
    <String, dynamic>{'text': instance.text, 'imageUrl': instance.imageUrl};
