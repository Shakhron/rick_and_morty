part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class PersonSearchLoading extends SearchState {}

class PersonSearchLoaded extends SearchState {
  final List<PersonEntity> persons;

  const PersonSearchLoaded(this.persons);

  @override
  List<Object> get props => [persons];
}

class PersonSearchFailure extends SearchState {
  final String message;

  const PersonSearchFailure(this.message);

  @override
  List<Object> get props => [message];
}
