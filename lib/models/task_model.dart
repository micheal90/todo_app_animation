class Task {
  int id;
  String title;
  String note;
  String date;
  String startTime;
  String endTime;
  int reminder;
  String repeat;
  int color;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.reminder,
    required this.repeat,
    required this.color,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'date': date,
      'startDate': startTime,
      'endDate': endTime,
      'reminder': reminder,
      'repeat': repeat,
      'color': color,
      'isCompleted': convertBoolToString(isCompleted)
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      note: map['note'],
      date: map['date'],
      startTime: map['startDate'],
      endTime: map['endDate'],
      reminder: map['reminder'],
      repeat: map['repeat'],
      color: map['color'],
      isCompleted: convertStringToBool(map['isCompleted']),
    );
  }
}

bool convertStringToBool(String value) {
  if (value == 'true') {
    return true;
  } else {
    return false;
  }
}

String convertBoolToString(bool value) {
  if (value == true) {
    return 'true';
  } else {
    return 'false';
  }
}
