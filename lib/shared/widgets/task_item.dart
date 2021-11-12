import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:todo_animated_app/controllers/task_controller.dart';
import 'package:todo_animated_app/models/task_model.dart';
import 'package:todo_animated_app/services/notification_services.dart';
import 'package:todo_animated_app/shared/size_config.dart';
import 'package:todo_animated_app/shared/theme.dart';
import 'package:todo_animated_app/shared/widgets/bottom_sheet_option.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
    this.task, {
    Key? key,
  }) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    final _taskController = Get.find<TaskController>();
    return SlideAnimation(
      horizontalOffset: 300,
      duration: const Duration(seconds: 1),
      child: FadeInAnimation(
        child: GestureDetector(
          onTap: () => _showBottomSheet(context, _taskController),
          child: Container(
            decoration: BoxDecoration(
              color: task.color == 0
                  ? KTaskColor1
                  : task.color == 1
                      ? KTaskColor2
                      : KTaskColor3,
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.all(10.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.alarm,
                              color: Colors.white,
                            ),
                            Text(
                              '${task.reminder} min early',
                              style:
                                  subTitle1Style.copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            if (task.repeat != 'None')
                              Text(
                                task.repeat,
                                style:
                                    title1Style.copyWith(color: Colors.white),
                              ),
                          ],
                        ),
                        Text(
                          task.title,
                          style: heading6Style.copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${task.startTime} - ${task.endTime}',
                              style:
                                  subTitle1Style.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          endIndent: 50,
                        ),
                        Text(
                          task.note,
                          style: subTitle1Style.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade300,
                    indent: 20,
                    endIndent: 20,
                  ),
                  RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      task.isCompleted ? 'COMPLETED' : 'TODO',
                      style: title1Style.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _showBottomSheet(
      BuildContext context, TaskController _taskController) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: context.theme.backgroundColor,
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!task.isCompleted)
              BottomSheetOption(
                lebel: 'Task Completed',
                color: KprimaryColor,
                onTap: () async {
                  _taskController.changeTaskStatus(task);
                  Get.back();
                },
              ),
            const SizedBox(
              height: 10,
            ),
            BottomSheetOption(
              lebel: 'Delete Task',
              color: Colors.pink,
              onTap: () async {
                _taskController.deleteTask(task);
                Get.back();
              },
            ),
            const SizedBox(
              height: 30,
            ),
            BottomSheetOption(
              lebel: 'Cancel',
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
