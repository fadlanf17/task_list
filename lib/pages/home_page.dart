import 'package:flutter/material.dart';
import 'package:task_list/data/datasources/task_remote_datasource.dart';
import 'package:task_list/data/models/task_response_model.dart';
import 'package:task_list/pages/add_task_page.dart';
import 'package:task_list/pages/detail_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Task> tasks = [];
  Future<void> getTask() async {
    setState(() {
      isLoading = true;
    });
    final model = await TaskRemoteDatasource().getTasks();
    tasks = model.data;

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Crud Task List',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailTaskPage(
                        task: tasks[index],
                      );
                    }));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(tasks[index].attributes.title),
                      subtitle: Text(tasks[index].attributes.description),
                      trailing: const Icon(Icons.check_circle),
                    ),
                  ),
                );
              },
              itemCount: tasks.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddTaskPage();
              },
            ),
          );
          getTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
