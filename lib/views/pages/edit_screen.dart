// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/views/pages/homepage.dart';

import '../../controllers/todo_logic.dart';
import '../../models/todo_model.dart';

class EditTodo extends StatefulWidget {
  final Todos todo;
  EditTodo({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController =
        TextEditingController(text: widget.todo.sDescription!);
    _dateController = TextEditingController(text: widget.todo.sDate!);
    _timeController = TextEditingController(
      text: widget.todo.sTime!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (_timeController != null) {
    //   _timeController.text =
    //       DateFormat.jm().format(DateFormat("hh:mm").parse(widget.todo.sTime!));
    // }
    List _priorities = ["High", "Medium", "Low"];
    String _priority = widget.todo.priority!;

    return Scaffold(
      appBar: AppBar(
        title: Text("editing page"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 40.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  style: const TextStyle(fontSize: 16.0),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Please enter a title' : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _descriptionController,
                  style: const TextStyle(fontSize: 16.0),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  // validator: (value) =>
                  //     value!.trim().isEmpty ? 'Please enter a title' : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  readOnly: true,
                  controller: _dateController,
                  style: const TextStyle(fontSize: 16.0),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                  ),
                  onTap: _handleDatePicker,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  readOnly: true,
                  controller: _timeController,
                  style: const TextStyle(fontSize: 16.0),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Time',
                  ),
                  onTap: _handleTimePicker,
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  onChanged: (value) {
                    _priority = value.toString();
                  },
                  value: _priority,
                  icon: const Icon(Icons.arrow_drop_down_circle),
                  iconSize: 22.0,
                  iconEnabledColor: Theme.of(context).primaryColor,
                  items: _priorities.map(
                    (itemone) {
                      return DropdownMenuItem(
                        value: itemone,
                        child: Text(itemone),
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_priority == "") {
                      _priority = "Medium";
                    }
                    if (_formKey.currentState!.validate() == true) {
                      Todos item = Todos(
                        tId: widget.todo.tId,
                        title: _titleController.text,
                        sDescription: _descriptionController.text,
                        // ? ""
                        // : _descriptionController.text,
                        sDate: _dateController.text,
                        // ? ""
                        // : _descriptionController.text,
                        priority: _priority,
                        sTime: _timeController.text,
                        // ? ""
                        // : _timeController.text,
                        finish: "0",
                      );
                      bool success =
                          await context.read<TodoItemLogic>().update(item);
                      if (success) {
                        await context.read<TodoItemLogic>().read();
                        showSnackBar(context, "Updated Successfully");
                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const HomePage(),
                          ),
                        );
                      } else {
                        showSnackBar(context, "Something went wrong");
                      }
                    } else {
                      print("some fields are not validated");
                    }
                  },
                  icon: const Icon(
                    Icons.save,
                  ),
                  label: Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      _dateController.text = DateFormat.yMMMMEEEEd().format(date);
      setState(
        () => _dateController.text = _dateController.text,
      );
    }
  }

  Future<void> _handleTimePicker() async {
    final time = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (time == null) {
      _timeController.text += "";
    } else {
      _timeController.text = time.format(context);
    }
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: "DONE",
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
