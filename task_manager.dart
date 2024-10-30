import 'dart:convert';
import 'dart:io';
import 'task_model.dart';

class TaskManager {
  List<TaskModel> _tasks = [];

  TaskManager() {
    _initializeTasks();
  }

  Future<void> _initializeTasks() async {
    _tasks = await loadTasks();
  }

  Future<void> addTask(TaskModel task) async {
    _tasks.add(task);
    await saveTasks(); 
  }

  Future<void> updateTask(int index, TaskModel task) async {
    _tasks[index] = task;
    await saveTasks(); 
  }

  Future<void> deleteTask(int index) async {
    _tasks.removeAt(index);
    await saveTasks(); 
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

  Future<void> toggleTaskCompletion(int index) async {
    bool? toggle = _tasks[index].isCompleted;
    _tasks[index].isCompleted = !toggle!;
    await saveTasks(); 
  }

  Future<void> saveTasks() async {
    File file = File('tasks.txt');
    String updatedJsonString = jsonEncode(_tasks.map((task) => task.toJson()).toList());
    await file.writeAsString(updatedJsonString);
  }

  Future<List<TaskModel>> loadTasks() async {
    try {
      File file = File('tasks.txt');
      if (await file.exists()) {
        String jsonString = await file.readAsString();
        List<Map<String, dynamic>> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => TaskModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error loading tasks: $e");
      return [];
    }
  }
}
