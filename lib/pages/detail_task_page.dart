import 'package:flutter/material.dart';
import 'package:task_list/data/datasources/delete_task_remote_datasource.dart';

import 'package:task_list/data/models/task_response_model.dart';
import 'package:task_list/pages/edit_task_page.dart';
import 'package:task_list/pages/home_page.dart';

class DetailTaskPage extends StatefulWidget {
  final Task task;
  const DetailTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Task',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        children: [
          Text('Title: ${widget.task.attributes.title}'),
          const SizedBox(height: 16),
          Text('Description: ${widget.task.attributes.description}'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(120, 40),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditTaskPage(
                          task: widget.task,
                        );
                      },
                    ),
                  );
                },
                child: const Text('Edit'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(120, 40),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text(
                              'Are you sure wantu delete this task?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await DeleteTaskRemoteDataSource()
                                    .deleteTask(widget.task.id);
                                if (context.mounted) {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const HomePage();
                                  }));
                                }
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      });
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
