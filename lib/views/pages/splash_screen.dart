import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/todo_logic.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: 1),
      () async {
        await context.read<TodoItemLogic>().read();
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.book_sharp,
          size: 100,
        ),
      ),
    );
  }
}
