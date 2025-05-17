// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FileContentImpl _$$FileContentImplFromJson(Map<String, dynamic> json) =>
    _$FileContentImpl(
      fileId: json['fileId'] as String? ?? '',
      fileName: json['fileName'] as String? ?? '',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => CommonItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$FileContentImplToJson(_$FileContentImpl instance) =>
    <String, dynamic>{
      'fileId': instance.fileId,
      'fileName': instance.fileName,
      'items': instance.items,
    };

_$TopicImpl _$$TopicImplFromJson(Map<String, dynamic> json) => _$TopicImpl(
  id: json['id'] as String? ?? '',
  fileId: json['fileId'] as String? ?? '',
  title: json['title'] as String? ?? '',
  topicItems:
      (json['topicItems'] as List<dynamic>?)
          ?.map((e) => CommonItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TopicImplToJson(_$TopicImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileId': instance.fileId,
      'title': instance.title,
      'topicItems': instance.topicItems,
    };

_$CaseStudyImpl _$$CaseStudyImplFromJson(Map<String, dynamic> json) =>
    _$CaseStudyImpl(
      id: json['id'] as String? ?? '00000000-0000-0000-0000-000000000000',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      fileId: json['fileId'] as String? ?? '',
      topicId:
          json['topicId'] as String? ?? '00000000-0000-0000-0000-000000000000',
      caseStudyId: json['caseStudyId'] as String? ?? '',
      questions:
          (json['questions'] as List<dynamic>?)
              ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CaseStudyImplToJson(_$CaseStudyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'fileId': instance.fileId,
      'topicId': instance.topicId,
      'caseStudyId': instance.caseStudyId,
      'questions': instance.questions,
    };
