import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/views/widgets/todo_overview.dart';
import 'package:todo_list/views/widgets/todo_tile.dart';

import '../../controllers/todo_logic.dart';
import '../../models/todo_model.dart';
import '../pages/details_screen.dart';
import '../pages/edit_screen.dart';

class ListViewItem extends StatefulWidget {
  final List<Todos> items;

  const ListViewItem({Key? key, required this.items}) : super(key: key);

  @override
  State<ListViewItem> createState() => _ListViewItemState();
}

class _ListViewItemState extends State<ListViewItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 50,
      ),
      itemCount: widget.items.length + 1,
      itemBuilder: (ctx, index) {
        if (index == 0) return TodoOverview();
        final todo = widget.items[index - 1];

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
                  label: "Edit",
                ),
                SlidableAction(
                  onPressed: (ctx) async => {
                    success = await context.read<TodoItemLogic>().delete(todo),
                    if (success)
                      {
                        await context.watch<TodoItemLogic>().read(),
                      }
                    else
                      {
                        // showSnackBar(context, "Something went wrong");
                      }
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  label: 'Delete',
                ),
              ],
            ),
            child: (TodoTile(
              todo: todo,
            )),
          ),
        );
      },
      // separatorBuilder: (_, __) => const Divider(),
    );
  }
}
