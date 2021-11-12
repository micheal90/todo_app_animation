import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_animated_app/models/task_model.dart';
import 'package:todo_animated_app/services/db_helper.dart';
import 'package:todo_animated_app/services/notification_services.dart';

class TaskController extends GetxController {
  final List<Task> _tasks = [
    // Task(
    //   id: 1,
    //   title: 'Title1',
    //   note:
    //       'Quis do velit ullamco enim esse adipisicing commodo sunt ex elit officia et sint. Pariatur qui in do nostrud dolore dolore ullamco cillum nulla proident pariatur consequat. Consectetur cupidatat adipisicing duis tempor voluptate cillum nisi non minim id. Ullamco ex eiusmod amet ipsum deserunt cupidatat nulla.',
    //   date: 'October 8, 2021',
    //   startDate: '9:50 AM',
    //   endDate: '10:00 AM',
    //   reminder: 5,
    //   repeat: 'None',
    //   color: 1,
    // ),
    // Task(
    //   id: 2,
    //   title: 'Title2',
    //   note:
    //       'Duis nisi qui excepteur in irure deserunt aliquip eiusmod fugiat nostrud fugiat esse. Qui magna in aliquip labore qui in est pariatur consectetur do sit adipisicing nostrud. Nulla laborum aliqua do veniam cillum enim eiusmod do elit. Nulla ad cillum fugiat ut ut pariatur excepteur labore.',
    //   date: 'October 10, 2021',
    //   startDate: '9:50 AM',
    //   endDate: '10:00 AM',
    //   reminder: 5,
    //   repeat: 'None',
    //   color: 2,
    // ),
    // Task(
    //   id: 3,
    //   title: 'Title3',
    //   note:
    //       'Duis laboris mollit officia aute id est ipsum commodo veniam ut quis. Incididunt tempor eu culpa fugiat dolore commodo duis non nisi elit enim. Incididunt dolor occaecat incididunt labore. Nulla anim fugiat laboris adipisicing ex sint occaecat excepteur nisi Lorem magna. Sint aute labore aliquip nostrud commodo occaecat mollit et.',
    //   date: 'October 12, 2021',
    //   startDate: '9:50 AM',
    //   endDate: '10:00 AM',
    //   reminder: 10,
    //   repeat: 'None',
    //   color: 0,
    // ),
  ];
  List<Task> get tasks => [..._tasks];
  @override
  void onInit() async {
   // await deleteAllTask();
    await getTasksFromDB();
    super.onInit();
  }

  Future getTasksFromDB() async {
    _tasks.clear();
    var value = await DBHelper.getTasks();
    for (var element in value) {
      var task = Task.fromMap(element);
      _tasks.add(task);
    }
    debugPrint('$value');
    update();
  }

  Future addTask(Task task) async {
    await DBHelper.addTask(task);
    // _tasks.add(task);
    await getTasksFromDB();
    update();
  }

  Future deleteTask(Task task) async {
    await DBHelper.deleteTask(task.id);
    await NotifyHelper().cancelNotification(task);
    //_tasks.removeWhere((element) => element.id == id);
    await getTasksFromDB();
    update();
  }

  Future deleteAllTask() async {
    await DBHelper.deleteTable();
    await NotifyHelper().cancelAllNotification();
    await getTasksFromDB();
    update();
  }

  Future changeTaskStatus(Task task) async {
    await DBHelper.changeStatus(task.id, 'true');
    await NotifyHelper().cancelNotification(task);
    //_tasks.firstWhere((element) => element.id == id).isCompleted = true;
    await getTasksFromDB();
    update();
  }
}
