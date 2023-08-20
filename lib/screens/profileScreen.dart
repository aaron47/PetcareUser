import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/network/services/ApiService.dart';
import 'package:pet_user_app/screens/ReminderScreen.dart';
import 'package:pet_user_app/screens/addPetScreen.dart';
import 'package:pet_user_app/screens/myWalletScreen.dart';
import 'package:pet_user_app/screens/notificationScreen.dart';
import 'package:pet_user_app/screens/petProfileScreen.dart';
import 'package:pet_user_app/screens/settingScreen.dart';
import 'package:pet_user_app/screens/userAccountScreen.dart';
import 'package:pet_user_app/screens/wishListScreen.dart';

import '../controllers/ApiController.dart';
import '../models/pet.dart';

class ProfileScreen extends BaseRoute {
  // ProfileScreen() : super();
  ProfileScreen({a, o}) : super(a: a, o: o, r: 'ProfileScreen');

  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends BaseRouteState {
  _ProfileScreenState() : super();

  final ApiController apiController = Get.put(ApiController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await apiController.fetchUserPets(apiController.user.value
          .email); // Replace 'userEmail' with the actual user's email
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.add,
            size: 0,
          ),
          title: Text(
            'Profile',
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SettingScreen(
                            a: widget.analytics,
                            o: widget.observer,
                          )));
                },
                child: Icon(
                  Icons.settings,
                  color: Color(0xFF34385A),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 0),
                  // color: Colors.red,
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(
                                apiController.user.value.imageLink)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Obx(
                          () => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                apiController.user.value.fullName ?? "",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 10),
                                child: Text(
                                  apiController.user.value.role ?? "",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(6),
                                width: 85,
                                height: 30,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserAccountScreen(
                                                  a: widget.analytics,
                                                  o: widget.observer,
                                                )));
                                  },
                                  child: Text(
                                    'Modifier Profile',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).primaryColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  // padding: const EdgeInsets.
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => RemindeScreen(
                //               a: widget.analytics,
                //               o: widget.observer,
                //             )));
                //   },
                //   child: Container(
                //       // color: Colors.red,
                //       margin: EdgeInsets.only(bottom: 10, top: 35),
                //       width: MediaQuery.of(context).size.width,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Row(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.only(),
                //                 child: Icon(
                //                   FontAwesomeIcons.clock,
                //                   color: Theme.of(context).primaryColor,
                //                   size: 18,
                //                 ),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.only(left: 15),
                //                 child: Text(
                //                   'Reminder',
                //                   style: Theme.of(context)
                //                       .primaryTextTheme
                //                       .bodyText1,
                //                 ),
                //               )
                //             ],
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(),
                //             child: Icon(Icons.arrow_forward_ios_outlined,
                //                 size: 18, color: Color(0xFF8F8F8F)),
                //           )
                //         ],
                //       )),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => NotificationScreen(
                //               a: widget.analytics,
                //               o: widget.observer,
                //             )));
                //   },
                //   child: Container(
                //       margin: EdgeInsets.only(top: 10, bottom: 10),
                //       // color: Colors.red,
                //       width: MediaQuery.of(context).size.width,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Row(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.only(),
                //                 child: Icon(
                //                   Icons.notifications_none_outlined,
                //                   size: 18,
                //                   color: Theme.of(context).primaryColor,
                //                 ),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.only(left: 15),
                //                 child: Text(
                //                   'Notifications',
                //                   style: Theme.of(context)
                //                       .primaryTextTheme
                //                       .bodyText1,
                //                 ),
                //               )
                //             ],
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(),
                //             child: Icon(Icons.arrow_forward_ios_outlined,
                //                 size: 18, color: Color(0xFF8F8F8F)),
                //           )
                //         ],
                //       )),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => MyWalletScreen(
                //               a: widget.analytics,
                //               o: widget.observer,
                //             )));
                //   },
                //   child: Container(
                //       margin: EdgeInsets.only(top: 10, bottom: 10),
                //       // color: Colors.red,
                //       width: MediaQuery.of(context).size.width,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Row(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.only(),
                //                 child: Icon(
                //                   FontAwesomeIcons.wallet,
                //                   size: 18,
                //                   color: Theme.of(context).primaryColor,
                //                 ),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.only(left: 15),
                //                 child: Text(
                //                   'My Wallet',
                //                   style: Theme.of(context)
                //                       .primaryTextTheme
                //                       .bodyText1,
                //                 ),
                //               )
                //             ],
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(),
                //             child: Icon(Icons.arrow_forward_ios_outlined,
                //                 size: 18, color: Color(0xFF8F8F8F)),
                //           )
                //         ],
                //       )),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => WishListScreen(
                //               a: widget.analytics,
                //               o: widget.observer,
                //             )));
                //   },
                //   child: Container(
                //       margin: EdgeInsets.only(top: 10, bottom: 10),
                //       // color: Colors.red,
                //       width: MediaQuery.of(context).size.width,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Row(
                //             children: [
                //               Padding(
                //                 padding: EdgeInsets.only(),
                //                 child: Icon(
                //                   FontAwesomeIcons.heart,
                //                   size: 18,
                //                   color: Theme.of(context).primaryColor,
                //                 ),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.only(left: 15),
                //                 child: Text(
                //                   'Wishlist',
                //                   style: Theme.of(context)
                //                       .primaryTextTheme
                //                       .bodyText1,
                //                 ),
                //               )
                //             ],
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(),
                //             child: Icon(Icons.arrow_forward_ios_outlined,
                //                 size: 18, color: Color(0xFF8F8F8F)),
                //           )
                //         ],
                //       )),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mes animaux',
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddPetScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                        },
                        child: Text(
                          '+ Ajouter',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 132,
                  child: Obx(() {
                    if (apiController.isLoading.value) {
                      return Center(
                          child:
                              CircularProgressIndicator()); // Show loading indicator
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: apiController.pets.length,
                        itemBuilder: (context, index) {
                          final pet = apiController.pets[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PetProfileScreen(
                                        a: widget.analytics,
                                        o: widget.observer,
                                        pet: pet,
                                      )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(pet.petImageLink),
                                    radius: 45,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text(pet.petName),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
}
