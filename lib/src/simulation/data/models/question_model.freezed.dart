// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return _Question.fromJson(json);
}

/// @nodoc
mixin _$Question {
  int get id => throw _privateConstructorUsedError;
  String get fileId => throw _privateConstructorUsedError;
  int get q => throw _privateConstructorUsedError;
  String get caseStudyId => throw _privateConstructorUsedError;
  String get topicId => throw _privateConstructorUsedError;
  String get questionText => throw _privateConstructorUsedError;
  String get questionDescription => throw _privateConstructorUsedError;
  String? get questionImageURL => throw _privateConstructorUsedError;
  String? get answerImageURL => throw _privateConstructorUsedError;
  List<String?> get options => throw _privateConstructorUsedError;
  List<int> get correctAnswerIndices => throw _privateConstructorUsedError;
  String get answerDescription => throw _privateConstructorUsedError;
  String get answerExplanation => throw _privateConstructorUsedError;
  bool get isMultiSelect => throw _privateConstructorUsedError;
  List<int>? get userAnswerIndices => throw _privateConstructorUsedError;
  bool get isAttempted => throw _privateConstructorUsedError;
  bool get showAnswer => throw _privateConstructorUsedError;
  int? get timeTaken => throw _privateConstructorUsedError;

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionCopyWith<Question> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res, Question>;
  @useResult
  $Res call({
    int id,
    String fileId,
    int q,
    String caseStudyId,
    String topicId,
    String questionText,
    String questionDescription,
    String? questionImageURL,
    String? answerImageURL,
    List<String?> options,
    List<int> correctAnswerIndices,
    String answerDescription,
    String answerExplanation,
    bool isMultiSelect,
    List<int>? userAnswerIndices,
    bool isAttempted,
    bool showAnswer,
    int? timeTaken,
  });
}

/// @nodoc
class _$QuestionCopyWithImpl<$Res, $Val extends Question>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fileId = null,
    Object? q = null,
    Object? caseStudyId = null,
    Object? topicId = null,
    Object? questionText = null,
    Object? questionDescription = null,
    Object? questionImageURL = freezed,
    Object? answerImageURL = freezed,
    Object? options = null,
    Object? correctAnswerIndices = null,
    Object? answerDescription = null,
    Object? answerExplanation = null,
    Object? isMultiSelect = null,
    Object? userAnswerIndices = freezed,
    Object? isAttempted = null,
    Object? showAnswer = null,
    Object? timeTaken = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            fileId:
                null == fileId
                    ? _value.fileId
                    : fileId // ignore: cast_nullable_to_non_nullable
                        as String,
            q:
                null == q
                    ? _value.q
                    : q // ignore: cast_nullable_to_non_nullable
                        as int,
            caseStudyId:
                null == caseStudyId
                    ? _value.caseStudyId
                    : caseStudyId // ignore: cast_nullable_to_non_nullable
                        as String,
            topicId:
                null == topicId
                    ? _value.topicId
                    : topicId // ignore: cast_nullable_to_non_nullable
                        as String,
            questionText:
                null == questionText
                    ? _value.questionText
                    : questionText // ignore: cast_nullable_to_non_nullable
                        as String,
            questionDescription:
                null == questionDescription
                    ? _value.questionDescription
                    : questionDescription // ignore: cast_nullable_to_non_nullable
                        as String,
            questionImageURL:
                freezed == questionImageURL
                    ? _value.questionImageURL
                    : questionImageURL // ignore: cast_nullable_to_non_nullable
                        as String?,
            answerImageURL:
                freezed == answerImageURL
                    ? _value.answerImageURL
                    : answerImageURL // ignore: cast_nullable_to_non_nullable
                        as String?,
            options:
                null == options
                    ? _value.options
                    : options // ignore: cast_nullable_to_non_nullable
                        as List<String?>,
            correctAnswerIndices:
                null == correctAnswerIndices
                    ? _value.correctAnswerIndices
                    : correctAnswerIndices // ignore: cast_nullable_to_non_nullable
                        as List<int>,
            answerDescription:
                null == answerDescription
                    ? _value.answerDescription
                    : answerDescription // ignore: cast_nullable_to_non_nullable
                        as String,
            answerExplanation:
                null == answerExplanation
                    ? _value.answerExplanation
                    : answerExplanation // ignore: cast_nullable_to_non_nullable
                        as String,
            isMultiSelect:
                null == isMultiSelect
                    ? _value.isMultiSelect
                    : isMultiSelect // ignore: cast_nullable_to_non_nullable
                        as bool,
            userAnswerIndices:
                freezed == userAnswerIndices
                    ? _value.userAnswerIndices
                    : userAnswerIndices // ignore: cast_nullable_to_non_nullable
                        as List<int>?,
            isAttempted:
                null == isAttempted
                    ? _value.isAttempted
                    : isAttempted // ignore: cast_nullable_to_non_nullable
                        as bool,
            showAnswer:
                null == showAnswer
                    ? _value.showAnswer
                    : showAnswer // ignore: cast_nullable_to_non_nullable
                        as bool,
            timeTaken:
                freezed == timeTaken
                    ? _value.timeTaken
                    : timeTaken // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionImplCopyWith<$Res>
    implements $QuestionCopyWith<$Res> {
  factory _$$QuestionImplCopyWith(
    _$QuestionImpl value,
    $Res Function(_$QuestionImpl) then,
  ) = __$$QuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String fileId,
    int q,
    String caseStudyId,
    String topicId,
    String questionText,
    String questionDescription,
    String? questionImageURL,
    String? answerImageURL,
    List<String?> options,
    List<int> correctAnswerIndices,
    String answerDescription,
    String answerExplanation,
    bool isMultiSelect,
    List<int>? userAnswerIndices,
    bool isAttempted,
    bool showAnswer,
    int? timeTaken,
  });
}

