import 'package:flutter/material.dart';
import 'package:task_list/data/datasources/update_task_remote_datasource.dart';
import 'package:task_list/data/models/add_task_reques_model.dart';

import 'package:task_list/data/models/task_response_model.dart';
import 'package:task_list/pages/home_page.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  const EditTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.task.attributes.title;
    _descriptionController.text = widget.task.attributes.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () async {
                final newModel = AddTasksRequestModel(
                  data: Data(
                      title: _titleController.text,
                      description: _descriptionController.text),
                );
                await UpdateTaskRemoteDatasource()
                    .updateTask(widget.task.id, newModel);
                if (context.mounted) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }));
                }
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
