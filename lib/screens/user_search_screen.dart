import 'package:flutter/material.dart';
import 'package:flutter_git_hub_search_app/screens/user_repositories_screen.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserSearchScreen extends StatefulWidget {
  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub User Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search for a user',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    userProvider.searchUsers(_controller.text);
                  },
                ),
              ),
            ),
            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  if (userProvider.users.isEmpty) {
                    return const Center(
                      child: Text('No users found'),
                    );
                  }
                  return ListView.builder(
                    itemCount: userProvider.users.length,
                    itemBuilder: (context, index) {
                      final user = userProvider.users[index];
                      return FutureBuilder<int>(
                        future:
                            userProvider.fetchFollowersCount(user.followersUrl),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(user.avatarUrl),
                              ),
                              title: Text(user.login),
                              subtitle: Text('Loading followers... '),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserRepositoriesScreen(
                                            username: user.login),
                                  ),
                                );
                              },
                            );
                          }

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.avatarUrl),
                            ),
                            title: Text(user.login),
                            subtitle: Text('Followers: ${snapshot.data}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserRepositoriesScreen(
                                      username: user.login),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
