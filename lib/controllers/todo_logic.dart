import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../models/todo_model.dart';

const android = "http://10.0.2.2";
const ios = 'http://localhost';
const port = ":8080";
const os = ios;
const folder = "todo_item";
const readUrl = "$os$port/$folder/read.php";
const key = "123456";
const insertUrl = "$os$port/$folder/insert.php?key=$key";
const deleteUrl = "$os$port/$folder/delete.php?key=$key";
const updateUrl = "$os$port/$folder/edit.php?key=$key";

enum ToDoStatusStatus {
  none,
  loading,
  success,
  error,
}

class TodoItemLogic extends ChangeNotifier {
  TodoModel _todoItemModel = TodoModel();

  TodoModel get todoModel => _todoItemModel;

  List<Todos> _todoList = [];
  List<Todos> get todoList => _todoList;

  // List<Todos> _undoneList = [];
  // List<Todos> get undoneList => _undoneList;

  ToDoStatusStatus _status = ToDoStatusStatus.none;
  ToDoStatusStatus get status => _status;

  bool hide = false;

  void setLoading() {
    _status = ToDoStatusStatus.loading;
    notifyListeners();
  }

  Future read() async {
    try {
      const url = readUrl;
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _todoItemModel = await compute(_convert, response.body);
        _todoList = _todoItemModel.todos;
        _status = ToDoStatusStatus.success;
      } else {
        print("Error while reading data, status code: ${response.statusCode}");
        _status = ToDoStatusStatus.error;
      }
    } catch (e) {
      print("Error ${e.toString()}");
      _status = ToDoStatusStatus.error;
    }
    notifyListeners();
  }

  Future<bool> insert(Todos item) async {
    try {
      const url = insertUrl;
      http.Response response = await http.post(
        Uri.parse(url),
        body: item.toMap(),
      );
      if (response.statusCode == 200) {
        if (response.body == "todo_inserted") {
          return true;
        }
      } else {
        throw Exception(
            "Error while inserting data, status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
    return false;
  }

  Future<bool> delete(Todos item) async {
    try {
      const url = deleteUrl;
      http.Response response = await http.post(
        Uri.parse(url),
        body: item.toMap(),
      );

      if (response.statusCode == 200) {
        _todoList.removeWhere((e) => e.tId == item.tId);
        notifyListeners();
        if (response.body == "todo_deleted") {
          return true;
        }
      } else {
        throw Exception(
            "Error while deleting data, status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
    return false;
  }

  Future<bool> update(Todos item) async {
    try {
      const url = updateUrl;
      http.Response response = await http.post(
        Uri.parse(url),
        body: item.toMap(),
      );
      if (response.statusCode == 200) {
        if (response.body == "todo_updated") {
          return true;
        }
      } else {
        throw Exception(
            "Error while updating data, status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
    return false;
  }

  bool isVisible() {
    return hide;
  }

  void changeVisible(bool test) {
    hide = !test;
    notifyListeners();
  }
}

TodoModel _convert(String body) {
  return TodoModel.fromMap(json.decode(body));
}
