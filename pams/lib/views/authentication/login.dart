import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pams/providers/auth_provider.dart';
import 'package:pams/providers/provider_services.dart';
import 'package:pams/styles/custom_colors.dart';
import 'package:pams/utils/svg_images.dart';
import 'package:pams/utils/validators.dart';
import 'package:pams/views/authentication/forgotpassword.dart';
import 'package:pams/views/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool btnState = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    var _authViewModel = ref.watch(authViewModel);
    var _loading = ref.watch(loadingState);
    return Scaffold(
      backgroundColor: Color(0xff194A00),
      body: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            children: <Widget>[
              Container(
                height: 300,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset(
                    secondTopLeftLogoIcon,
                    height: 300,
                    width: 500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                      color: CustomColors.lightDarkGreen,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: CustomColors.mainDarkGreen))),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            ],
                            controller: _emailTextController,
                            validator: (value) {
                              return Validators.isEmailStr(value.toString());
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_rounded,
                                color: CustomColors.mainDarkGreen,
                                size: 28,
                              ),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: 'Email',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: CustomColors.mainDarkGreen))),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            ],
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            obscureText: hide,
                            controller: _passwordTextController,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      hide = !hide;
                                    });
                                  },
                                  child: hide
                                      ? Icon(
                                          Icons.visibility_off,
                                          size: 28,
                                          color: CustomColors.mainDarkGreen,
                                        )
                                      : Icon(
                                          Icons.remove_red_eye,
                                          size: 28,
                                          color: CustomColors.mainDarkGreen,
                                        )),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 28,
                                color: CustomColors.mainDarkGreen,
                              ),
                              hintText: 'password',
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text('Forgot Password'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: CustomColors.mainDarkGreen,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Center(
                                  child: _loading
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: CustomColors.background,
                                          ),
                                        )
                                      : Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                ),
                              ),
                            ),
                            onTap: () async {
                              _loading = true;
                              final _validate =
                                  _authViewModel.validateAndSave(_formKey);
                              if (_validate) {
                                _authViewModel.userLoginService(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text);
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  validateInputs() async {
    var _authViewModel = ref.watch(authViewModel);
    setState(() {
      btnState = true;
    });
    var state = _formKey.currentState;
    if (!state!.validate()) {
    } else {
      state.save();
      _authViewModel.userLoginService(
          email: _emailTextController.text,
          password: _passwordTextController.text);
      setState(() {
        btnState = false;
      });
    }
  }
}
