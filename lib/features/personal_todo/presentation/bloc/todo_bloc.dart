import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:personaltodoapp/features/personal_todo/data/personal_todo_repository.dart';
import 'package:personaltodoapp/features/personal_todo/domain/personal_todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  PersonalTodoRepository personalTodoRepository = PersonalTodoRepository();
  TodoBloc() : super(TodoInitial()) {
    on<AddTodo>(_addTodoEvent);
    on<GetAllTodoList>(_getAllTodoList);
    on<UpdateTodo>(_updateTodoEvent);
    on<DeleteTodo>(_deleteTodoEvent);
  }

  _addTodoEvent(AddTodo event, Emitter<TodoState> emit) async {
    emit(AddTodoLoading());
    await Future.delayed(const Duration(seconds: 1), () {});
    try {
      final data =
          await personalTodoRepository.createItem(event.personalTodoModel);
      emit(AddTodoSuccess(personalTodoModel: data));
    } catch (e) {
      emit(AddTodoFailed(e.toString()));
    }
  }

  _getAllTodoList(GetAllTodoList event, Emitter<TodoState> emit) async {
    emit(GetAllTodoListLoading());
    try {
      final List<PersonalTodoModel>? list =
          await personalTodoRepository.getAllList();
      emit(GetAllTodoListSuccess(list: list));
    } catch (e) {
      // print(e.toString());
      emit(GetAllTodoListFailed(e.toString()));
    }
  }

  _updateTodoEvent(UpdateTodo event, Emitter<TodoState> emit) async {
    emit(UpdateTodoLoading());
    try {
      final int success =
          await personalTodoRepository.updateItem(event.personalTodoModel);
      emit(UpdateTodoSuccess(success: success));
    } catch (e) {
      // print(e.toString());
      emit(UpdateTodoFailed(e.toString()));
    }
  }

  _deleteTodoEvent(DeleteTodo event, Emitter<TodoState> emit) async {
    emit(DeleteTodoLoading());
    try {
      final int success =
          await personalTodoRepository.deleteItem(event.personalTodoModel);
      emit(DeleteTodoSuccess(success: success));
    } catch (e) {
      // print(e.toString());
      emit(DeleteTodoFailed(e.toString()));
    }
  }
}
