import 'package:personaltodoapp/features/personal_todo/application/firebase_database_service.dart';
import 'package:personaltodoapp/features/personal_todo/application/sqlite_service.dart';
import 'package:personaltodoapp/features/personal_todo/domain/personal_todo_model.dart';

class PersonalTodoRepository {
  Future<PersonalTodoModel> createItem(
      PersonalTodoModel personalTodoModel) async {
    return await SqliteService.addNote(personalTodoModel);
  }

  Future<List<PersonalTodoModel>?> getAllList() async {
    return await SqliteService.getAllList();
  }

  Future<int> updateItem(PersonalTodoModel personalTodoModel) async {
    return await SqliteService.updateNote(personalTodoModel);
  }

  Future<int> deleteItem(PersonalTodoModel personalTodoModel) async {
    return await SqliteService.deleteNote(personalTodoModel);
  }

  Future<List<PersonalTodoModel>> getAllServerList() async {
    return await FirebaseDatabaseService.readData();
  }

  Future<int> createData(PersonalTodoModel personalTodoModel) async {
    return await FirebaseDatabaseService.createData(personalTodoModel);
  }

  Future<int> syncData(PersonalTodoModel personalTodoModel) async {
    return await FirebaseDatabaseService.syncData(personalTodoModel);
  }
}
