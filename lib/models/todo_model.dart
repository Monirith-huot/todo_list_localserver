import 'dart:convert';

Todos todosFromMap(String str) => Todos.fromMap(json.decode(str));

String todosToMap(Todos data) => json.encode(data.toMap());

class TodoModel {
  TodoModel({
    this.todos = const [],
  });

  List<Todos> todos;
  factory TodoModel.fromMap(Map<String, dynamic> json) => TodoModel(
        todos: List<Todos>.from(json["todo_item"].map((x) => Todos.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "products": List<dynamic>.from(todos.map((x) => x.toMap())),
      };
}

class Todos {
  Todos({
    this.tId = "0",
    required this.title,
    this.sDescription,
    this.sDate,
    this.priority,
    this.sTime,
    this.finish,
  });
  String tId;
  String title;
  String? sDescription;
  String? sDate;
  String? priority;
  String? sTime;
  String? finish;

  factory Todos.fromMap(Map<String, dynamic> json) => Todos(
        tId: json["tId"],
        title: json["title"],
        sDescription: json["sDescription"],
        sDate: json["sDate"],
        priority: json["priority"],
        sTime: json["sTime"],
        finish: json["finish"],
      );

  Map<String, dynamic> toMap() => {
        "tId": tId,
        "title": title,
        "sDescription": sDescription,
        "sDate": sDate,
        "priority": priority,
        "sTime": sTime,
        "finish": finish,
      };
}
