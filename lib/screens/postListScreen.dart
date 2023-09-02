import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/posts.dart';
import 'package:pet_user_app/screens/addPostScreen.dart';
import 'package:pet_user_app/screens/commentScreen.dart';

class PostListScreen extends BaseRoute {
  // PostListScreen() : super();
  PostListScreen() : super();
  @override
  _PostListScreenState createState() => new _PostListScreenState();
}

class _PostListScreenState extends BaseRouteState {
  _PostListScreenState() : super();

  bool isDataLoaded = false;

  List<Post> posts = [];
  Future<void> fetchData() async {
    try {
      var dio = Dio();
      var response = await dio.get(
        'https://us-central1-petcare-a1918.cloudfunctions.net/api/publications',
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> jsonDataList = response.data;

        List<Post> fetchedPosts = jsonDataList.map((jsonData) => Post.fromJson(jsonData)).toList();

        // Update the screen with the fetched data
        setState(() {
          posts = fetchedPosts;
          isDataLoaded = true; // Set the flag to true when data is loaded
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Publication',
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddPostScreen(
                          a: widget.analytics,
                          o: widget.observer,
                        )));
              },
              child: Padding(
                padding: EdgeInsets.only(top: 20, right: 10),
                child: Text(
                  'Ajouter',
                  style: Theme.of(context).primaryTextTheme.overline,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Container(
                height: 37,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(Icons.search),
                    ),
                    hintText: 'rechercher',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              isDataLoaded
                  ? Expanded(
                      child: ListView.builder(
                          shrinkWrap: true, // Set to true to make the ListView adapt to its content
                          itemCount: posts.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  // height: 365,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Theme.of(context).primaryColor,
                                                  radius: 25,
                                                  child: CircleAvatar(
                                                    radius: 24,
                                                    child: Icon(FontAwesomeIcons.user),
                                                    backgroundColor: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    post.titre,
                                                    style: Theme.of(context).primaryTextTheme.headline1,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15, top: 10),
                                        child: Text(post.description),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        width: MediaQuery.of(context).size.width,
                                        height: 220,
                                        decoration: BoxDecoration(
                                          //  color: Colors.red,
                                          image: posts[index].image != null ? DecorationImage(image: NetworkImage(posts[index].image)) : null,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              width: 70,
                                              // color: Colors.red,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(FontAwesomeIcons.heart),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 5, top: 5),
                                                        child: Text('${Random().nextInt(4)}'),
                                                      )
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => CommentScreen(
                                                                a: widget.analytics,
                                                                o: widget.observer,
                                                              )));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.message),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 5, top: 5),
                                                          child: Text('0'),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(FontAwesomeIcons.share),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5, top: 0, right: 10),
                                                  child: Text('partager'),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : CircularProgressIndicator(),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the method to fetch data
  }
}
