import 'package:bloc/bloc.dart';

class SearchCubit extends Cubit<String> {
  SearchCubit() : super('');

  void setQuery(String query) => emit(query);
}