part of 'todo_bloc.dart';

@immutable
sealed class TodoState {
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class AddTodoLoading extends TodoState {}

final class AddTodoSuccess extends TodoState {
  final PersonalTodoModel personalTodoModel;
  AddTodoSuccess({required this.personalTodoModel});
}

final class AddTodoFailed extends TodoState {
  final String? message;
  AddTodoFailed(this.message);

  @override
  List<Object> get props => [message!];
}

final class GetAllTodoListLoading extends TodoState {}

final class GetAllTodoListSuccess extends TodoState {
  final List<PersonalTodoModel>? list;
  GetAllTodoListSuccess({required this.list});
}

final class GetAllTodoListFailed extends TodoState {
  final String? message;
  GetAllTodoListFailed(this.message);

  @override
  List<Object> get props => [message!];
}

final class UpdateTodoLoading extends TodoState {}

final class UpdateTodoSuccess extends TodoState {
  final int success;
  UpdateTodoSuccess({required this.success});
}

final class UpdateTodoFailed extends TodoState {
  final String? message;
  UpdateTodoFailed(this.message);

  @override
  List<Object> get props => [message!];
}

final class DeleteTodoLoading extends TodoState {}

final class DeleteTodoSuccess extends TodoState {
  final int success;
  DeleteTodoSuccess({required this.success});
}

final class DeleteTodoFailed extends TodoState {
  final String? message;
  DeleteTodoFailed(this.message);

  @override
  List<Object> get props => [message!];
}
