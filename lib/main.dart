import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 
class Post {
  int? userId;
  int? id;
  String? title;
  String? body;
 
  Post({this.userId, this.id, this.title, this.body});
 
  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
 

 
void main() async {
  runApp(MaterialApp(home:MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Post> posts = List.empty();

  Future<void> getPosts() async {
  final baseURL = "http://jsonplaceholder.typicode.com";
  var url = Uri.parse(
    '$baseURL/posts',
  );
  final response = await http.get(url);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body) as List;
    posts = json.map((e) => Post.fromJson(e)).toList();
  }
}

   @override
  Widget build(BuildContext context) {
    getPosts();
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text(posts[index].title ?? ""),
            ),
          );
        }
      ),
    );
  }
}