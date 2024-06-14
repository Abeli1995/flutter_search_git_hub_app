import 'package:flutter/material.dart';
import 'package:flutter_git_hub_search_app/providers/user_provider.dart';
import 'package:flutter_git_hub_search_app/screens/user_search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'GitHub User Search',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserSearchScreen(),
      ),
    );
  }
}
