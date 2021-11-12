import 'package:flutter/material.dart';
import 'package:todo_animated_app/shared/theme.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({required this.payload, Key? key}) : super(key: key);
  final String payload;

  @override
  Widget build(BuildContext context) {
    final String title = payload.split('|')[0];
    final String note = payload.split('|')[1];
    final String startTime = payload.split('|')[2];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Screen'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text('Hello Micheal', style: heading4Style),
            const SizedBox(
              height: 15,
            ),
            Text('You have a new reminder', style: heading6Style),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        isThreeLine: true,
                        leading: const Icon(
                          Icons.title,
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text('Title',
                            style: heading5Style.copyWith(color: Colors.white)),
                        subtitle: Text(title, style: subTitle1Style),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        isThreeLine: true,
                        leading: const Icon(
                          Icons.description,
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text('Note',
                            style: heading5Style.copyWith(color: Colors.white)),
                        subtitle: Text(note, style: subTitle1Style),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        isThreeLine: true,
                        leading: const Icon(
                          Icons.date_range,
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text('Start Time',
                            style: heading5Style.copyWith(color: Colors.white)),
                        subtitle: Text(startTime, style: subTitle1Style),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
