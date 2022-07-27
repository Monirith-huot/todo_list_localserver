import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/todo_logic.dart';
import '../../models/todo_model.dart';

class TodoTile extends StatefulWidget {
  final Todos todo;

  const TodoTile({super.key, required this.todo});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    final completedTextDecoration = widget.todo.finish == "0"
        ? TextDecoration.none
        : TextDecoration.lineThrough;

    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 20,
        top: 20,
      ),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
          ),
          child: Text(
            widget.todo.title,
            style: TextStyle(
              fontSize: 18,
              decoration: completedTextDecoration,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.todo.sDate!,
              style: TextStyle(
                decoration: completedTextDecoration,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 2.5,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: (widget.todo.priority == "Low")
                    ? Colors.green
                    : (widget.todo.priority == "Medium")
                        ? Colors.orange[600]
                        : Colors.red,
                borderRadius: BorderRadius.circular(
                  20,
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 4),
                ],
              ),
              child: Text(
                widget.todo.priority!,
                style: TextStyle(
                  color:
                      widget.todo.finish == "0" ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                  decoration: completedTextDecoration,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: widget.todo.finish == "0" ? false : true,
          onChanged: (value) async {
            if (widget.todo.finish == "0") {
              Todos item = Todos(
                tId: widget.todo.tId,
                title: widget.todo.title,
                sDescription: widget.todo.sDescription,
                // ? ""
                // : _descriptionController.text,
                sDate: widget.todo.sDate,
                // ? ""
                // : _descriptionController.text,
                priority: widget.todo.priority,
                sTime: widget.todo.sTime,
                // ? ""
                // : _timeController.text,
                finish: "1",
              );
              bool success = await context.read<TodoItemLogic>().update(item);
              if (success) {
                await context.read<TodoItemLogic>().read();
              }
            } else {
              Todos item = Todos(
                tId: widget.todo.tId,
                title: widget.todo.title,
                sDescription: widget.todo.sDescription,
                // ? ""
                // : _descriptionController.text,
                sDate: widget.todo.sDate,
                // ? ""
                // : _descriptionController.text,
                priority: widget.todo.priority,
                sTime: widget.todo.sTime,
                // ? ""
                // : _timeController.text,
                finish: "0",
              );
              bool success = await context.read<TodoItemLogic>().update(item);
              if (success) {
                await context.read<TodoItemLogic>().read();
              }
            }
          },
        ),
      ),
    );
  }
}
