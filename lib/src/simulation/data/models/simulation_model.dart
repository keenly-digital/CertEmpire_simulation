
class SimulationDataModel {
  bool? success;
  String? message;
  String? error;
  SimulationData? data;

  SimulationDataModel({this.success, this.message, this.error, this.data});

  factory SimulationDataModel.fromJson(Map<String, dynamic> json) => SimulationDataModel(
    success: json["Success"],
    message: json["Message"],
    error: json["Error"],
    data: json["Data"] == null ? null : SimulationData.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Error": error,
    "Data": data?.toJson(),
  };

  SimulationDataModel copyWith({
    bool? success,
    String? message,
    String? error,
    SimulationData? data,
  }) => SimulationDataModel(
    success: success ?? this.success,
    message: message ?? this.message,
    error: error ?? this.error,
    data: data ?? this.data,
  );
}

class SimulationData {
  String? fileId;
  String? fileName;
  List<Item>? items;

  SimulationData({this.fileId, this.fileName, this.items});

  factory SimulationData.fromJson(Map<String, dynamic> json) => SimulationData(
    fileId: json["fileId"],
    fileName: json["fileName"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fileId": fileId,
    "fileName": fileName,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };

  SimulationData copyWith({
    String? fileId,
    String? fileName,
    List<Item>? items,
  }) => SimulationData(
    fileId: fileId ?? this.fileId,
    fileName: fileName ?? this.fileName,
    items: items ?? this.items,
  );
}

class Item {
  String? type;
  Topic? topic;

  Item({this.type, this.topic});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    type: json["type"],
    topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "topic": topic?.toJson(),
  };

  Item copyWith({
    String? type,
    Topic? topic,
  }) => Item(
    type: type ?? this.type,
    topic: topic ?? this.topic,
  );
}

class Topic {
  String? id;
  String? fileId;
  String? title;
  List<TopicItem>? topicItems;

  Topic({this.id, this.fileId, this.title, this.topicItems});

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    id: json["id"],
    fileId: json["fileId"],
    title: json["title"],
    topicItems: json["topicItems"] == null ? [] : List<TopicItem>.from(json["topicItems"]!.map((x) => TopicItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fileId": fileId,
    "title": title,
    "topicItems": topicItems == null ? [] : List<dynamic>.from(topicItems!.map((x) => x.toJson())),
  };

  Topic copyWith({
    String? id,
    String? fileId,
    String? title,
    List<TopicItem>? topicItems,
  }) => Topic(
    id: id ?? this.id,
    fileId: fileId ?? this.fileId,
    title: title ?? this.title,
    topicItems: topicItems ?? this.topicItems,
  );
}

class TopicItem {
  String? type;
  CaseStudy? caseStudy;

  TopicItem({this.type, this.caseStudy});

  factory TopicItem.fromJson(Map<String, dynamic> json) => TopicItem(
    type: json["type"],
    caseStudy: json["caseStudy"] == null ? null : CaseStudy.fromJson(json["caseStudy"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "caseStudy": caseStudy?.toJson(),
  };

  TopicItem copyWith({
    String? type,
    CaseStudy? caseStudy,
  }) => TopicItem(
    type: type ?? this.type,
    caseStudy: caseStudy ?? this.caseStudy,
  );
}

class CaseStudy {
  String? id;
  String? title;
  String? description;
  String? fileId;
  String? topicId;
  List<Question>? questions;

  CaseStudy({this.id, this.title, this.description, this.fileId, this.topicId, this.questions});

  factory CaseStudy.fromJson(Map<String, dynamic> json) => CaseStudy(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    fileId: json["fileId"],
    topicId: json["topicId"],
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "fileId": fileId,
    "topicId": topicId,
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };

  CaseStudy copyWith({
    String? id,
    String? title,
    String? description,
    String? fileId,
    String? topicId,
    List<Question>? questions,
  }) => CaseStudy(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    fileId: fileId ?? this.fileId,
    topicId: topicId ?? this.topicId,
    questions: questions ?? this.questions,
  );
}

class Question {
  int? q;
  int? id;
  String? questionText;
  String? questionDescription;
  List<String>? options;
  List<int>? correctAnswerIndices;
  String? answerDescription;
  String? answerExplanation;
  bool? showAnswer;
  String? questionImageUrl;
  String? answerImageUrl;
  String? topicId;
  String? caseStudyId;

  Question({
    this.q,
    this.id,
    this.questionText,
    this.questionDescription,
    this.options,
    this.correctAnswerIndices,
    this.answerDescription,
    this.answerExplanation,
    this.showAnswer,
    this.questionImageUrl,
    this.answerImageUrl,
    this.topicId,
    this.caseStudyId,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    q: json["q"],
    id: json["id"],
    questionText: json["questionText"],
    questionDescription: json["questionDescription"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    correctAnswerIndices: json["correctAnswerIndices"] == null ? [] : List<int>.from(json["correctAnswerIndices"]!.map((x) => x)),
    answerDescription: json["answerDescription"],
    answerExplanation: json["answerExplanation"],
    showAnswer: json["showAnswer"],
    questionImageUrl: json["questionImageURL"],
    answerImageUrl: json["answerImageURL"],
    topicId: json["topicId"],
    caseStudyId: json["caseStudyId"],
  );

  Map<String, dynamic> toJson() => {
    "q": q,
    "id": id,
    "questionText": questionText,
    "questionDescription": questionDescription,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "correctAnswerIndices": correctAnswerIndices == null ? [] : List<dynamic>.from(correctAnswerIndices!.map((x) => x)),
    "answerDescription": answerDescription,
    "answerExplanation": answerExplanation,
    "showAnswer": showAnswer,
    "questionImageURL": questionImageUrl,
    "answerImageURL": answerImageUrl,
    "topicId": topicId,
    "caseStudyId": caseStudyId,
  };

  Question copyWith({
    int? q,
    int? id,
    String? questionText,
    String? questionDescription,
    List<String>? options,
    List<int>? correctAnswerIndices,
    String? answerDescription,
    String? answerExplanation,
    bool? showAnswer,
    String? questionImageUrl,
    String? answerImageUrl,
    String? topicId,
    String? caseStudyId,
  }) => Question(
    q: q ?? this.q,
    id: id ?? this.id,
    questionText: questionText ?? this.questionText,
    questionDescription: questionDescription ?? this.questionDescription,
    options: options ?? this.options,
    correctAnswerIndices: correctAnswerIndices ?? this.correctAnswerIndices,
    answerDescription: answerDescription ?? this.answerDescription,
    answerExplanation: answerExplanation ?? this.answerExplanation,
    showAnswer: showAnswer ?? this.showAnswer,
    questionImageUrl: questionImageUrl ?? this.questionImageUrl,
    answerImageUrl: answerImageUrl ?? this.answerImageUrl,
    topicId: topicId ?? this.topicId,
    caseStudyId: caseStudyId ?? this.caseStudyId,
  );
}
