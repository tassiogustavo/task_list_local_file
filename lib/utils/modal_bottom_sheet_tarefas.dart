import 'package:flutter/material.dart';
import 'package:task_list_local_file/controllers/task_manager.dart';
import 'package:task_list_local_file/models/task.dart';
import 'package:task_list_local_file/utils/display_dialog_helper.dart';

class ModalBottomSheetTarefas {
  static Future<void> modalBottomSheetTarefasLF(
    BuildContext context,
    List<Task> listTask,
    int index,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildActionButton(
                  context,
                  listTask[index].isDone ? "Voltar estágio" : "Finalizar",
                  () => _handleFinishTask(context, listTask, index),
                ),
                _buildActionButton(
                  context,
                  "Editar",
                  () => _handleEditTask(context, listTask, index),
                ),
                _buildActionButton(
                  context,
                  "Excluir",
                  () => _handleDeleteTask(context, listTask, index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildActionButton(
      BuildContext context, String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  static void _handleFinishTask(
      BuildContext context, List<Task> listTask, int index) {
    TaskManager.finishTask(listTask, index)
        .then((value) => Navigator.pop(context));
  }

  static void _handleEditTask(
      BuildContext context, List<Task> listTask, int index) {
    DisplayDialogHelper dialogHelper = DisplayDialogHelper();
    dialogHelper
        .displayInputTarefaLF(context, true, listTask, index: index)
        .then((value) {
      Navigator.pop(context);
    });
  }

  static void _handleDeleteTask(
      BuildContext context, List<Task> listTask, int index) {
    TaskManager.deleteTask(listTask, index)
        .then((value) => Navigator.pop(context));
  }
}
