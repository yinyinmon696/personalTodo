class PersonalTodoModel {
  int? id;
  String? title;
  bool? done;
  bool? needToSync;
  String? keyValue;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'title': title,
      'done': done == true ? 1 : 0,
      'needToSync': needToSync == true ? 1 : 0
    };
    if (id != null) {
      map['_id'] = id;
    }
    return map;
  }

  PersonalTodoModel(
      {this.id, this.title, this.done, this.needToSync, this.keyValue});

  PersonalTodoModel.fromMap(Map<dynamic, dynamic> map) {
    id = map['_id'] != null ? map['_id'] as int : null;
    title = map['title'] != null ? map['title'] as String : null;
    done = map['done'] == 1;
    needToSync = map['needToSync'] == 1;
  }

  PersonalTodoModel.fromMapKey(Map<dynamic, dynamic> map, String key) {
    id = map['_id'] != null ? map['_id'] as int : null;
    title = map['title'] != null ? map['title'] as String : null;
    done = map['done'] == 1;
    needToSync = map['needToSync'] == 1;
    keyValue = key;
  }
  PersonalTodoModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    done = json['done'] == 0 ? false : true;
    needToSync = json['needToSync'] == 0 ? false : true;
  }
}
