import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserRepositoriesScreen extends StatelessWidget {
  final String username;

  UserRepositoriesScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('$username\'s Repositories'),
      ),
      body: FutureBuilder(
        future: userProvider.fetchUserRepositories(username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading repositories'),
            );
          }

          return Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              return ListView.builder(
                itemCount: userProvider.repositories.length,
                itemBuilder: (context, index) {
                  final repo = userProvider.repositories[index];
                  return ListTile(
                    title: Text(repo.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description: ${repo.description}'),
                        Text('Last Commit: ${repo.lastCommitDate}'),
                        Text('Default Branch: ${repo.defaultBranch}'),
                        Text('Forks: ${repo.forksCount}'),
                        Text('Stars: ${repo.stargazersCount}'),
                        Text('Language: ${repo.language}'),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
