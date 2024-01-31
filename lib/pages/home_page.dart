// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_list_local_file/controllers/task_manager.dart';
import 'package:task_list_local_file/models/task.dart';
import 'package:task_list_local_file/utils/constants.dart';
import 'package:task_list_local_file/utils/display_dialog_helper.dart';
import 'package:task_list_local_file/utils/modal_bottom_sheet_tarefas.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  Future<void> updateList() async {
    try {
      TaskManager taskManagerLF = TaskManager();
      String value = await taskManagerLF.readData();
      setState(() {
        Iterable i = json.decode(value);
        tasks = List<Task>.from(i.map((e) => Task.fromMap(e)));
      });
    } catch (error) {
      print("Error updating list: $error");
      // Handle the error appropriately (e.g., show a snackbar)
    }
  }

  @override
  void initState() {
    super.initState();
    updateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local File JSON Tarefas"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ListTile(
              title: Text(
                tasks[index].title,
                style: TextStyle(
                  fontSize: 20,
                  decoration:
                      tasks[index].isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text(
                tasks[index].description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  decoration:
                      tasks[index].isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              leading: CircleAvatar(
                backgroundColor: listIcons[tasks[index].priority].color,
              ),
            ),
            onTap: () {
              ModalBottomSheetTarefas.modalBottomSheetTarefasLF(
                      context, tasks, index)
                  .then((value) => updateList());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DisplayDialogHelper dialogHelper = DisplayDialogHelper();
          await dialogHelper.displayInputTarefaLF(context, false, tasks);
          await updateList();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
