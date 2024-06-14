import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/repository_model.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;

  List<Repository> _repositories = [];

  List<Repository> get repositories => _repositories;

  Future<void> searchUsers(String query) async {
    final url = Uri.parse('https://api.github.com/search/users?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<User> loadedUsers = [];
      for (var user in data['items']) {
        loadedUsers.add(User.fromJson(user));
      }
      _users = loadedUsers;
      notifyListeners();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<int> fetchFollowersCount(String followersUrl) async {
    final response = await http.get(Uri.parse(followersUrl));

    if (response.statusCode == 200) {
      final List followers = json.decode(response.body);
      return followers.length;
    } else {
      throw Exception('Failed to load followers');
    }
  }

  Future<void> fetchUserRepositories(String username) async {
    final url = Uri.parse('https://api.github.com/users/$username/repos');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Repository> loadedRepositories = [];
      for (var repo in data) {
        loadedRepositories.add(Repository.fromJson(repo));
      }
      _repositories = loadedRepositories;
      notifyListeners();
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
