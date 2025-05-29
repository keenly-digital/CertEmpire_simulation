
import 'package:certempiree/src/simulation/data/models/question_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_content_model.freezed.dart';

part 'file_content_model.g.dart';

class CommonItem {
  final String type;
  final Question? question;
  final Topic? topic;
  final CaseStudy? caseStudy;

  CommonItem._({
    required this.type,
    this.question,
    this.topic,
    this.caseStudy,
  });

  /// Factory constructor for a `Question` item.
  factory CommonItem.question(Question question) {
    return CommonItem._(
      type: 'question',
      question: question,
    );
  }

  /// Factory constructor for a `Topic` item.
  factory CommonItem.topic(Topic topic) {
    return CommonItem._(
      type: 'topic',
      topic: topic,
    );
  }

  /// Factory constructor for a `CaseStudy` item.
  factory CommonItem.caseStudy(CaseStudy caseStudy) {
    return CommonItem._(
      type: 'caseStudy',
      caseStudy: caseStudy,
    );
  }

  /// Custom fromJson implementation to parse based on 'type'.
  factory CommonItem.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;

    switch (type) {
      case 'question':
        return CommonItem.question(Question.fromJson(json['question']));
      case 'topic':
        return CommonItem.topic(Topic.fromJson(json['topic']));
      case 'caseStudy':
        return CommonItem.caseStudy(CaseStudy.fromJson(json['caseStudy']));
      default:
        throw UnsupportedError('Unknown type: $type');
    }
  }

  /// Serializes the `CommonItem` to JSON.
  Map<String, dynamic> toJson() {
    switch (type) {
      case 'question':
        return {
          'type': 'question',
          'question': question?.toJson(),
        };
      case 'topic':
        return {
          'type': 'topic',
          'topic': topic?.toJson(),
        };
      case 'caseStudy':
        return {
          'type': 'caseStudy',
          'caseStudy': caseStudy?.toJson(),
        };
      default:
        throw UnsupportedError('Unknown type: $type');
    }
  }

  /// Applies an action based on the type of `CommonItem`.
  T when<T>({
    required T Function(Question question) question,
    required T Function(Topic topic) topic,
    required T Function(CaseStudy caseStudy) caseStudy,
  }) {
    if (type == 'question' && this.question != null) {
      return question(this.question!);
    } else if (type == 'topic' && this.topic != null) {
      return topic(this.topic!);
    } else if (type == 'caseStudy' && this.caseStudy != null) {
      return caseStudy(this.caseStudy!);
    } else {
      throw UnsupportedError('Unhandled type: $type');
    }
  }

  /// A utility function for safely extracting nested JSON.
  static Map<String, dynamic> _safeExtract(
      Map<String, dynamic> json, String key) {
    try {
      final value = json[key];
      if (value == null) {
        throw FormatException('Missing or null value for key: $key');
      }
      return value as Map<String, dynamic>;
    } catch (e) {
      throw FormatException('Error extracting key "$key": ${e.toString()}');
    }
  }

  /// A copyWith method for creating modified copies of `CommonItem`.
  CommonItem copyWith({
    String? type,
    Question? question,
    Topic? topic,
    CaseStudy? caseStudy,
  }) {
    return CommonItem._(
      type: type ?? this.type,
      question: question ?? this.question,
      topic: topic ?? this.topic,
      caseStudy: caseStudy ?? this.caseStudy,
    );
  }
}

@freezed
class FileContent with _$FileContent {
  const factory FileContent({
    @Default('') String fileId,
    @Default('') String fileName,
    @Default([]) List<CommonItem> items,
  }) = _FileContent;

  factory FileContent.fromJson(Map<String, dynamic> json) =>
      _$FileContentFromJson(json);
}

@freezed
class Topic with _$Topic {
  const factory Topic({
    @Default('') String id,
    @Default('') String fileId,
    @Default('') String title,
    @Default([]) List<CommonItem>? topicItems,
  }) = _Topic;

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
}

@freezed
class CaseStudy with _$CaseStudy {
  const factory CaseStudy({
    @Default('00000000-0000-0000-0000-000000000000') String id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String fileId,
    @Default('00000000-0000-0000-0000-000000000000') String topicId,
    @Default('') String caseStudyId,
    @Default([]) List<Question>? questions,
  }) = _CaseStudy;

  factory CaseStudy.fromJson(Map<String, dynamic> json) =>
      _$CaseStudyFromJson(json);
}

extension TopicHelper on Topic {
  Topic withName(String title) => copyWith(title: title);

  bool isNew() {
    return (id == '00000000-0000-0000-0000-000000000000' || id.isEmpty);
  }

  int getCaseStudyCount() {
    int count = 0;
    if (topicItems != null) {
      for (CommonItem t in topicItems!) {
        if (t.type == "caseStudy") {
          count++;
        }
      }
    }
    return count;
  }

  int getQuestionsCount() {
    int count = 0;
    if (topicItems != null) {
      for (CommonItem t in topicItems!) {
        if (t.type == "question") {
          count++;
        }
      }
    }
    return count;
  }
}

extension CaseStudyHelper on CaseStudy {
  bool isNew() {
    return (id == '00000000-0000-0000-0000-000000000000' || id.isEmpty);
  }

  bool hasTopic() {
    return (topicId != '00000000-0000-0000-0000-000000000000' &&
        topicId.isNotEmpty);
  }
}

extension ExamModelHelpers on FileContent {
  bool hasContent() {
    return items.isNotEmpty;
  }
}
