import 'dart:io';

import 'package:blog_rest_api_provider/provider/upload_post/blog_upload_provider.dart';
import 'package:blog_rest_api_provider/provider/upload_post/blog_upload_ui_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BlogUploadScreen extends StatefulWidget {
  const BlogUploadScreen({super.key});

  @override
  State<BlogUploadScreen> createState() => _BlogUploadScreenState();
}

class _BlogUploadScreenState extends State<BlogUploadScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Blog Upload'),

      ),
      body: Consumer<BlogUploadNotifier>(
        builder: (_, blogUploadNotifier, __) {
          BlogUploadUiState blogUploadUiState =
              blogUploadNotifier.blogUploadUiState;
          if (blogUploadUiState is BlogUploadLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                 Text('Loading......${blogUploadUiState.progress}%'),
                LinearProgressIndicator(
                  value: blogUploadUiState.progress,
                )
              ],
            );
          } else if (blogUploadUiState is BlogUploadSuccess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Center(child: Text(blogUploadUiState.blogUploadResponse.result ?? '')),
                ElevatedButton(onPressed: () {
                  Navigator.pop(context,'success');
                  blogUploadNotifier.blogUploadUiState=BlogUploadFormState();
                }, child: const Text('Ok'))
              ],
            );
          } else if (blogUploadUiState is BlogUploadFailed) {
            return Column(

             mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(blogUploadUiState.errorMessage),
                ElevatedButton(onPressed: () {
                 blogUploadNotifier.tryAgain();
                }, child: const Text('Try again'))
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                  FilledButton(
                      onPressed: () async {
                        XFile? file = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (file != null) {
                          setState(() {
                            _image = File(file.path);
                          });
                        }
                      },
                      child: const Text('Select Photo')),
                  const Divider(),
                  if (_image != null)
                    Image.file(
                      _image!,
                      height: 200,
                    ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_titleController.text.isNotEmpty &&
                            _bodyController.text.isNotEmpty) {
                          String title = _titleController.text;
                          String body = _bodyController.text;
                          FormData? data;
                          if (_image != null) {
                            data = FormData.fromMap({
                              'photo':
                                  await MultipartFile.fromFile(_image!.path)
                            });
                          }
                          if (mounted) {
                            Provider.of<BlogUploadNotifier>(context,
                                    listen: false)
                                .upload(title: title, body: body, data: data);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please enter blog title and content')));
                        }
                      },
                      child: const Text('Upload'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
