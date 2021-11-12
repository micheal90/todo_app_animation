import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:intl/intl.dart';
import 'package:todo_animated_app/controllers/task_controller.dart';
import 'package:todo_animated_app/models/task_model.dart';
import 'package:todo_animated_app/shared/theme.dart';
import 'package:todo_animated_app/shared/widgets/constom_material_button.dart';
import 'package:todo_animated_app/shared/widgets/input_text_form_field.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TaskController _taskController = Get.find<TaskController>();
  //controller
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  //reminder
  final List<int> _remindList = [5, 10, 15, 20];
  int _selectedReminder = 5;
  //repeat
  final List<String> _repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  String _selectedRepeat = 'None';
//date, start and end Time
  DateTime _selectedData = DateTime.now();
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  //selected color
  int _selectedColor = 0;

  _getDate() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedData,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (_pickedDate != null) {
      setState(() {
        _selectedData = _pickedDate;
      });
    }
  }

  _getSrartTime() async {
    TimeOfDay? _pickedStartTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: _selectedStartTime ?? TimeOfDay.now(),
    );
    if (_pickedStartTime != null) {
      setState(() {
        _selectedStartTime = _pickedStartTime;
      });
    }
  }

  _getEndTime() async {
    TimeOfDay? _pickedEndtTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: _selectedEndTime ?? TimeOfDay.now(),
    );
    if (_pickedEndtTime != null) {
      setState(() {
        _selectedEndTime = _pickedEndtTime;
      });
    }
  }

  _addTask() {
    debugPrint(DateFormat.yMMMMd().format(_selectedData));
    if (!_formKey.currentState!.validate()) return;
    try {
      _taskController
          .addTask(Task(
        id: DateTime.now().millisecond,
        title: _titleController.text,
        note: _noteController.text,
        date: DateFormat.yMMMMd().format(_selectedData),
        startTime: _selectedStartTime?.format(context) ??
            TimeOfDay.now().format(context),
        endTime: _selectedEndTime?.format(context) ??
            TimeOfDay.now().format(context),
        reminder: _selectedReminder,
        repeat: _selectedRepeat.toString(),
        color: _selectedColor,
      ))
          .then((value) {
        debugPrint(value.toString());
        Get.back();
      });
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          icon: Icon(
            Icons.error_outline,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:
              Get.isDarkMode ? context.theme.backgroundColor : Colors.white);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.theme.backgroundColor,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              )),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Task",
                    style: heading5Style,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFormField(
                    autofocus: true,
                    controller: _titleController,
                    title: 'Title',
                    hint: 'Enter title here.',
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return 'Enter Title';
                      } else {
                        return null;
                      }
                    },
                  ),
                  InputTextFormField(
                      controller: _noteController,
                      title: 'Note',
                      hint: 'Enter note here.',
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return 'Enter Note';
                        } else {
                          return null;
                        }
                      }),
                  InputTextFormField(
                    onTap: _getDate,
                    title: 'Date',
                    hint: DateFormat.yMd().format(_selectedData),
                    suffixIcon: const Icon(Icons.date_range),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: InputTextFormField(
                          onTap: _getSrartTime,
                          title: 'Start Time',
                          hint: _selectedStartTime?.format(context) ??
                              TimeOfDay.now().format(context),
                          suffixIcon: const Icon(Icons.watch_later_outlined),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: InputTextFormField(
                          onTap: _getEndTime,
                          title: 'End Time',
                          hint: _selectedEndTime?.format(context) ??
                              TimeOfDay.now().format(context),
                          suffixIcon: const Icon(Icons.watch_later_outlined),
                        ),
                      ),
                    ],
                  ),
                  InputTextFormField(
                    title: 'Reminder',
                    hint: '$_selectedReminder minutes early',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: DropdownButton(
                        underline: Container(
                          height: 0,
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 35,
                        items: _remindList
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(e.toString()),
                                value: e.toString(),
                              ),
                            )
                            .toList(),
                        onChanged: (String? val) {
                          setState(() {
                            _selectedReminder = int.parse(val!);
                          });
                        },
                      ),
                    ),
                  ),
                  InputTextFormField(
                      title: 'Repeat',
                      hint: _selectedRepeat,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: DropdownButton(
                          underline: Container(
                            height: 0,
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 35,
                          items: _repeatList
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (String? val) {
                            setState(() {
                              _selectedRepeat = val!;
                            });
                          },
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Color',
                            style: heading6Style,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: List.generate(
                                3,
                                (index) => GestureDetector(
                                      onTap: () => setState(
                                          () => _selectedColor = index),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: index == 0
                                                  ? KTaskColor1
                                                  : index == 1
                                                      ? KTaskColor2
                                                      : KTaskColor3,
                                            ),
                                            child: index == _selectedColor
                                                ? const Icon(
                                                    Icons.done,
                                                    size: 28,
                                                    color: Colors.white,
                                                  )
                                                : null),
                                      ),
                                    )).toList(),
                          )
                        ],
                      ),
                      CustomMaterialButton(
                        text: 'Create Task',
                        onPressed: _addTask,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
