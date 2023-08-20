import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/network/remote/Requests/create_pet_request.dart';
import 'package:pet_user_app/screens/profileScreen.dart';

import '../controllers/ApiController.dart';

class AddPetScreen extends BaseRoute {
  // SIgnUpScreen() : super();
  AddPetScreen({a, o}) : super(a: a, o: o, r: 'SIgnUpScreen');

  @override
  _AddPetScreenState createState() => new _AddPetScreenState();
}

class _AddPetScreenState extends BaseRouteState {
  _AddPetScreenState() : super();

  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petAgeController = TextEditingController();
  final TextEditingController _petImageLinkController = TextEditingController();
  final TextEditingController _petTypeController = TextEditingController();
  final TextEditingController _petBreedController = TextEditingController();
  final TextEditingController _petGenderController = TextEditingController();
  final TextEditingController _petBloodPressureController =
      TextEditingController();
  final TextEditingController _petBoneDensityController =
      TextEditingController();
  final TextEditingController _petWeightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ApiController apiController = Get.find<ApiController>();
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
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
            child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text(
                  'Ajouter votre animal !',
                  style: Theme.of(context).primaryTextTheme.headline5,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Remplissez le formulaire ci-dessous",
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: _petNameController,
                  decoration: InputDecoration(
                    hintText: 'Nom  ',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: _petAgeController,
                  decoration: InputDecoration(
                    hintText: 'Âge  ',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: _petImageLinkController,
                  decoration: InputDecoration(
                    hintText: 'Lien de l\'image  ',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: _petTypeController,
                  decoration: InputDecoration(
                    hintText: 'Type d\'animal',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: _petBreedController,
                  decoration: InputDecoration(
                    hintText: 'Race  ',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: _petGenderController,
                  decoration: InputDecoration(
                    hintText: 'Genre  ',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: _petBloodPressureController,
                  decoration: InputDecoration(
                    hintText: 'Pression artérielle  ',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: _petBoneDensityController,
                  decoration: InputDecoration(
                    hintText: 'Densité osseuse  ',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: _petWeightController,
                  decoration: InputDecoration(
                    hintText: 'Poids  ',
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: Container(
        height: 155,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // color: Colors.red,
              height: 45,
              padding: EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => TextButton(
                  // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                  onPressed: () async {
                    // print('Hello');
                    var isLoading = await apiController.addPet(
                      CreatePetRequest(
                        petName: _petNameController.text,
                        petAge: _petAgeController.text,
                        petImageLink: _petImageLinkController.text,
                        petType: _petTypeController.text,
                        petBreed: _petBreedController.text,
                        petGender: _petGenderController.text,
                        petBloodPressure: _petBloodPressureController.text,
                        petBoneDensity: _petBoneDensityController.text,
                        petWeight: _petWeightController.text,
                        petOwner: apiController.user.value.email,
                      ),
                    );

                    if (!isLoading && apiController.error.value == "") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                                a: widget.analytics,
                                o: widget.observer,
                              )));
                    }
                  },
                  child: apiController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : Text(
                          "Ajouter votre animal",
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
}
