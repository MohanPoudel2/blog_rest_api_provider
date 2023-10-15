


import 'package:blog_rest_api_provider/provider/blog_post_delete/delete_post_provider.dart';
import 'package:blog_rest_api_provider/provider/blog_put_provider/blog_put_provider.dart';
import 'package:blog_rest_api_provider/provider/get_all_post/get_all_post_notifier.dart';
import 'package:blog_rest_api_provider/provider/get_complete_post/get_complete_post_notifier.dart';
import 'package:blog_rest_api_provider/provider/title_provider/get_title_notifier.dart';
import 'package:blog_rest_api_provider/provider/upload_post/blog_upload_provider.dart';
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
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_)=>GetAllPostNotifier()),
        ChangeNotifierProvider(create: (_)=>GetCompletePostNotifier()),
        ChangeNotifierProvider(create: (_)=>GetTitleNotifier()),
        ChangeNotifierProvider(create: (_)=>BlogUploadNotifier(),),
        ChangeNotifierProvider(create: (_)=>DeletePostNotifier(),),
        ChangeNotifierProvider(create: (_)=>BlogPutNotifier(),),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        theme: ThemeData(useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.lightBlue)
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
