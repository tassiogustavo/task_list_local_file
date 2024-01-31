import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:task_list_local_file/models/task.dart';

class TaskManager {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;

      return file.readAsString();
    } catch (e) {
      return "Falha ao buscar dados";
    }
  }

  static Future<File> saveData(List<Task> listTask) async {
    String data = json.encode(listTask.map((e) => e.toMap()).toList());
    final file = await _localFile;
    return file.writeAsString(data);
  }

  static Future addTask(List<Task> listTask, Task task) async {
    listTask.add(task);
    saveData(listTask);
  }

  static Future editTask(List<Task> listTask, Task task, int index) async {
    listTask[index] = task;
    saveData(listTask);
  }

  static Future finishTask(List<Task> listTask, int index) async {
    Task task = listTask[index];
    task.isDone = !task.isDone;
    listTask[index] = task;
    saveData(listTask);
  }

  static deleteTask(List<Task> listTask, int index) async {
    listTask.removeAt(index);
    saveData(listTask);
  }
}
