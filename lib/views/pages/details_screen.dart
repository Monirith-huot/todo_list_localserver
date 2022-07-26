import 'package:flutter/material.dart';

import '../../models/todo_model.dart';

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
        backgroundColor: Colors.white,
        title: Text(
          widget.todo.title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.purple, Colors.blue],
          ),
        ),
        child: Center(
          child: Container(
            width: 300,
            padding: new EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
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
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                    widget.todo.sDescription == ""
                        ? const Text(
                            "No description",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          )
                        : Text(
                            widget.todo.sDescription!,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                    SizedBox(
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
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Date and Time",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Icon(
                      Icons.alarm,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.todo.sDate!,
                    ),
                    Text(
                      widget.todo.sTime!,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
