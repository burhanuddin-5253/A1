import 'dart:io';

import 'task_manager.dart';
import 'task_model.dart';

String menu() {  // displays a menu 
  print('1 -> Add a new task.        \t\t 2 -> Update a task.');
  print('3 -> Delete a task.         \t\t 4 -> List all tasks.');
  print('5 -> List completed tasks.  \t\t 6 -> List incomplete tasks.');
  print('7 -> Toggle task status.    \t\t 8 -> Search task by title.');
  print('e -> Exit application.\n');
  stdout.write('Select option from above: ');
  var option = stdin.readLineSync()!;
  return option;
}

bool isValidIndex(int index) {
  if (index.isNegative || index >= manager.getTasks().length) {
    return false;
  }
  return true;
}

// takes input from the user and returns a TaskModel object.
TaskModel readTask() {
  stdout.write('\nEnter Title: ');
  var title = stdin.readLineSync();
  stdout.write('Enter Description: ');
  var description = stdin.readLineSync();
  print('');
  return TaskModel(
    title: title,
    description: description,
  );
}

void printTasks(List<TaskModel> tasks) {
  if (tasks.length == 0) {
    print(
        '\n--------------------------- No Tasks! ---------------------------\n');
    return;
  }
  print(
      '----------------------------------------------------------------------------------------------------\n\n');
  for (var task in tasks) {
    print('                                       Task No. ${tasks.indexOf(task)}');
    print('Title: ${task.title}');
    print('Description: ${task.description}');
    print('Status: ${task.isCompleted! ? 'Completed.' : 'Incomplete!'}');
    print(
        '----------------------------------------------------------------------------------------------------\n\n');
  }
}

void printSingleTask(TaskModel task) {
  print(
      '----------------------------------------------------------------------------------------------------\n');
  print('Title: ${task.title}');
  print('Description: ${task.description}');
  print('Status: ${task.isCompleted! ? 'Completed.' : 'Incomplete!'}');
  print(
      '--------------------------------------------------------------------------------------------------\n\n');
}

TaskManager manager = TaskManager();
void main(List<String> args) {
  TaskModel task;
  String option = '';
  while (option != 'e' || option != 'E') {
    option = menu();
    switch (option) {
      case '1':
        task = readTask();
        manager.addTask(task);
        break;
      case '2':
        printTasks(manager.getTasks());
        stdout.write('Enter index : ');
        try {
          var index = int.parse(stdin.readLineSync()!);
          if (isValidIndex(index)) {
            task = readTask();
            manager.updateTask(index, task);
            print('');
          } else {
            print('##### ERROR: Invalid Index !! #####\n\n');
          }
        } catch (_) {
          print('Exception: Enter a valid number!\n\n');
        }

        break;
      case '3':
        printTasks(manager.getTasks());
        stdout.write('Enter index: ');
        try {
          var index = int.parse(stdin.readLineSync()!);
          if (isValidIndex(index)) {
            manager.deleteTask(index);
            print('');
          } else {
            print('##### ERROR: Invalid Index !! #####\n\n');
          }
        } catch (_) {
          print('Exception: Enter a valid number!\n\n');
        }
        break;
      case '4':
        printTasks(manager.getTasks());
        break;
      case '5':
        printTasks(manager.getCompletedTasks());
        break;
      case '6':
        printTasks(manager.getIncompletedTasks());
        break;
      case '7':
        printTasks(manager.getTasks());
        if (manager.getTasks().isEmpty) {
          break;
        }
        stdout.write('Enter index of task to change completion status: ');
        try {
          var index = int.parse(stdin.readLineSync()!);
          if (isValidIndex(index)) {
            manager.toggleTaskCompletion(index);
            print('');
          } else {
            print('##### ERROR: Invalid Index !! #####\n\n');
          }
        } catch (_) {
          print('Exception: Enter a valid number!\n\n');
        }
        break;
      case '8':
        stdout.write('Enter title: ');
        try {
          var title = stdin.readLineSync();
          printSingleTask(manager.searchByTitle(title!)!);
        } catch (_) {
          print('Exception: Enter a valid title!\n\n ');
        }
        break;
      case 'e' || 'E':
        return;
      default:
        print('##### ERROR: Invalid Input !! #####\n\n');
    }
    stdout.write('\nPress enter to continue... ');
    stdin.readLineSync();
    print('\n\n');
  }
}
