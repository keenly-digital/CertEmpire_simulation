import 'package:bloc/bloc.dart';

class SearchQuestionCubit extends Cubit<String> {
  SearchQuestionCubit() : super('');

  void setQuery(String query) => emit(query);
}