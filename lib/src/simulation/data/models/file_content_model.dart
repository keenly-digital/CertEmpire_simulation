
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






//
// class SimulationDataModel {
//   bool? success;
//   String? message;
//   String? error;
//   SimulationData? data;
//
//   SimulationDataModel({this.success, this.message, this.error, this.data});
//
//   factory SimulationDataModel.fromJson(Map<String, dynamic> json) => SimulationDataModel(
//     success: json["Success"],
//     message: json["Message"],
//     error: json["Error"],
//     data: json["Data"] == null ? null : SimulationData.fromJson(json["Data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Success": success,
//     "Message": message,
//     "Error": error,
//     "Data": data?.toJson(),
//   };
//
//   SimulationDataModel copyWith({
//     bool? success,
//     String? message,
//     String? error,
//     SimulationData? data,
//   }) => SimulationDataModel(
//     success: success ?? this.success,
//     message: message ?? this.message,
//     error: error ?? this.error,
//     data: data ?? this.data,
//   );
// }
//
// class SimulationData {
//   String? fileId;
//   String? fileName;
//   List<Item>? items;
//
//   SimulationData({this.fileId, this.fileName, this.items});
//
//   factory SimulationData.fromJson(Map<String, dynamic> json) => SimulationData(
//     fileId: json["fileId"],
//     fileName: json["fileName"],
//     items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "fileId": fileId,
//     "fileName": fileName,
//     "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
//   };
//
//   SimulationData copyWith({
//     String? fileId,
//     String? fileName,
//     List<Item>? items,
//   }) => SimulationData(
//     fileId: fileId ?? this.fileId,
//     fileName: fileName ?? this.fileName,
//     items: items ?? this.items,
//   );
// }
//
// class Item {
//   String? type;
//   Topic? topic;
//
//   Item({this.type, this.topic});
//
//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//     type: json["type"],
//     topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "type": type,
//     "topic": topic?.toJson(),
//   };
//
//   Item copyWith({
//     String? type,
//     Topic? topic,
//   }) => Item(
//     type: type ?? this.type,
//     topic: topic ?? this.topic,
//   );
// }
//
// class Topic {
//   String? id;
//   String? fileId;
//   String? title;
//   List<TopicItem>? topicItems;
//
//   Topic({this.id, this.fileId, this.title, this.topicItems});
//
//   factory Topic.fromJson(Map<String, dynamic> json) => Topic(
//     id: json["id"],
//     fileId: json["fileId"],
//     title: json["title"],
//     topicItems: json["topicItems"] == null ? [] : List<TopicItem>.from(json["topicItems"]!.map((x) => TopicItem.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "fileId": fileId,
//     "title": title,
//     "topicItems": topicItems == null ? [] : List<dynamic>.from(topicItems!.map((x) => x.toJson())),
//   };
//
//   Topic copyWith({
//     String? id,
//     String? fileId,
//     String? title,
//     List<TopicItem>? topicItems,
//   }) => Topic(
//     id: id ?? this.id,
//     fileId: fileId ?? this.fileId,
//     title: title ?? this.title,
//     topicItems: topicItems ?? this.topicItems,
//   );
// }
//
// class TopicItem {
//   String? type;
//   CaseStudy? caseStudy;
//
//   TopicItem({this.type, this.caseStudy});
//
//   factory TopicItem.fromJson(Map<String, dynamic> json) => TopicItem(
//     type: json["type"],
//     caseStudy: json["caseStudy"] == null ? null : CaseStudy.fromJson(json["caseStudy"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "type": type,
//     "caseStudy": caseStudy?.toJson(),
//   };
//
//   TopicItem copyWith({
//     String? type,
//     CaseStudy? caseStudy,
//   }) => TopicItem(
//     type: type ?? this.type,
//     caseStudy: caseStudy ?? this.caseStudy,
//   );
// }
//
// class CaseStudy {
//   String? id;
//   String? title;
//   String? description;
//   String? fileId;
//   String? topicId;
//   List<Question>? questions;
//
//   CaseStudy({this.id, this.title, this.description, this.fileId, this.topicId, this.questions});
//
//   factory CaseStudy.fromJson(Map<String, dynamic> json) => CaseStudy(
//     id: json["id"],
//     title: json["title"],
//     description: json["description"],
//     fileId: json["fileId"],
//     topicId: json["topicId"],
//     questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "description": description,
//     "fileId": fileId,
//     "topicId": topicId,
//     "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
//   };
//
//   CaseStudy copyWith({
//     String? id,
//     String? title,
//     String? description,
//     String? fileId,
//     String? topicId,
//     List<Question>? questions,
//   }) => CaseStudy(
//     id: id ?? this.id,
//     title: title ?? this.title,
//     description: description ?? this.description,
//     fileId: fileId ?? this.fileId,
//     topicId: topicId ?? this.topicId,
//     questions: questions ?? this.questions,
//   );
// }
//
// class Question {
//   int? q;
//   int? id;
//   String? questionText;
//   String? questionDescription;
//   List<String>? options;
//   List<int>? correctAnswerIndices;
//   String? answerDescription;
//   String? answerExplanation;
//   bool? showAnswer;
//   String? questionImageUrl;
//   String? answerImageUrl;
//   String? topicId;
//   String? caseStudyId;
//
//   Question({
//     this.q,
//     this.id,
//     this.questionText,
//     this.questionDescription,
//     this.options,
//     this.correctAnswerIndices,
//     this.answerDescription,
//     this.answerExplanation,
//     this.showAnswer,
//     this.questionImageUrl,
//     this.answerImageUrl,
//     this.topicId,
//     this.caseStudyId,
//   });
//
//   factory Question.fromJson(Map<String, dynamic> json) => Question(
//     q: json["q"],
//     id: json["id"],
//     questionText: json["questionText"],
//     questionDescription: json["questionDescription"],
//     options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
//     correctAnswerIndices: json["correctAnswerIndices"] == null ? [] : List<int>.from(json["correctAnswerIndices"]!.map((x) => x)),
//     answerDescription: json["answerDescription"],
//     answerExplanation: json["answerExplanation"],
//     showAnswer: json["showAnswer"],
//     questionImageUrl: json["questionImageURL"],
//     answerImageUrl: json["answerImageURL"],
//     topicId: json["topicId"],
//     caseStudyId: json["caseStudyId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "q": q,
//     "id": id,
//     "questionText": questionText,
//     "questionDescription": questionDescription,
//     "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
//     "correctAnswerIndices": correctAnswerIndices == null ? [] : List<dynamic>.from(correctAnswerIndices!.map((x) => x)),
//     "answerDescription": answerDescription,
//     "answerExplanation": answerExplanation,
//     "showAnswer": showAnswer,
//     "questionImageURL": questionImageUrl,
//     "answerImageURL": answerImageUrl,
//     "topicId": topicId,
//     "caseStudyId": caseStudyId,
//   };
//
//   Question copyWith({
//     int? q,
//     int? id,
//     String? questionText,
//     String? questionDescription,
//     List<String>? options,
//     List<int>? correctAnswerIndices,
//     String? answerDescription,
//     String? answerExplanation,
//     bool? showAnswer,
//     String? questionImageUrl,
//     String? answerImageUrl,
//     String? topicId,
//     String? caseStudyId,
//   }) => Question(
//     q: q ?? this.q,
//     id: id ?? this.id,
//     questionText: questionText ?? this.questionText,
//     questionDescription: questionDescription ?? this.questionDescription,
//     options: options ?? this.options,
//     correctAnswerIndices: correctAnswerIndices ?? this.correctAnswerIndices,
//     answerDescription: answerDescription ?? this.answerDescription,
//     answerExplanation: answerExplanation ?? this.answerExplanation,
//     showAnswer: showAnswer ?? this.showAnswer,
//     questionImageUrl: questionImageUrl ?? this.questionImageUrl,
//     answerImageUrl: answerImageUrl ?? this.answerImageUrl,
//     topicId: topicId ?? this.topicId,
//     caseStudyId: caseStudyId ?? this.caseStudyId,
//   );
// }
