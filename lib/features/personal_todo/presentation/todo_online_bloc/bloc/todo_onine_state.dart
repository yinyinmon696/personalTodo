part of 'todo_online_bloc.dart';

sealed class TodoOnineState {
  List<Object> get props => [];
}

final class TodoOnineBlocInitial extends TodoOnineState {}

final class GetAllTodoServerListLoading extends TodoOnineState {}

final class GetAllTodoServerListSuccess extends TodoOnineState {
  final List<PersonalTodoModel> serverList;
  GetAllTodoServerListSuccess({required this.serverList});

  @override
  List<Object> get props => [serverList];
}

final class GetAllTodoServerListFailed extends TodoOnineState {
  final String? message;
  GetAllTodoServerListFailed(this.message);

  @override
  List<Object> get props => [message!];
}

final class CreateTodoLoading extends TodoOnineState {}

final class CreateTodoSuccess extends TodoOnineState {
  final int? id;
  CreateTodoSuccess({this.id});
}

final class CreateTodoFailed extends TodoOnineState {
  final String? message;
  CreateTodoFailed(this.message);

  @override
  List<Object> get props => [message!];
}

final class SyncTodoDataLoading extends TodoOnineState {}

final class SyncTodoDataSuccess extends TodoOnineState {
  final int? id;
  SyncTodoDataSuccess({this.id});
}

final class SyncTodoDataFailed extends TodoOnineState {
  final String? message;
  SyncTodoDataFailed(this.message);

  @override
  List<Object> get props => [message!];
}
