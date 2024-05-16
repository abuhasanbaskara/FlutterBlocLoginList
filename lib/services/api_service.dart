import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc_login_list/models/login_response.dart';
import 'package:flutter_bloc_login_list/models/user.dart';

class ApiService {
  final String baseUrl = 'https://reqres.in/api';

  Future<LoginResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<User>> fetchUsers(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/users?page=$page'));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List usersJson = body['data'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}