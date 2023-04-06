part of 'person_list_cubit.dart';

abstract class PersonListState extends Equatable {
  const PersonListState();

  @override
  List<Object> get props => [];
}

class PersonListInitial extends PersonListState {}

class PersonLoading extends PersonListState {
  final List<PersonEntity> oldPersonsList;
  final bool isFirstFetch;

  const PersonLoading(this.oldPersonsList, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldPersonsList];
}

class PersonLoaded extends PersonListState {
  final List<PersonEntity> personsList;

  const PersonLoaded(this.personsList);

  @override
  List<Object> get props => [personsList];
}

class PersonError extends PersonListState {
  final String message;

  const PersonError(this.message);

  @override
  List<Object> get props => [message];
}
