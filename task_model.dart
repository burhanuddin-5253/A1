class TaskModel {
  TaskModel({
    this.title,
    this.description,
    this.isCompleted = false,
  });

  String? title;
  String? description;
  bool? isCompleted;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }
}