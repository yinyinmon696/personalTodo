part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {
  const TodoEvent();
}

class AddTodo extends TodoEvent {
  final PersonalTodoModel personalTodoModel;
  const AddTodo({required this.personalTodoModel});
}

class GetAllTodoList extends TodoEvent {}

class UpdateTodo extends TodoEvent {
  final PersonalTodoModel personalTodoModel;
  const UpdateTodo({required this.personalTodoModel});
}

class DeleteTodo extends TodoEvent {
  final PersonalTodoModel personalTodoModel;
  const DeleteTodo({required this.personalTodoModel});
}
