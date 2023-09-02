import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/screens/service_screen.dart';

import '../controllers/ApiController.dart';

class HomeScreen extends BaseRoute {
  // HomeScreen() : super();
  HomeScreen({a, o}) : super(a: a, o: o, r: 'HomeScreen');
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends BaseRouteState {
  int selectedValue = 0;
  _HomeScreenState() : super();

  final ApiController apiController = Get.find<ApiController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await this.apiController.fetchAllServices();
      await this.apiController.fetchAllOffres();
      await this.apiController.fetchAllArticles();
      print("ARTICLES: ${this.apiController.articles.length}");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 300,
          backgroundColor: Colors.transparent,
          leading: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(
                  Icons.pets,
                  color: Color(0xFF34385A),
                  size: 28,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 15),
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pets-care',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(),
                    //   child: Row(
                    //     children: [
                    //       Text('via Parle',
                    //           style:
                    //               Theme.of(context).primaryTextTheme.subtitle2),
                    //       Icon(
                    //         Icons.arrow_back_ios_outlined,
                    //         color: Colors.black,
                    //         size: 15,
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 15),
          //     child: GestureDetector(
          //       onTap: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //             builder: (context) => CartScreen(
          //                   a: widget.analytics,
          //                   o: widget.observer,
          //                 )));
          //       },
          //       child: Icon(
          //         Icons.shopping_cart_outlined,
          //         color: Color(0xFF34385A),
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
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
                    hintText: 'Chercher',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Text(
                        'Que recherchez-vous ?',
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text('Nos services', style: Theme.of(context).primaryTextTheme.subtitle2),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 160,
                width: MediaQuery.of(context).size.width,
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: this.apiController.services.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      var service = this.apiController.services[index];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ServiceScreen(
                                        service: service,
                                        a: widget.analytics,
                                        o: widget.observer,
                                      )));
                            },
                            child: Container(
                              // color: Colors.red,
                              width: 90,
                              height: 150,
                              child: Card(
                                elevation: 5,
                                child: Column(
                                  children: [
                                    service.imageLink != ""
                                        ? Image.network(
                                            service.imageLink,
                                            width: 90,
                                            height: 100,
                                            fit: BoxFit.contain,
                                          )
                                        : Image.asset("assets/homepetboarding.png", fit: BoxFit.cover),
                                    Text(
                                      service.serviceName,
                                      style: Theme.of(context).primaryTextTheme.headline6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Les meilleurs offres', style: Theme.of(context).primaryTextTheme.bodyText1),
                    Text(
                      'Tout afficher',
                      style: Theme.of(context).primaryTextTheme.headline6,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 90,
                  child: Obx(
                    () => PageView.builder(
                      onPageChanged: (val) {
                        selectedValue = val;
                        setState(() {});
                      },
                      itemCount: this.apiController.offres.length,
                      itemBuilder: (context, position) {
                        var offre = this.apiController.offres[position];
                        return Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 100,
                                  // color: Colors.red,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
                                        child: Text(offre.description, style: Theme.of(context).primaryTextTheme.headline3),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            Text('01/07 -> 31/08', style: Theme.of(context).primaryTextTheme.headline2),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(
                                            //       left: 2, right: 2),
                                            //   child: Icon(
                                            //     Icons.circle,
                                            //     size: 10,
                                            //     color: Colors.white,
                                            //   ),
                                            // ),
                                            // Text(
                                            //   '->',
                                            //   style: Theme.of(context)
                                            //       .primaryTextTheme
                                            //       .headline2,
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 2, right: 2),
                                              child: Icon(
                                                Icons.circle,
                                                size: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text('${offre.prix}/ mois', style: Theme.of(context).primaryTextTheme.headline2)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                      radius: 30,
                                      // backgroundColor: Colors.red,
                                      backgroundImage: AssetImage('assets/home4.png')),
                                )
                              ],
                            ),
                            DotsIndicator(
                              dotsCount: this.apiController.offres.length,
                              position: double.parse(selectedValue.toString()),
                              decorator: DotsDecorator(
                                color: Colors.black87, // Inactive color
                                activeColor: Color(0xFFF0900C),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Articles', style: Theme.of(context).primaryTextTheme.bodyText1),
                    Text('Tout afficher', style: Theme.of(context).primaryTextTheme.headline6)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Obx(
                  () => ListView.builder(
                    itemCount: this.apiController.articles.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var article = this.apiController.articles[index];
                      var now = DateTime.now();
                      return Container(
                        height: 110,
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          elevation: 5,
                          child: Container(
                              padding: EdgeInsets.all(3),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      article.imageLink),
                                                  fit: BoxFit.cover),
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              )),
                                          height: 70,
                                          width: 80,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 2,
                                              bottom: 2,
                                              left: 7,
                                              right: 7),
                                          margin: EdgeInsets.only(top: 3),
                                          child: Text(article.type,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .headline6),
                                          decoration: BoxDecoration(
                                              color: Color(0xFFc9d0f2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 10),
                                      // color: Colors.green,
                                      width: MediaQuery.of(context).size.width - 134,
                                      height: 120,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                article.type,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText1,
                                              ),
                                              Icon(
                                                Icons.bookmark,
                                                color: Theme.of(context).primaryColor,
                                              )
                                            ],
                                          ),
                                          Text(
                                              "${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}/${now.year.toString()}"),
                                          Expanded(
                                            child: Text(
                                              article.details,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context).primaryTextTheme.subtitle2,
                                              maxLines: 3,
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  // bool isloading = true;

  // @override
  // void initState() {
  //   super.initState();
  // }
}
