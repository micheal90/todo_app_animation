import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_animated_app/controllers/task_controller.dart';
import 'package:todo_animated_app/models/task_model.dart';
import 'package:todo_animated_app/screens/add_task.dart';
import 'package:todo_animated_app/services/notification_services.dart';
import 'package:todo_animated_app/services/theme_service.dart';
import 'package:todo_animated_app/shared/size_config.dart';
import 'package:todo_animated_app/shared/theme.dart';
import 'package:todo_animated_app/shared/widgets/constom_material_button.dart';
import 'package:todo_animated_app/shared/widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NotifyHelper notifyHelper;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            ThemeService().swichThemeMode();
            notifyHelper.displayNotification(
                title: 'Theme Changed',
                body: Get.isDarkMode
                    ? 'Activated Light Theme'
                    : 'Activated Dark Theme');
          },
          icon: Icon(
            Get.isDarkMode ? Icons.light_mode : Icons.nightlight_round_outlined,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/person.jpeg',
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 10.0),
        child: GetBuilder<TaskController>(
          init: Get.find<TaskController>(),
          builder: (controller) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: heading6Style.copyWith(color: Colors.grey),
                      ),
                      Text(
                        'Today',
                        style: heading5Style,
                      )
                    ],
                  ),
                  CustomMaterialButton(
                    text: 'Add Task',
                    onPressed: () => Get.to(const AddTask()),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: DatePicker(
                  DateTime.now(),
                  selectionColor: KprimaryColor,
                  initialSelectedDate: DateTime.now(),
                  onDateChange: (selectedDate) =>
                      setState(() => _selectedDate = selectedDate),
                ),
              ),
              controller.tasks.isEmpty
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/task.svg',
                            height: 100,
                            width: 100,
                            color: KprimaryColor.withOpacity(0.5),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'You do not have any tasks yet!\nAdd new tasks to make your days productive.',
                            style: heading6Style.copyWith(color: Colors.grey),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  : _showTasks(controller),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _showTasks(TaskController controller) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => controller.getTasksFromDB(),
        child: ListView.separated(
            itemBuilder: (context, index) {
              Task task = controller.tasks[index];
              DateTime date = DateFormat.jm().parse(task.startTime);

              // debugPrint('hour ${date.hour}');
              // debugPrint('minutes ${date.minute}');
              //send notification
              var hour = date.hour;
              var minutes = date.minute;
              //if task is completed not send notification
              if (task.isCompleted == false) {
                notifyHelper.scheduledNotification(hour, minutes, task);
              }

              if ((task.repeat == 'Daily' &&
                      _selectedDate
                          .isAfter(DateFormat.yMMMMd().parse(task.date))) ||
                  task.date == DateFormat.yMMMMd().format(_selectedDate) ||
                  (task.repeat == 'Weekly' &&
                      _selectedDate
                                  .difference(
                                      DateFormat.yMMMMd().parse(task.date))
                                  .inDays %
                              7 ==
                          0) ||
                  (task.repeat == 'Monthly' &&
                      DateFormat.yMMMMd().parse(task.date).day ==
                          _selectedDate.day)) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(seconds: 1),
                    child: TaskItem(
                      task,
                    ));
              } else {
                return Container(
                  height: 0,
                );
              }
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10.0,
                ),
            itemCount: controller.tasks.length),
      ),
    );
  }
}
