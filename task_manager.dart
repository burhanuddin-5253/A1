import 'dart:convert';
import 'dart:io';
import 'task_model.dart';

class TaskManager {
  List<TaskModel> _tasks = [];

  TaskManager() {
    loadTasks();
  }

  void addTask(TaskModel task) {
    _tasks.add(task);
    saveTasks(); 
  }

  void updateTask(int index, TaskModel task) {
    _tasks[index] = task;
    saveTasks(); 
  }

  void deleteTask(int index){
    _tasks.removeAt(index);
    saveTasks(); 
  }

  TaskModel? searchByTitle(String title) {
    for (var task in _tasks) {
      if (task.title!.trim().toLowerCase() == title.trim().toLowerCase()) {
        return task;
      }
    }
    return null;
  }

  List<TaskModel> getTasks() {
    return _tasks;
  }

  List<TaskModel> getCompletedTasks() {
    return _tasks.where((task) => task.isCompleted == true).toList();
  }

  List<TaskModel> getIncompletedTasks() {
    return _tasks.where((task) => task.isCompleted == false).toList();
  }

  void toggleTaskCompletion(int index) {
    bool? toggle = _tasks[index].isCompleted;
    _tasks[index].isCompleted = !toggle!;
    saveTasks(); 
  }

  void saveTasks() {
    final file = File('tasks.txt');
    final jsonList = _tasks
        .map((task) => {
              'title': task.title,
              'description': task.description,
              'isCompleted': task.isCompleted
            })
        .toList();
    file.writeAsStringSync(jsonEncode(jsonList));
  }


  void loadTasks() {
    final file = File('tasks.txt');
    if (file.existsSync()) {
      final jsonList = jsonDecode(file.readAsStringSync()) as List;
      _tasks = jsonList
          .map((json) => TaskModel(
              title: json['title'],
              description: json['description'],
              isCompleted: json['isCompleted']))
          .toList();
    }
  }
}
