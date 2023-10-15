import 'package:blog_rest_api_provider/data/model/blog_put_response.dart';
import 'package:blog_rest_api_provider/provider/blog_put_provider/blog_put_provider.dart';
import 'package:blog_rest_api_provider/provider/blog_put_provider/blog_put_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/get_all_post/get_all_post_notifier.dart';

class BlogPutScreen extends StatefulWidget {
  final int id;

  const BlogPutScreen({super.key, required this.id});

  @override
  State<BlogPutScreen> createState() => _BlogPutScreenState();
}

class _BlogPutScreenState extends State<BlogPutScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit your title & content'),
        centerTitle: true,
      ),
      body: Consumer<BlogPutNotifier>(
        builder: (_, blogPutNotifier, __) {
          BlogPutState blogPutState=blogPutNotifier.getPutState;

          if(blogPutState is BlogPutSuccess){
            BlogPutResponse blogPutResponse=blogPutState.blogPutResponse;

            return Column(
              children: [
                Center(
                    child:  Text(blogPutResponse.result)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context,"success");
                      blogPutNotifier.getPutState=BlogPutLoading();
                    },
                    child: const Text('Ok'))
              ],
            );
          }else if(blogPutState is BlogPutFailed){
            blogPutState=BlogPutFailed('errorMessage');
            return Column(
              children: [
                const Center(child: Text('Something went wrong')),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);

                }, child: const Text('Try again'))
              ],
            );
          }
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Column(children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                          label: Text("Please Enter Blog title"),
                          border: OutlineInputBorder()),
                    ),
                    const Divider(),
                    TextField(
                      minLines: 2,
                      maxLines: 5,
                      controller: _bodyController,
                      decoration: const InputDecoration(
                          label: Text("Please Enter Blog content"),
                          border: OutlineInputBorder()),
                    ),
                    const Divider(),
                    ElevatedButton(
                        onPressed: () {
                          if (_titleController.text.isNotEmpty &&
                              _bodyController.text.isNotEmpty) {
                            String title = _titleController.text;
                            String body = _bodyController.text;
                            if(mounted) {
                              Provider.of<BlogPutNotifier>(context, listen: false)
                                .blogPut(id: widget.id, title: title, body: body);
                            }
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please enter blog title and content to edit')));
                          }
                        },
                        child: const Text('Save'))
                  ])));
        },
      ),
    );
  }



}
