import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/views/pages/add_screen.dart';
import 'package:todo_list/views/pages/edit_screen.dart';
import 'package:todo_list/views/widgets/listView.dart';

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
    bool isVisible = context.watch<TodoItemLogic>().isVisible();
    List<Todos> items = context.watch<TodoItemLogic>().todoList;
    List<Todos> sortedItems = [];
    List<Todos> unDone = [];
    for (var i = 0; i < items.length; i++) {
      sortedItems.add(items[i]);
      if (items[i].finish == "0") {
        unDone.add(items[i]);
      }
    }

    unDone.sort((a, b) {
      //sorting in ascending order
      return DateFormat('EEEE, MMMM dd, yyyy')
          .parse(a.sDate!)
          .compareTo(DateFormat('EEEE, MMMM dd, yyyy').parse(b.sDate!));
    });

    sortedItems.sort((a, b) {
      return DateFormat('EEEE, MMMM dd, yyyy')
          .parse(a.sDate!)
          .compareTo(DateFormat('EEEE, MMMM dd, yyyy').parse(b.sDate!));
    });

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
        child: isVisible
            ? ListViewItem(
                items: sortedItems,
              )
            : ListViewItem(
                items: unDone,
              ),
      ),
    );
  }
}