/// @nodoc
class __$$QuestionImplCopyWithImpl<$Res>
    extends _$QuestionCopyWithImpl<$Res, _$QuestionImpl>
    implements _$$QuestionImplCopyWith<$Res> {
  __$$QuestionImplCopyWithImpl(
    _$QuestionImpl _value,
    $Res Function(_$QuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fileId = null,
    Object? q = null,
    Object? caseStudyId = null,
    Object? topicId = null,
    Object? questionText = null,
    Object? questionDescription = null,
    Object? questionImageURL = freezed,
    Object? answerImageURL = freezed,
    Object? options = null,
    Object? correctAnswerIndices = null,
    Object? answerDescription = null,
    Object? answerExplanation = null,
    Object? isMultiSelect = null,
    Object? userAnswerIndices = freezed,
    Object? isAttempted = null,
    Object? showAnswer = null,
    Object? timeTaken = freezed,
  }) {
    return _then(
      _$QuestionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        fileId:
            null == fileId
                ? _value.fileId
                : fileId // ignore: cast_nullable_to_non_nullable
                    as String,
        q:
            null == q
                ? _value.q
                : q // ignore: cast_nullable_to_non_nullable
                    as int,
        caseStudyId:
            null == caseStudyId
                ? _value.caseStudyId
                : caseStudyId // ignore: cast_nullable_to_non_nullable
                    as String,
        topicId:
            null == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                    as String,
        questionText:
            null == questionText
                ? _value.questionText
                : questionText // ignore: cast_nullable_to_non_nullable
                    as String,
        questionDescription:
            null == questionDescription
                ? _value.questionDescription
                : questionDescription // ignore: cast_nullable_to_non_nullable
                    as String,
        questionImageURL:
            freezed == questionImageURL
                ? _value.questionImageURL
                : questionImageURL // ignore: cast_nullable_to_non_nullable
                    as String?,
        answerImageURL:
            freezed == answerImageURL
                ? _value.answerImageURL
                : answerImageURL // ignore: cast_nullable_to_non_nullable
                    as String?,
        options:
            null == options
                ? _value._options
                : options // ignore: cast_nullable_to_non_nullable
                    as List<String?>,
        correctAnswerIndices:
            null == correctAnswerIndices
                ? _value._correctAnswerIndices
                : correctAnswerIndices // ignore: cast_nullable_to_non_nullable
                    as List<int>,
        answerDescription:
            null == answerDescription
                ? _value.answerDescription
                : answerDescription // ignore: cast_nullable_to_non_nullable
                    as String,
        answerExplanation:
            null == answerExplanation
                ? _value.answerExplanation
                : answerExplanation // ignore: cast_nullable_to_non_nullable
                    as String,
        isMultiSelect:
            null == isMultiSelect
                ? _value.isMultiSelect
                : isMultiSelect // ignore: cast_nullable_to_non_nullable
                    as bool,
        userAnswerIndices:
            freezed == userAnswerIndices
                ? _value._userAnswerIndices
                : userAnswerIndices // ignore: cast_nullable_to_non_nullable
                    as List<int>?,
        isAttempted:
            null == isAttempted
                ? _value.isAttempted
                : isAttempted // ignore: cast_nullable_to_non_nullable
                    as bool,
        showAnswer:
            null == showAnswer
                ? _value.showAnswer
                : showAnswer // ignore: cast_nullable_to_non_nullable
                    as bool,
        timeTaken:
            freezed == timeTaken
                ? _value.timeTaken
                : timeTaken // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionImpl implements _Question {
  const _$QuestionImpl({
    required this.id,
    this.fileId = '',
    this.q = 0,
    this.caseStudyId = '',
    this.topicId = '',
    this.questionText = '',
    this.questionDescription = '',
    this.questionImageURL,
    this.answerImageURL,
    final List<String?> options = const [],
    final List<int> correctAnswerIndices = const [],
    this.answerDescription = '',
    this.answerExplanation = '',
    this.isMultiSelect = false,
    final List<int>? userAnswerIndices,
    this.isAttempted = false,
    this.showAnswer = false,
    this.timeTaken,
  }) : _options = options,
       _correctAnswerIndices = correctAnswerIndices,
       _userAnswerIndices = userAnswerIndices;

  factory _$QuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String fileId;
  @override
  @JsonKey()
  final int q;
  @override
  @JsonKey()
  final String caseStudyId;
  @override
  @JsonKey()
  final String topicId;
  @override
  @JsonKey()
  final String questionText;
  @override
  @JsonKey()
  final String questionDescription;
  @override
  final String? questionImageURL;
  @override
  final String? answerImageURL;
  final List<String?> _options;
  @override
  @JsonKey()
  List<String?> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  final List<int> _correctAnswerIndices;
  @override
  @JsonKey()
  List<int> get correctAnswerIndices {
    if (_correctAnswerIndices is EqualUnmodifiableListView)
      return _correctAnswerIndices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_correctAnswerIndices);
  }

  @override
  @JsonKey()
  final String answerDescription;
  @override
  @JsonKey()
  final String answerExplanation;
  @override
  @JsonKey()
  final bool isMultiSelect;
  final List<int>? _userAnswerIndices;
  @override
  List<int>? get userAnswerIndices {
    final value = _userAnswerIndices;
    if (value == null) return null;
    if (_userAnswerIndices is EqualUnmodifiableListView)
      return _userAnswerIndices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isAttempted;
  @override
  @JsonKey()
  final bool showAnswer;
  @override
  final int? timeTaken;

  @override
  String toString() {
    return 'Question(id: $id, fileId: $fileId, q: $q, caseStudyId: $caseStudyId, topicId: $topicId, questionText: $questionText, questionDescription: $questionDescription, questionImageURL: $questionImageURL, answerImageURL: $answerImageURL, options: $options, correctAnswerIndices: $correctAnswerIndices, answerDescription: $answerDescription, answerExplanation: $answerExplanation, isMultiSelect: $isMultiSelect, userAnswerIndices: $userAnswerIndices, isAttempted: $isAttempted, showAnswer: $showAnswer, timeTaken: $timeTaken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fileId, fileId) || other.fileId == fileId) &&
            (identical(other.q, q) || other.q == q) &&
            (identical(other.caseStudyId, caseStudyId) ||
                other.caseStudyId == caseStudyId) &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.questionText, questionText) ||
                other.questionText == questionText) &&
            (identical(other.questionDescription, questionDescription) ||
                other.questionDescription == questionDescription) &&
            (identical(other.questionImageURL, questionImageURL) ||
                other.questionImageURL == questionImageURL) &&
            (identical(other.answerImageURL, answerImageURL) ||
                other.answerImageURL == answerImageURL) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality().equals(
              other._correctAnswerIndices,
              _correctAnswerIndices,
            ) &&
            (identical(other.answerDescription, answerDescription) ||
                other.answerDescription == answerDescription) &&
            (identical(other.answerExplanation, answerExplanation) ||
                other.answerExplanation == answerExplanation) &&
            (identical(other.isMultiSelect, isMultiSelect) ||
                other.isMultiSelect == isMultiSelect) &&
            const DeepCollectionEquality().equals(
              other._userAnswerIndices,
              _userAnswerIndices,
            ) &&
            (identical(other.isAttempted, isAttempted) ||
                other.isAttempted == isAttempted) &&
            (identical(other.showAnswer, showAnswer) ||
                other.showAnswer == showAnswer) &&
            (identical(other.timeTaken, timeTaken) ||
                other.timeTaken == timeTaken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fileId,
    q,
    caseStudyId,
    topicId,
    questionText,
    questionDescription,
    questionImageURL,
    answerImageURL,
    const DeepCollectionEquality().hash(_options),
    const DeepCollectionEquality().hash(_correctAnswerIndices),
    answerDescription,
    answerExplanation,
    isMultiSelect,
    const DeepCollectionEquality().hash(_userAnswerIndices),
    isAttempted,
    showAnswer,
    timeTaken,
  );

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      __$$QuestionImplCopyWithImpl<_$QuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionImplToJson(this);
  }
}

