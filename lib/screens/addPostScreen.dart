import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/screens/postListScreen.dart';

class AddPostScreen extends BaseRoute {
  // AddPostScreen() : super();
  AddPostScreen({a, o}) : super(a: a, o: o, r: 'AddPostScreen');
  @override
  _AddPostScreenState createState() => new _AddPostScreenState();
}

class _AddPostScreenState extends BaseRouteState {
  File _tImage;
  _AddPostScreenState() : super();
  TextEditingController titreController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController lienImageController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controllers when the screen is disposed
    titreController.dispose();
    descriptionController.dispose();
    lienImageController.dispose();
    super.dispose();
  }

  // Use this function to send the data to the API
  void submitPost() {
    final String titre = titreController.text;
    final String description = descriptionController.text;
    final String imageLink = lienImageController.text;

    // Validate the data as needed before sending it to the API

    final Map<String, dynamic> postData = {
      "titre": titre,
      "description": description,
      "image": imageLink,
      "userId": "dzzdzdzdsvdvdsdesdss",
    };

    final Map<String, dynamic> headers = {
      // Add any headers needed for your API request
    };

    createNewPost(postData, headers);
  }

  Future<void> createNewPost(Map<String, dynamic> data, Map<String, dynamic> headers) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://us-central1-petcare-a1918.cloudfunctions.net/api/publications/create',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print('New post created successfully.');
        print(json.encode(response.data));
      } else {
        print('Failed to create a new post. Status code: ${response.statusCode}');
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error while creating a new post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF34385A),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Ajouter une publication',
            style: Theme.of(context).primaryTextTheme.headline1,
          )),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: BottomAppBar(
          elevation: 0,
          child: Container(
              // color: Colors.red,
              height: 45,
              padding: EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                  onPressed: () {
                    print('');
                    submitPost();
                    MotionToast(
                        icon: Icons.verified,
                        primaryColor: Colors.green,
                        title: Text("Success"),
                        description: Text("Vous êtes connecté avec succes!"),
                        width: 300,
                        height: 100,
                        onClose: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostListScreen()));
                        }).show(context);
                  },
                  child: Text(
                    "Publier",
                  ))),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
            child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Post',
                  style: Theme.of(context).primaryTextTheme.headline4,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller: titreController, // Add the controller here
                  decoration: InputDecoration(
                    hintText: 'Titre',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Description',
                  style: Theme.of(context).primaryTextTheme.headline4,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller: descriptionController, // Add the controller here
                  decoration: InputDecoration(
                    hintText: 'Description',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Lien image',
                  style: Theme.of(context).primaryTextTheme.headline4,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller: lienImageController, // Add the controller here
                  decoration: InputDecoration(
                    hintText: 'Lien',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Upload Image',
                  style: Theme.of(context).primaryTextTheme.headline4,
                ),
              ),
              lienImageController.text.isNotEmpty
                  ? Container(
                      height: 250,
                      // width: double.infinity,
                      child: Image.network(
                        lienImageController.text, // Load the network image if the text is not empty
                        fit: BoxFit.cover,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                          child: DottedBorder(
                        color: Theme.of(context).primaryColor, //color of dotted/dash line
                        strokeWidth: 1, //thickness of dash/dots
                        dashPattern: [10, 6],
                        child: !lienImageController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _showCupertinoModalSheet();
                                },
                                child: Container(
                                  height: 250,
                                  width: double.infinity,
                                  child: Center(child: Text('Ajouter une image')),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  _showCupertinoModalSheet();
                                },
                                child: Container(
                                  height: 250,
                                  // width: double.infinity,
                                  child: Image.network(
                                    "https://miro.medium.com/v2/resize:fit:1400/1*GGF8iJiqW_6olq_3VX7N0g.jpeg", // Load the network image if the text is not empty
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      )),
                    )
            ],
          ),
        )),
      ),
    );
  }

  _showCupertinoModalSheet() {
    try {
      FocusScope.of(context).unfocus();
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text('Actions'),
          actions: [
            CupertinoActionSheetAction(
              child: Text('Take Picture', style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.openCamera();
                hideLoader();

                print('Image Path : ${_tImage.path}');
                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Choose from gallery', style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.selectImageFromGallery();
                hideLoader();
                print('Image Path : ${_tImage.path}');
                setState(() {});
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Cancel', style: TextStyle(color: Color(0xFFFA692C))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - addServicesScreen.dart - _showCupertinoModalSheet():" + e.toString());
    }
  }

  bool isloading = true;

  @override
  void initState() {
    super.initState();
  }
}
