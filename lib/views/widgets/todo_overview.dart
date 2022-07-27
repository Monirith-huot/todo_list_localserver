import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/todo_logic.dart';
import '../../models/todo_model.dart';
import '../pages/add_screen.dart';

class TodoOverview extends StatefulWidget {
  @override
  State<TodoOverview> createState() => _TodoOverviewState();
}

class _TodoOverviewState extends State<TodoOverview> {
  @override
  Widget build(BuildContext context) {
    bool isVisible = context.watch<TodoItemLogic>().isVisible();
    List<Todos> items = context.watch<TodoItemLogic>().todoList;
    final completedTodoListCount = items.where((e) => e.finish == "1").length;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Todos",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${completedTodoListCount} of ${items.length}  completed",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              AddTodo();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AddTodo();
                  },
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              context.read<TodoItemLogic>().changeVisible(isVisible);
            },
            icon: isVisible
                ? Icon(Icons.visibility)
                : Icon(
                    Icons.visibility_off,
                  ),
          ),
        ],
      ),
    );
  }
}