abstract class _Question implements Question {
  const factory _Question({
    required final int id,
    final String fileId,
    final int q,
    final String caseStudyId,
    final String topicId,
    final String questionText,
    final String questionDescription,
    final String? questionImageURL,
    final String? answerImageURL,
    final List<String?> options,
    final List<int> correctAnswerIndices,
    final String answerDescription,
    final String answerExplanation,
    final bool isMultiSelect,
    final List<int>? userAnswerIndices,
    final bool isAttempted,
    final bool showAnswer,
    final int? timeTaken,
  }) = _$QuestionImpl;

  factory _Question.fromJson(Map<String, dynamic> json) =
      _$QuestionImpl.fromJson;

  @override
  int get id;
  @override
  String get fileId;
  @override
  int get q;
  @override
  String get caseStudyId;
  @override
  String get topicId;
  @override
  String get questionText;
  @override
  String get questionDescription;
  @override
  String? get questionImageURL;
  @override
  String? get answerImageURL;
  @override
  List<String?> get options;
  @override
  List<int> get correctAnswerIndices;
  @override
  String get answerDescription;
  @override
  String get answerExplanation;
  @override
  bool get isMultiSelect;
  @override
  List<int>? get userAnswerIndices;
  @override
  bool get isAttempted;
  @override
  bool get showAnswer;
  @override
  int? get timeTaken;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Option _$OptionFromJson(Map<String, dynamic> json) {
  return _Option.fromJson(json);
}

/// @nodoc
mixin _$Option {
  String get text => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this Option to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OptionCopyWith<Option> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptionCopyWith<$Res> {
  factory $OptionCopyWith(Option value, $Res Function(Option) then) =
      _$OptionCopyWithImpl<$Res, Option>;
  @useResult
  $Res call({String text, String? imageUrl});
}

/// @nodoc
class _$OptionCopyWithImpl<$Res, $Val extends Option>
    implements $OptionCopyWith<$Res> {
  _$OptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null, Object? imageUrl = freezed}) {
    return _then(
      _value.copyWith(
            text:
                null == text
                    ? _value.text
                    : text // ignore: cast_nullable_to_non_nullable
                        as String,
            imageUrl:
                freezed == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OptionImplCopyWith<$Res> implements $OptionCopyWith<$Res> {
  factory _$$OptionImplCopyWith(
    _$OptionImpl value,
    $Res Function(_$OptionImpl) then,
  ) = __$$OptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? imageUrl});
}

/// @nodoc
class __$$OptionImplCopyWithImpl<$Res>
    extends _$OptionCopyWithImpl<$Res, _$OptionImpl>
    implements _$$OptionImplCopyWith<$Res> {
  __$$OptionImplCopyWithImpl(
    _$OptionImpl _value,
    $Res Function(_$OptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null, Object? imageUrl = freezed}) {
    return _then(
      _$OptionImpl(
        text:
            null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String,
        imageUrl:
            freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OptionImpl implements _Option {
  const _$OptionImpl({this.text = '', this.imageUrl});

  factory _$OptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$OptionImplFromJson(json);

  @override
  @JsonKey()
  final String text;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'Option(text: $text, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptionImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, imageUrl);

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OptionImplCopyWith<_$OptionImpl> get copyWith =>
      __$$OptionImplCopyWithImpl<_$OptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OptionImplToJson(this);
  }
}

abstract class _Option implements Option {
  const factory _Option({final String text, final String? imageUrl}) =
      _$OptionImpl;

  factory _Option.fromJson(Map<String, dynamic> json) = _$OptionImpl.fromJson;

  @override
  String get text;
  @override
  String? get imageUrl;

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OptionImplCopyWith<_$OptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
