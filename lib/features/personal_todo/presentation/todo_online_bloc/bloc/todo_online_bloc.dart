import 'package:bloc/bloc.dart';
import 'package:personaltodoapp/features/personal_todo/data/personal_todo_repository.dart';
import 'package:personaltodoapp/features/personal_todo/domain/personal_todo_model.dart';
import 'package:personaltodoapp/utils/functions.dart';

part 'todo_online_event.dart';
part 'todo_onine_state.dart';

class TodoOnineBloc extends Bloc<TodoOnlineBlocEvent, TodoOnineState> {
  PersonalTodoRepository personalTodoRepository = PersonalTodoRepository();
  TodoOnineBloc() : super(TodoOnineBlocInitial()) {
    on<GetAllTodoServerList>(_getAllTodoServerList);
    on<CreateToDo>(_createTodo);
    on<SyncTodoData>(_syncTodoData);
  }

  _getAllTodoServerList(
      GetAllTodoServerList event, Emitter<TodoOnineState> emit) async {
    emit(GetAllTodoServerListLoading());
    await Future.delayed(const Duration(seconds: 1), () {});
    if (!await Functions.getNetworkStatus()) {
      emit(GetAllTodoServerListFailed("No Network Connection!"));
    } else {
      try {
        List<PersonalTodoModel> serverList =
            await personalTodoRepository.getAllServerList();
        emit(GetAllTodoServerListSuccess(serverList: serverList));
      } catch (e) {
        emit(GetAllTodoServerListFailed(e.toString()));
      }
    }
  }

  _createTodo(CreateToDo event, Emitter<TodoOnineState> emit) async {
    emit(CreateTodoLoading());
    await Future.delayed(const Duration(seconds: 1), () {});
    if (!await Functions.getNetworkStatus()) {
      emit(CreateTodoFailed("No Network Connection!"));
    } else {
      try {
        final id =
            await personalTodoRepository.createData(event.personalTodoModel);
        emit(CreateTodoSuccess(id: id));
      } catch (e) {
        emit(CreateTodoFailed(e.toString()));
      }
    }
  }

  _syncTodoData(SyncTodoData event, Emitter<TodoOnineState> emit) async {
    emit(SyncTodoDataLoading());
    await Future.delayed(const Duration(seconds: 1), () {});
    if (!await Functions.getNetworkStatus()) {
      emit(SyncTodoDataFailed("No Network Connection!"));
    } else {
      try {
        final id =
            await personalTodoRepository.syncData(event.personalTodoModel);
        emit(SyncTodoDataSuccess(id: id));
      } catch (e) {
        emit(SyncTodoDataFailed(e.toString()));
      }
    }
  }
}
