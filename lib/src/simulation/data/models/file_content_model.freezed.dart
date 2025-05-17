// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_content_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FileContent _$FileContentFromJson(Map<String, dynamic> json) {
  return _FileContent.fromJson(json);
}

/// @nodoc
mixin _$FileContent {
  String get fileId => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  List<CommonItem> get items => throw _privateConstructorUsedError;

  /// Serializes this FileContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FileContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FileContentCopyWith<FileContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileContentCopyWith<$Res> {
  factory $FileContentCopyWith(
    FileContent value,
    $Res Function(FileContent) then,
  ) = _$FileContentCopyWithImpl<$Res, FileContent>;
  @useResult
  $Res call({String fileId, String fileName, List<CommonItem> items});
}

/// @nodoc
class _$FileContentCopyWithImpl<$Res, $Val extends FileContent>
    implements $FileContentCopyWith<$Res> {
  _$FileContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FileContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileId = null,
    Object? fileName = null,
    Object? items = null,
  }) {
    return _then(
      _value.copyWith(
            fileId:
                null == fileId
                    ? _value.fileId
                    : fileId // ignore: cast_nullable_to_non_nullable
                        as String,
            fileName:
                null == fileName
                    ? _value.fileName
                    : fileName // ignore: cast_nullable_to_non_nullable
                        as String,
            items:
                null == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<CommonItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FileContentImplCopyWith<$Res>
    implements $FileContentCopyWith<$Res> {
  factory _$$FileContentImplCopyWith(
    _$FileContentImpl value,
    $Res Function(_$FileContentImpl) then,
  ) = __$$FileContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fileId, String fileName, List<CommonItem> items});
}

/// @nodoc
class __$$FileContentImplCopyWithImpl<$Res>
    extends _$FileContentCopyWithImpl<$Res, _$FileContentImpl>
    implements _$$FileContentImplCopyWith<$Res> {
  __$$FileContentImplCopyWithImpl(
    _$FileContentImpl _value,
    $Res Function(_$FileContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FileContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileId = null,
    Object? fileName = null,
    Object? items = null,
  }) {
    return _then(
      _$FileContentImpl(
        fileId:
            null == fileId
                ? _value.fileId
                : fileId // ignore: cast_nullable_to_non_nullable
                    as String,
        fileName:
            null == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                    as String,
        items:
            null == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<CommonItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FileContentImpl implements _FileContent {
  const _$FileContentImpl({
    this.fileId = '',
    this.fileName = '',
    final List<CommonItem> items = const [],
  }) : _items = items;

  factory _$FileContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$FileContentImplFromJson(json);

  @override
  @JsonKey()
  final String fileId;
  @override
  @JsonKey()
  final String fileName;
  final List<CommonItem> _items;
  @override
  @JsonKey()
  List<CommonItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'FileContent(fileId: $fileId, fileName: $fileName, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileContentImpl &&
            (identical(other.fileId, fileId) || other.fileId == fileId) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    fileId,
    fileName,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of FileContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FileContentImplCopyWith<_$FileContentImpl> get copyWith =>
      __$$FileContentImplCopyWithImpl<_$FileContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FileContentImplToJson(this);
  }
}

abstract class _FileContent implements FileContent {
  const factory _FileContent({
    final String fileId,
    final String fileName,
    final List<CommonItem> items,
  }) = _$FileContentImpl;

  factory _FileContent.fromJson(Map<String, dynamic> json) =
      _$FileContentImpl.fromJson;

  @override
  String get fileId;
  @override
  String get fileName;
  @override
  List<CommonItem> get items;

  /// Create a copy of FileContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FileContentImplCopyWith<_$FileContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return _Topic.fromJson(json);
}

/// @nodoc
mixin _$Topic {
  String get id => throw _privateConstructorUsedError;
  String get fileId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<CommonItem>? get topicItems => throw _privateConstructorUsedError;

  /// Serializes this Topic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Topic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicCopyWith<Topic> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicCopyWith<$Res> {
  factory $TopicCopyWith(Topic value, $Res Function(Topic) then) =
      _$TopicCopyWithImpl<$Res, Topic>;
  @useResult
  $Res call({
    String id,
    String fileId,
    String title,
    List<CommonItem>? topicItems,
  });
}

/// @nodoc
class _$TopicCopyWithImpl<$Res, $Val extends Topic>
    implements $TopicCopyWith<$Res> {
  _$TopicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Topic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fileId = null,
    Object? title = null,
    Object? topicItems = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            fileId:
                null == fileId
                    ? _value.fileId
                    : fileId // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            topicItems:
                freezed == topicItems
                    ? _value.topicItems
                    : topicItems // ignore: cast_nullable_to_non_nullable
                        as List<CommonItem>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TopicImplCopyWith<$Res> implements $TopicCopyWith<$Res> {
  factory _$$TopicImplCopyWith(
    _$TopicImpl value,
    $Res Function(_$TopicImpl) then,
  ) = __$$TopicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fileId,
    String title,
    List<CommonItem>? topicItems,
  });
}

/// @nodoc
class __$$TopicImplCopyWithImpl<$Res>
    extends _$TopicCopyWithImpl<$Res, _$TopicImpl>
    implements _$$TopicImplCopyWith<$Res> {
  __$$TopicImplCopyWithImpl(
    _$TopicImpl _value,
    $Res Function(_$TopicImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Topic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fileId = null,
    Object? title = null,
    Object? topicItems = freezed,
  }) {
    return _then(
      _$TopicImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        fileId:
            null == fileId
                ? _value.fileId
                : fileId // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        topicItems:
            freezed == topicItems
                ? _value._topicItems
                : topicItems // ignore: cast_nullable_to_non_nullable
                    as List<CommonItem>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicImpl implements _Topic {
  const _$TopicImpl({
    this.id = '',
    this.fileId = '',
    this.title = '',
    final List<CommonItem>? topicItems = const [],
  }) : _topicItems = topicItems;

  factory _$TopicImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String fileId;
  @override
  @JsonKey()
  final String title;
  final List<CommonItem>? _topicItems;
  @override
  @JsonKey()
  List<CommonItem>? get topicItems {
    final value = _topicItems;
    if (value == null) return null;
    if (_topicItems is EqualUnmodifiableListView) return _topicItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Topic(id: $id, fileId: $fileId, title: $title, topicItems: $topicItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fileId, fileId) || other.fileId == fileId) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(
              other._topicItems,
              _topicItems,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fileId,
    title,
    const DeepCollectionEquality().hash(_topicItems),
  );

  /// Create a copy of Topic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicImplCopyWith<_$TopicImpl> get copyWith =>
      __$$TopicImplCopyWithImpl<_$TopicImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicImplToJson(this);
  }
}

abstract class _Topic implements Topic {
  const factory _Topic({
    final String id,
    final String fileId,
    final String title,
    final List<CommonItem>? topicItems,
  }) = _$TopicImpl;

  factory _Topic.fromJson(Map<String, dynamic> json) = _$TopicImpl.fromJson;

  @override
  String get id;
  @override
  String get fileId;
  @override
  String get title;
  @override
  List<CommonItem>? get topicItems;

  /// Create a copy of Topic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicImplCopyWith<_$TopicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CaseStudy _$CaseStudyFromJson(Map<String, dynamic> json) {
  return _CaseStudy.fromJson(json);
}

/// @nodoc
mixin _$CaseStudy {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get fileId => throw _privateConstructorUsedError;
  String get topicId => throw _privateConstructorUsedError;
  String get caseStudyId => throw _privateConstructorUsedError;
  List<Question>? get questions => throw _privateConstructorUsedError;

  /// Serializes this CaseStudy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CaseStudy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CaseStudyCopyWith<CaseStudy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CaseStudyCopyWith<$Res> {
  factory $CaseStudyCopyWith(CaseStudy value, $Res Function(CaseStudy) then) =
      _$CaseStudyCopyWithImpl<$Res, CaseStudy>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String fileId,
    String topicId,
    String caseStudyId,
    List<Question>? questions,
  });
}

/// @nodoc
class _$CaseStudyCopyWithImpl<$Res, $Val extends CaseStudy>
    implements $CaseStudyCopyWith<$Res> {
  _$CaseStudyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CaseStudy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? fileId = null,
    Object? topicId = null,
    Object? caseStudyId = null,
    Object? questions = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            fileId:
                null == fileId
                    ? _value.fileId
                    : fileId // ignore: cast_nullable_to_non_nullable
                        as String,
            topicId:
                null == topicId
                    ? _value.topicId
                    : topicId // ignore: cast_nullable_to_non_nullable
                        as String,
            caseStudyId:
                null == caseStudyId
                    ? _value.caseStudyId
                    : caseStudyId // ignore: cast_nullable_to_non_nullable
                        as String,
            questions:
                freezed == questions
                    ? _value.questions
                    : questions // ignore: cast_nullable_to_non_nullable
                        as List<Question>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CaseStudyImplCopyWith<$Res>
    implements $CaseStudyCopyWith<$Res> {
  factory _$$CaseStudyImplCopyWith(
    _$CaseStudyImpl value,
    $Res Function(_$CaseStudyImpl) then,
  ) = __$$CaseStudyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String fileId,
    String topicId,
    String caseStudyId,
    List<Question>? questions,
  });
}

/// @nodoc
class __$$CaseStudyImplCopyWithImpl<$Res>
    extends _$CaseStudyCopyWithImpl<$Res, _$CaseStudyImpl>
    implements _$$CaseStudyImplCopyWith<$Res> {
  __$$CaseStudyImplCopyWithImpl(
    _$CaseStudyImpl _value,
    $Res Function(_$CaseStudyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CaseStudy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? fileId = null,
    Object? topicId = null,
    Object? caseStudyId = null,
    Object? questions = freezed,
  }) {
    return _then(
      _$CaseStudyImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        fileId:
            null == fileId
                ? _value.fileId
                : fileId // ignore: cast_nullable_to_non_nullable
                    as String,
        topicId:
            null == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                    as String,
        caseStudyId:
            null == caseStudyId
                ? _value.caseStudyId
                : caseStudyId // ignore: cast_nullable_to_non_nullable
                    as String,
        questions:
            freezed == questions
                ? _value._questions
                : questions // ignore: cast_nullable_to_non_nullable
                    as List<Question>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CaseStudyImpl implements _CaseStudy {
  const _$CaseStudyImpl({
    this.id = '00000000-0000-0000-0000-000000000000',
    this.title = '',
    this.description = '',
    this.fileId = '',
    this.topicId = '00000000-0000-0000-0000-000000000000',
    this.caseStudyId = '',
    final List<Question>? questions = const [],
  }) : _questions = questions;

  factory _$CaseStudyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CaseStudyImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String fileId;
  @override
  @JsonKey()
  final String topicId;
  @override
  @JsonKey()
  final String caseStudyId;
  final List<Question>? _questions;
  @override
  @JsonKey()
  List<Question>? get questions {
    final value = _questions;
    if (value == null) return null;
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CaseStudy(id: $id, title: $title, description: $description, fileId: $fileId, topicId: $topicId, caseStudyId: $caseStudyId, questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CaseStudyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.fileId, fileId) || other.fileId == fileId) &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.caseStudyId, caseStudyId) ||
                other.caseStudyId == caseStudyId) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    fileId,
    topicId,
    caseStudyId,
    const DeepCollectionEquality().hash(_questions),
  );

  /// Create a copy of CaseStudy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CaseStudyImplCopyWith<_$CaseStudyImpl> get copyWith =>
      __$$CaseStudyImplCopyWithImpl<_$CaseStudyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CaseStudyImplToJson(this);
  }
}

abstract class _CaseStudy implements CaseStudy {
  const factory _CaseStudy({
    final String id,
    final String title,
    final String description,
    final String fileId,
    final String topicId,
    final String caseStudyId,
    final List<Question>? questions,
  }) = _$CaseStudyImpl;

  factory _CaseStudy.fromJson(Map<String, dynamic> json) =
      _$CaseStudyImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get fileId;
  @override
  String get topicId;
  @override
  String get caseStudyId;
  @override
  List<Question>? get questions;

  /// Create a copy of CaseStudy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CaseStudyImplCopyWith<_$CaseStudyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
