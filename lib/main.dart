


import 'package:blog_rest_api_provider/provider/get_all_post/get_all_post_notifier.dart';
import 'package:blog_rest_api_provider/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>GetAllPostNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        theme: ThemeData(useMaterial3: true),
        home: const HomeScreen(),
      ),
    );
  }
}
