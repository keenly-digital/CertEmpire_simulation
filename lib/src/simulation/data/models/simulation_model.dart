class SimulationDataModel {
  bool? success;
  String? message;
  String? error;
  SimulationData? data;

  SimulationDataModel({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  factory SimulationDataModel.fromJson(Map<String, dynamic> json) =>
      SimulationDataModel(
        success: json["Success"] ?? false,
        message: json["Message"] ?? "",
        error: json["Error"] ?? "",
        data:
        json["Data"] == null ? null : SimulationData.fromJson(json["Data"]),
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
  }) {
    return SimulationDataModel(
      success: success ?? this.success,
      message: message ?? this.message,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class SimulationData {
  String? examTitle;
  List<Question>? questions;

  SimulationData({
    this.examTitle,
    this.questions,
  });

  factory SimulationData.fromJson(Map<String, dynamic> json) => SimulationData(
    examTitle: json["examTitle"],
    questions: json["questions"] == null
        ? []
        : List<Question>.from(
        json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "examTitle": examTitle,
    "questions": questions == null
        ? []
        : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };

  SimulationData copyWith({
    String? examTitle,
    List<Question>? questions,
  }) {
    return SimulationData(
      examTitle: examTitle ?? this.examTitle,
      questions: questions ?? this.questions,
    );
  }
}

class Question {
  int? id;
  String? questionText;
  String? questionDescription;
  List<String>? options;
  List<int>? correctAnswerIndices;
  String? explanation;
  bool? showAnswer;
  String? questionImageUrl;
  String? answerImageUrl;
  String? timeTaken;
  int? q;

  Question({
    this.id,
    this.questionText,
    this.questionDescription,
    this.options,
    this.correctAnswerIndices,
    this.explanation,
    this.showAnswer,
    this.questionImageUrl,
    this.answerImageUrl,
    this.timeTaken,
    this.q,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    questionText: json["questionText"],
    questionDescription: json["questionDescription"],
    options: json["options"] == null
        ? []
        : List<String>.from(json["options"]!.map((x) => x)),
    correctAnswerIndices: json["correctAnswerIndices"] == null
        ? []
        : List<int>.from(json["correctAnswerIndices"]!.map((x) => x)),
    explanation: json["explanation"],
    showAnswer: json["showAnswer"],
    questionImageUrl: json["questionImageURL"],
    answerImageUrl: json["answerImageURL"],
    timeTaken: json["timeTaken"],
    q: json["q"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionText": questionText,
    "questionDescription": questionDescription,
    "options": options == null
        ? []
        : List<dynamic>.from(options!.map((x) => x)),
    "correctAnswerIndices": correctAnswerIndices == null
        ? []
        : List<dynamic>.from(correctAnswerIndices!.map((x) => x)),
    "explanation": explanation,
    "showAnswer": showAnswer,
    "questionImageURL": questionImageUrl,
    "answerImageURL": answerImageUrl,
    "timeTaken": timeTaken,
    "q": q,
  };

  Question copyWith({
    int? id,
    String? questionText,
    String? questionDescription,
    List<String>? options,
    List<int>? correctAnswerIndices,
    String? explanation,
    bool? showAnswer,
    String? questionImageUrl,
    String? answerImageUrl,
    String? timeTaken,
    int? q,
  }) {
    return Question(
      id: id ?? this.id,
      questionText: questionText ?? this.questionText,
      questionDescription: questionDescription ?? this.questionDescription,
      options: options ?? this.options,
      correctAnswerIndices: correctAnswerIndices ?? this.correctAnswerIndices,
      explanation: explanation ?? this.explanation,
      showAnswer: showAnswer ?? this.showAnswer,
      questionImageUrl: questionImageUrl ?? this.questionImageUrl,
      answerImageUrl: answerImageUrl ?? this.answerImageUrl,
      timeTaken: timeTaken ?? this.timeTaken,
      q: q ?? this.q,
    );
  }
}
