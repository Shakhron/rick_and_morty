part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchPersons extends SearchEvent {
  final String personQuery;

  const SearchPersons(this.personQuery);
}
