import 'package:blog_rest_api_provider/data/model/get_all_post_response.dart';
import 'package:blog_rest_api_provider/provider/get_all_post_state.dart';
import 'package:blog_rest_api_provider/provider/get_all_post/get_all_post_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
   _getAllPost(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog api'),
        centerTitle: true,
      ),
      body: Consumer<GetAllPostNotifier>(
        builder: (_,getAllPostNotifier,__){
         GetAllPostState getAllPostState=getAllPostNotifier.getAllPostState;
         if(getAllPostState is GetAllPostSuccessful){
          List<GetAllPostResponse> getAllPostResponseList=getAllPostState.getAllPostList;
          return ListView.builder(
            itemCount: getAllPostResponseList.length,
            itemBuilder: (context, position) {
              GetAllPostResponse getAllPostResponse=getAllPostResponseList[position];
              return Card(
                child: Center(
                  child: ListTile(
                    leading: Text('${getAllPostResponse.id}'),
                    title: Text('${getAllPostResponse.title}'),
                  ),
                ),
              );
            },
          );
         }else if(getAllPostState is GetAllPostFail){
           return Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               const Text('Ops!! Something went Wrong'),
             const Divider(),
           ElevatedButton(onPressed: (){
             _getAllPost(context);
           }, child: const Text('Try again'))
             ],
           );
         }
          return const Center(child: CircularProgressIndicator.adaptive(),);
        },
      ),
    );
  }
  void _getAllPost(BuildContext ctx){
    Provider.of<GetAllPostNotifier>(context,listen: false).getAllPost();
  }

}
