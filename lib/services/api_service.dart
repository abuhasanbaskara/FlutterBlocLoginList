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

  Future<List<User>> fetchUsers({required int page}) async {
    final url = '$baseUrl/users?page=$page';
    print('Fetching users from: $url');

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      print('Failed to load users: ${response.statusCode}');
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }
}