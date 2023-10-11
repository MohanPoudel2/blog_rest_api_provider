import 'package:blog_rest_api_provider/data/model/get_one_post_response.dart';
import 'package:blog_rest_api_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/provider/blog_post_delete/delete_post_provider.dart';
import 'package:blog_rest_api_provider/provider/get_complete_post/get_complete_post_state.dart';
import 'package:blog_rest_api_provider/provider/title_provider/title_state.dart';
import 'package:blog_rest_api_provider/ui/screens/home_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/get_complete_post/get_complete_post_notifier.dart';
import '../../provider/title_provider/get_title_notifier.dart';

class BlogPostDetailScreen extends StatefulWidget {
  final int id;

  const BlogPostDetailScreen({super.key, required this.id});

  @override
  State<BlogPostDetailScreen> createState() => _BlogPostDetailScreenState();
}

class _BlogPostDetailScreenState extends State<BlogPostDetailScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getBlogDetail(widget.id);
    _getBlogTitle(widget.id);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<GetTitleNotifier>(
          builder: (_, getTitleNotifier, __) {
            GetTitleState getTitleState = getTitleNotifier.getTitleState;
            if (getTitleState is TitleSuccessFul) {
              GetOnePostResponse getOnePostResponse =
                  getTitleState.getOnePostResponse;
              return Text(getOnePostResponse.title ??
                  'No title for this id ${widget.id}');
            } else if (getTitleState is TitleFailed) {
              return const Text('something went Wrong');
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
              ),
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Icon(
                            Icons.warning_amber,
                            size: 50,
                          ),
                          content: const Text(
                              'Are you sure you wanna delete this Post?'),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('cancel')),
                               Consumer<DeletePostNotifier>(builder: (_, deletePostNotifier, __){

                                  return ElevatedButton(onPressed: (){
                                    _deleteBlogPost(widget.id);
                                    _getBlogDetail(widget.id);

                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>const  HomeScreen(),));
                                  }, child: const Text('Ok'));
                                 },)
                              ],
                            )
                          ],
                        ));
              },
              icon: const Icon(Icons.delete_outline))
        ],
        centerTitle: true,
      ),
      body: Consumer<GetCompletePostNotifier>(
        builder: (_, getCompletePostNotifier, __) {
          GetCompletePostState getCompletePostState =
              getCompletePostNotifier.getCompletePostState;
          if (getCompletePostState is GetCompletePostSuccess) {
            GetOnePostResponse getOnePostResponse =
                getCompletePostState.getOnePostResponse;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(getOnePostResponse.body ?? ''),
                    const Divider(),
                    if (getOnePostResponse.photo != null)
                      CachedNetworkImage(
                        imageUrl:
                            '${BlogApiService.baseUrl}${getOnePostResponse.photo}',
                        errorWidget: (_, __, e) {
                          return const Center(
                            child: Icon(
                              Icons.error_outline_outlined,
                              size: 60,
                            ),
                          );
                        },
                      )
                  ],
                ),
              ),
            );
          } else if (getCompletePostState is GetCompletePostFailed) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Ops!! Something went Wrong'),
                const Divider(),
                ElevatedButton(
                    onPressed: () {
                      _getBlogDetail(widget.id);
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
    );
  }

  void _getBlogDetail(int id) {
    Provider.of<GetCompletePostNotifier>(context, listen: false)
        .getCompletePost(id: widget.id);
  }

  void _getBlogTitle(int id) {
    Provider.of<GetTitleNotifier>(context, listen: false).getTitle(id: id);
  }

  void _deleteBlogPost(int id) {
    Provider.of<DeletePostNotifier>(context,listen: false).deleteOnePost(id: widget.id);
  }
}
