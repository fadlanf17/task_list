import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_list/data/models/add_task_response_model.dart';

class DeleteTaskRemoteDataSource {
  Future<AddTasksResponseModel> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse('https://fic9.flutterdev.my.id/api/tasks/$id'),
    );
    if (response.statusCode == 200) {
      return AddTasksResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete task');
    }
  }
}
