// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controllers/todo_logic.dart';
import '../../models/todo_model.dart';

class AddTodo extends StatefulWidget {
  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List _priorities = ["High", "Medium", "Low"];
    String _priority = "";
    // PriorityLevel? priorityLevel = PriorityLevel.medium;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo Item"),
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
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Please enter a date' : null,
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
                  value: "Medium",
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
                ElevatedButton(
                  onPressed: () async {
                    if (_priority == "") {
                      _priority = "Medium";
                    }
                    if (_formKey.currentState!.validate() == true) {
                      Todos item = Todos(
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
                          await context.read<TodoItemLogic>().insert(item);
                      if (success) {
                        await context.read<TodoItemLogic>().read();
                        showSnackBar(context, "Inserted Successfully");
                        _titleController.clear();
                        _timeController.clear();
                        _descriptionController.clear();
                        _dateController.clear();
                        _priority = "Medium";
                        Navigator.of(context).pop();
                      } else {
                        showSnackBar(
                          context,
                          "Something went wrong",
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Add New Todo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
      _timeController.text += time.format(context);
    }
    // if time.
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
