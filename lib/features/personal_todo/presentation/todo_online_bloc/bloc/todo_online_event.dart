part of 'todo_online_bloc.dart';

sealed class TodoOnlineBlocEvent {
  const TodoOnlineBlocEvent();
}

class GetAllTodoServerList extends TodoOnlineBlocEvent {}

class CreateToDo extends TodoOnlineBlocEvent {
  final PersonalTodoModel personalTodoModel;
  const CreateToDo({required this.personalTodoModel});
}

class SyncTodoData extends TodoOnlineBlocEvent {
  final PersonalTodoModel personalTodoModel;
  const SyncTodoData({required this.personalTodoModel});
}
