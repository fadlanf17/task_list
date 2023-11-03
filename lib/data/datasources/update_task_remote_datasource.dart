import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_list/data/models/add_task_reques_model.dart';
import 'package:task_list/data/models/add_task_response_model.dart';

class UpdateTaskRemoteDatasource {
  Future<AddTasksResponseModel> updateTask(
      int id, AddTasksRequestModel data) async {
    final response = await http.put(
        Uri.parse('https://fic9.flutterdev.my.id/api/tasks/$id'),
        body: data.toRawJson(),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      return AddTasksResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update task');
    }
  }
}
