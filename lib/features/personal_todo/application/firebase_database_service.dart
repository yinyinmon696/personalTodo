import 'package:firebase_database/firebase_database.dart';
import 'package:personaltodoapp/features/personal_todo/domain/personal_todo_model.dart';

class FirebaseDatabaseService {
  static Future<List<PersonalTodoModel>> readData() async {
    List<PersonalTodoModel> serverList = [];
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('todos');

    databaseReference.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      final values = dataSnapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        return serverList.add(PersonalTodoModel.fromMapKey(value, key));
      });
    });
    return serverList;
  }

  static Future<int> createData(PersonalTodoModel personalTodoModel) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('todos');

    databaseReference.push().set({
      '_id': personalTodoModel.id,
      'title': personalTodoModel.title,
      'done': personalTodoModel.done,
      'needToSync': personalTodoModel.needToSync,
    });

    return personalTodoModel.id!;
  }

  static Future<int> syncData(PersonalTodoModel personalTodoModel) async {
    // DatabaseReference databaseReference =
    //     FirebaseDatabase.instance.ref().child('todos');

    // Query query = databaseReference
    //     .orderByChild("_id")
    //     .equalTo("${personalTodoModel.id}");
    // DataSnapshot event = await query.get();
    // print(event.value.toString());
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('todos/${personalTodoModel.id}').get();
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
    // if (snapshot.exists) {
    //   print(snapshot.value);
    // } else {
    //   print('No data available.');
    // }
    // databaseReference.push().set({
    //   '_id': personalTodoModel.id,
    //   'title': personalTodoModel.title,
    //   'done': personalTodoModel.done,
    //   'needToSync': personalTodoModel.needToSync,
    // });
    return personalTodoModel.id!;
  }
}
