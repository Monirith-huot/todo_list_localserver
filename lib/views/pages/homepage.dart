import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/views/pages/add_screen.dart';
import 'package:todo_list/views/pages/edit_screen.dart';

import '../../controllers/todo_logic.dart';
import '../widgets/todo_overview.dart';
import '../widgets/todo_tile.dart';
import 'details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Todos> items = context.watch<TodoItemLogic>().todoList;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return AddTodo();
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
          ),
          itemCount: 1 + items.length,
          itemBuilder: (ctx, index) {
            if (index == 0) return TodoOverview();
            final todo = items[index - 1];
            bool success = false;
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return DetailTodo(todo: todo);
                  },
                ),
              ),
              child: Slidable(
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) async => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return EditTodo(todo: todo);
                            },
                          ),
                        ),
                      },
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (ctx) async => {
                        print(todo.tId),
                        success =
                            await context.read<TodoItemLogic>().delete(todo),
                        if (success)
                          {
                            await context.read<TodoItemLogic>().read(),
                          }
                        else
                          {
                            // showSnackBar(context, "Something went wrong");
                          }
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: (TodoTile(
                  todo: todo,
                )),
              ),
            );
            // return TodoTile(
            //   updateTodos: _getTodos,
            //   todo: todo,
            // );
          },
          separatorBuilder: (_, __) => const Divider(),
        ),
      ),
    );
  }
}
