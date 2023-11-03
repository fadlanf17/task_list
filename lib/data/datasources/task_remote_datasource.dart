import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_list/data/models/task_response_model.dart';

class TaskRemoteDatasource {
  Future<TasksResponseModel> getTasks() async {
    final response = await http.get(
      Uri.parse('https://fic9.flutterdev.my.id/api/tasks'),
    );
    if (response.statusCode == 200) {
      return TasksResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to get task');
    }
  }
}