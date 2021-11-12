import 'package:get/get.dart';
import 'package:todo_animated_app/controllers/task_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskController());
  }
}
