import 'package:flutter/material.dart';

import '../../models/todo_model.dart';
import 'edit_screen.dart';

class DetailTodo extends StatefulWidget {
  final Todos todo;
  DetailTodo({Key? key, required this.todo}) : super(key: key);

  @override
  State<DetailTodo> createState() => _DetailTodoState();
}

class _DetailTodoState extends State<DetailTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.todo.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Center(
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.teal,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.todo.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        widget.todo.sDescription == ""
                            ? const Text(
                                "No description",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              )
                            : Text(
                                widget.todo.sDescription!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                        const SizedBox(
                          height: 15,
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
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Icon(
                          Icons.alarm,
                          size: 30,
                          color: Colors.white,
                        ),
                        Text(
                          widget.todo.sDate!,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.todo.sTime!,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 320,
            top: 275,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return EditTodo(todo: widget.todo);
                  },
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(
                  10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.greenAccent,
                ),
                child: const Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
