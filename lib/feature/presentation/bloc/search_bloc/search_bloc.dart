import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/error/failure.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/useCases/search_person.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchPerson searchPersons;

  SearchBloc({required this.searchPersons}) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {});
    on<SearchPersons>((event, emit) async {
      emit(PersonSearchLoading());

      final failureOrPerson =
          await searchPersons(SearchPersonParams(query: event.personQuery));

      failureOrPerson.fold(
          (failure) => emit(PersonSearchFailure(_mapFailureToMessage(failure))),
          (persons) => PersonSearchLoaded(persons));
    });
  }

  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'CacheFailure';
      default:
        return 'Unexpected error';
    }
  }
}
