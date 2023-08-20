import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pet_user_app/models/businessLayer/baseRoute.dart';
import 'package:pet_user_app/screens/forgotPasswordScreen.dart';
import 'package:pet_user_app/screens/logInScreen1.dart';
import 'package:pet_user_app/widgets/bottomNavigationBarWidget.dart';

import '../controllers/ApiController.dart';
import '../network/remote/Requests/login_request.dart';
import '../network/services/ApiService.dart';

class LogInScreen2 extends BaseRoute {
  // LogInScreen2() : super();
  final String email;

  LogInScreen2({this.email, a, o}) : super(a: a, o: o, r: 'LogInScreen2');

  @override
  _LogInScreen2State createState() => new _LogInScreen2State();
}

class _LogInScreen2State extends BaseRouteState {
  bool _showPassword = true;

  _LogInScreen2State() : super();

  final ApiController apiController = Get.put(ApiController());
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add this key

  // void _handleLogin() {
  //   var loginRequest = new LoginRequest(
  //     email: widget.email,
  //     password: _passwordController.text,
  //   );
  //   print(loginRequest.toJson());
  //
  //   ApiService.login(loginRequest);
  // }

  @override
  Widget build(BuildContext context) {
    // final ApiController apiController = Get.find<ApiController>();
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
                    'Entrez le mot de passe',
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'que vous avez utilisé lors de l\'inscription.',
                    style: Theme.of(context).primaryTextTheme.subtitle1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Text('Mot de passe',
                          style: Theme.of(context).primaryTextTheme.headline6),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      obscureText: _showPassword,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre mot de passe';
                        }
                        if (value.length < 6) {
                          return 'Le mot de passe doit contenir au moins 6 caractères';
                        }
                        return null;
                      },
                      // controller: _cForgotEmail,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            _showPassword = !_showPassword;
                            setState(() {});
                          },
                        ),
                        hintText: '***************',
                        // prefixIcon: Icon(Icons.mail),
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                        },
                        child: Text('Mot de passe oublié ?',
                            style:
                                Theme.of(context).primaryTextTheme.headline6),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(top: 70),
                    child: Container(
                      // color: Colors.red,
                      height: 45,
                      // padding: EdgeInsets.only(left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                        onPressed: () async {
                          // print('Hello');
                          if (_formKey.currentState.validate()) {
                            var response = await apiController.loginUser(
                                widget.email, _passwordController.text);

                            if (response.status == false) {
                              MotionToast(
                                icon: Icons.warning,
                                primaryColor: Colors.red,
                                title: Text("Error de connection"),
                                description: Text(
                                    "Votre email ou mot de passe sont incorrectes!"),
                                width: 300,
                                height: 100,
                              ).show(context);
                              return;
                            }

                            MotionToast(
                                icon: Icons.verified,
                                primaryColor: Colors.green,
                                title: Text("Success"),
                                description:
                                    Text("Vous êtes connecté avec succes!"),
                                width: 300,
                                height: 100,
                                onClose: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationWidget(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                }).show(context);
                          }
                        },
                        child: apiController.isLoading.value
                            ? Center(child: const CircularProgressIndicator())
                            : Text("Se connecter"), // Show "Log In" button
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;

  @override
  void initState() {
    super.initState();
  }
}
