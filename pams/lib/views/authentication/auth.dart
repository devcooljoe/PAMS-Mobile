import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pams/styles/custom_colors.dart';
import 'package:pams/utils/images.dart';
import 'package:pams/utils/permission_handlers.dart';
import 'package:pams/utils/svg_images.dart';
import 'package:pams/views/authentication/login.dart';
import 'forgotpassword.dart';
import 'package:get/get.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    askPermision();
    super.initState();
  }

  askPermision() async {
    await PermissionService().permissionHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.lightDarkGreen,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(
                topLeftLogoIcon,
                height: 150,
                width: 350,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain, image: AssetImage(appLogoIcon))),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(() => LoginPage());
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: CustomColors.mainDarkGreen,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          fontSize: 20, color: CustomColors.background),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()));
              },
              child: Center(
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                    color: CustomColors.blackColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
