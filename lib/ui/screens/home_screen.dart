import 'package:blog_rest_api_provider/data/model/get_all_post_response.dart';
import 'package:blog_rest_api_provider/provider/get_all_post/get_all_post_state.dart';
import 'package:blog_rest_api_provider/provider/get_all_post/get_all_post_notifier.dart';
import 'package:blog_rest_api_provider/ui/screens/blog_post_detail_screen.dart';
import 'package:blog_rest_api_provider/ui/screens/blog_upload_screen.dart';
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
        builder: (_, getAllPostNotifier, __) {
          GetAllPostState getAllPostState = getAllPostNotifier.getAllPostState;
          if (getAllPostState is GetAllPostSuccessful) {
            List<GetAllPostResponse> getAllPostResponseList =
                getAllPostState.getAllPostList;
            return RefreshIndicator(
              onRefresh: () {
                _getAllPost(context);
                return Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                itemCount: getAllPostResponseList.length,
                itemBuilder: (context, position) {
                  GetAllPostResponse getAllPostResponse =
                      getAllPostResponseList[position];
                  return InkWell(
                    onTap: () {
                      if (getAllPostResponse != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogPostDetailScreen(
                                id: getAllPostResponse.id!,
                              ),
                            ));
                      }
                    },
                    child: Card(
                      child: Center(
                        child: ListTile(
                          title: Text('${getAllPostResponse.title}'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (getAllPostState is GetAllPostFail) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Ops!! Something went Wrong'),
                const Divider(),
                ElevatedButton(
                    onPressed: () {
                      _getAllPost(context);
                    },
                    child: const Text('Try again'))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
         final result=await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BlogUploadScreen(),
              ));
         if(result!=null && result =='success') {
           if (mounted) {
             _getAllPost(context);
           }
         }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _getAllPost(BuildContext ctx) {
    Provider.of<GetAllPostNotifier>(context, listen: false).getAllPost();
  }
}
