import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/models/pet.dart';
import 'package:pet_user_app/models/user.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/ApiController.dart';
import '../models/service.dart';
import '../network/remote/Requests/create_reservation.dart';

class ReviewBookingScreen extends BaseRoute {
  // ReviewBookingScreen() : super();
  final User user;
  final Service service;
  ReviewBookingScreen({@required this.user, @required this.service, a, o})
      : super(a: a, o: o, r: 'ReviewBookingScreen');

  @override
  _ReviewBookingScreenState createState() => new _ReviewBookingScreenState();
}

class _ReviewBookingScreenState extends BaseRouteState {
  bool _isChecked = false;
  bool _isChecked1 = false;

  _ReviewBookingScreenState() : super();
  bool confirm = false;
  double ratingVal = 0.0;

  final ApiController apiController = Get.find<ApiController>();
  Pet selectedAnimal;
  bool isAnimalSelected = false;

  TextEditingController _durationController = TextEditingController();

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
        title: Text(
          'Réservation',
          style: Theme.of(context).primaryTextTheme.headline1,
        ),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 15),
        //     child: Icon(
        //       Icons.shopping_cart_outlined,
        //       color: Color(0xFF34385A),
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 0, left: 10),
              // color: Colors.red,
              height: 160,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: CircleAvatar(
                        radius: 70,
                        backgroundImage: widget?.user?.imageLink != ""
                            ? NetworkImage(widget.user?.imageLink)
                            : AssetImage("assets/splashLogo.png")),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.user.fullName,
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 4, right: 10),
                          child: RatingBar.builder(
                            initialRating: ratingVal,
                            minRating: 0,
                            // direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            ignoreGestures: true,
                            updateOnDrag: false,
                            onRatingUpdate: (val) {},
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          width: 100,
                          height: 30,
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 15,
                                color: Color(0xff8f8f8f),
                              ),
                              Text(
                                '${widget.service.price} dt / jour',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              // padding: const EdgeInsets.
            ),
            Divider(
              height: 10,
              thickness: 1,
            ),
            Container(

                // color: Colors.red,
                margin: EdgeInsets.only(bottom: 10, top: 5),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _selectBookingFor(context);
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Réservation pour',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(),
                              child: Row(
                                children: [
                                  Text(isAnimalSelected
                                      ? selectedAnimal.petName
                                      : "Selectionner l'animal"),
                                  Icon(Icons.arrow_forward_ios_outlined,
                                      size: 18, color: Color(0xFF8F8F8F)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Divider(
                        height: 10,
                        thickness: 1,
                      ),
                    )
                  ],
                )),
            GestureDetector(
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020, 10, 1),
                  lastDate: DateTime(2030, 3, 1),
                );
                if (selectedDate != null) {
                  setState(() {
                    _selectedDay = selectedDate;
                  });
                }
              },
              child: Container(

                  // color: Colors.red,
                  margin: EdgeInsets.only(bottom: 10, top: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Date début',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(),
                              child: Row(
                                children: [
                                  Text(_selectedDay != null
                                      ? "${_selectedDay.month.toString().padLeft(2, '0')}/${_selectedDay.day.toString().padLeft(2, '0')}/${_selectedDay.year.toString()}"
                                      : DateTime.now().toString()),
                                  Icon(Icons.arrow_forward_ios_outlined,
                                      size: 18, color: Color(0xFF8F8F8F)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 15,
                        ),
                        child: Divider(
                          height: 10,
                          thickness: 1,
                        ),
                      )
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {
                _selectpickupdate(context);
              },
              child: Container(

                  // color: Colors.red,
                  margin: EdgeInsets.only(bottom: 10, top: 5),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Durée (en jours)',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(),
                              child: Row(
                                children: [
                                  // TextFormField(
                                  //   controller: _durationController,
                                  //   decoration: InputDecoration(
                                  //     hintText: 'Durée (en jours)',
                                  //     contentPadding:
                                  //         EdgeInsets.only(top: 5, left: 10),
                                  //   ),
                                  // ),
                                  Icon(Icons.arrow_forward_ios_outlined,
                                      size: 18, color: Color(0xFF8F8F8F)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 15,
                        ),
                        child: Divider(
                          height: 10,
                          thickness: 1,
                        ),
                      )
                    ],
                  )),
            ),
            // GestureDetector(
            //   onTap: () {
            //     _selectNumberOfMeals(context);
            //   },
            //   child: Container(

            //       // color: Colors.red,
            //       margin: EdgeInsets.only(bottom: 10, top: 5),
            //       width: MediaQuery.of(context).size.width,
            //       child: Column(
            //         children: [
            //           Container(
            //             margin: EdgeInsets.all(5),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Row(
            //                   children: [
            //                     Padding(
            //                       padding: EdgeInsets.only(left: 15),
            //                       child: Row(
            //                         children: [
            //                           Text(
            //                             'Meals per days',
            //                             style: Theme.of(context)
            //                                 .primaryTextTheme
            //                                 .bodyText1,
            //                           ),
            //                           SizedBox(
            //                             width: 10,
            //                           ),
            //                           Text('50/meals')
            //                         ],
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: EdgeInsets.only(),
            //                   child: Row(
            //                     children: [
            //                       Text('Select Number'),
            //                       Icon(Icons.arrow_forward_ios_outlined,
            //                           size: 18, color: Color(0xFF8F8F8F)),
            //                     ],
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           Container(
            //             child: Divider(
            //               height: 10,
            //               thickness: 1,
            //             ),
            //           )
            //         ],
            //       )),
            // ),

            // price detail box

            confirm
                ? Container(
                    margin: EdgeInsets.only(bottom: 10, top: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Price Details',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Container(
                                          width: 60,
                                          child: Text(
                                            'Fluffy',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          '4 days',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Base Price',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Rs2800',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Container(
                                          width: 60,
                                          child: Text(
                                            'Cookies',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          '4 days',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Base Price',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Rs2800',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 10),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 15),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        child: Text(
                                                          'Meals',
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        '16 meals',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .subtitle2,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Rs800',
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 10),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 15),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Total',
                                                        style: Theme.of(context)
                                                            .primaryTextTheme
                                                            .headline1,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Rs6400',
                                                    style: Theme.of(context)
                                                        .primaryTextTheme
                                                        .headline1,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ))
                : SizedBox()
          ],
        ),
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
                  onPressed: () async {
                    addToCartDialogBox(context);
                    CreateReservation createReservation = CreateReservation(
                        sitterId: widget.user.id,
                        petId: selectedAnimal.id,
                        serviceId: widget.service.id,
                        type: widget.service.serviceName,
                        dateDeb:
                            "${_selectedDay.month.toString().padLeft(2, '0')}/${_selectedDay.day.toString().padLeft(2, '0')}/${_selectedDay.year.toString()}",
                        duration: int.parse(_durationController.text),
                        prixTotal: widget.service.price);

                    print(
                        "RESEVRATION REQUEST: ${createReservation.toString()}");

                    await this
                        .apiController
                        .createReservation(createReservation);
                  },
                  child: Text(
                    "Réservée",
                  ))),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
  }

  void _selectBookingFor(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            height: 315,
            child: Scaffold(
              body: Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        //  color: Colors.cyan,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Reserver Pour',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline1,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    itemCount: this.apiController.pets.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var pet = this.apiController.pets[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAnimal = pet;
                            isAnimalSelected = true;
                          });
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(2),
                                  horizontalTitleGap: 1,
                                  leading: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: CircleAvatar(
                                          radius: 40,
                                          // backgroundColor: Colors.red,
                                          backgroundImage:
                                              NetworkImage(pet.petImageLink)),
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(pet.petName,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1),
                                      Icon(
                                          pet.petGender == "Homme"
                                              ? Icons.male
                                              : Icons.female,
                                          color: Color(0xff8f8f8f))
                                    ],
                                  ),
                                  subtitle: Text(pet.petGender),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              // bottomNavigationBar: BottomAppBar(
              //   elevation: 0,
              //   child: Container(
              //       // color: Colors.red,
              //       height: 45,
              //       padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              //       width: MediaQuery.of(context).size.width,
              //       child: TextButton(
              //           onPressed: () {
              //             setState(() {});
              //             Navigator.of(context).pop();
              //             setState(() {});
              //           },
              //           child: Text(
              //             "Confirm",
              //           ))),
              // ),
            ),
          );
        });
  }

  void _selectNumberOfMeals(context) {
    showModalBottomSheet(
        backgroundColor: Colors.red,
        context: context,
        builder: (BuildContext ctx) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                  // color: Colors.cyan,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: 180,
              child: Scaffold(
                body: Wrap(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Select Number',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline1,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [Container()],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Wrap(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Text('1'),
                                  radius: 30,
                                ),
                              ),
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Text('2'),
                                  radius: 30,
                                ),
                              ),
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Text('3',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .button),
                                  radius: 30,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: BottomAppBar(
                  elevation: 0,
                  child: Container(
                      // color: Colors.red,
                      height: 45,
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ReviewBookingScreen()));
                            setState(() {
                              confirm = true;
                            });
                          },
                          child: Text(
                            "Confirm",
                          ))),
                ),
              ),
            );
          });
        });
  }

  void _selectdropoffdate(context) {
    showModalBottomSheet(
      context: context,
      //  isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: Container(
            child: Column(
              children: [
                Container(
                  child: TextButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020, 10, 1),
                        lastDate: DateTime(2030, 3, 1),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _selectedDay = selectedDate;
                        });
                      }
                    },
                    child: Text(
                      'Select Date',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _selectpickupdate(context) {
    showModalBottomSheet(
      context: context,
      //  isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: Container(
            child: Column(
              children: [
                TextFormField(
                  controller: _durationController,
                  decoration: InputDecoration(
                    hintText: 'Durée (en jours)',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  addToCartDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              content: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Center(
                                  child: Text(
                                "Succès",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline1,
                              )),
                              Center(
                                  child: Text(
                                "Merci d'avoir choisi Pet-Cares",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1,
                              )),
                              Container(
                                height: 150,
                                width: 200,
                                child:
                                    Image.asset('assets/alertdialogimage.png'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -70.0,
                    left: 110,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            shape: BoxShape.circle,
                            color: Colors.transparent),
                        height: 28,
                        width: 25,
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.times,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}

                    // String formattedFirstDate =
                    //     "${firstDate.month.toString().padLeft(2, '0')}/${firstDate.day.toString().padLeft(2, '0')}/${firstDate.year.toString()}";
                    // String formattedLastDate =
                    //     "${lastDate.month.toString().padLeft(2, '0')}/${lastDate.day.toString().padLeft(2, '0')}/${lastDate.year.toString()}";
                    // print("FIRST DATE $formattedFirstDate");
                    // print("LAST DATE $formattedLastDate");