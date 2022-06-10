import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pams/providers/auth_provider.dart';
import 'package:pams/styles/custom_colors.dart';
import 'package:pams/utils/images.dart';
import 'package:pams/utils/shared_pref_manager.dart';
import 'package:pams/views/authentication/auth.dart';
import 'package:pams/views/profile/editemail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  GetStorage userdata = GetStorage();
  @override
  Widget build(BuildContext context) {
    var _authViewModel = ref.watch(authViewModel);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Profile",
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 110,
                width: 90,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(userAvatar)),
                    border: Border.all(
                      style: BorderStyle.solid,
                      width: 6.0,
                    ),
                    shape: BoxShape.circle),
              ),
              Text(userdata.read('name') ?? "",
                  style: TextStyle(
                    fontSize: 30,
                  )),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(boxShadow: [
                  // to make elevation
                  BoxShadow(
                    color: Colors.grey[300]!,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                  // to make the coloured border
                  BoxShadow(
                    offset: Offset(0, 0.5),
                  ),
                ], color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(userdata.read('name'),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.blackColor)),
                      Text("Account name",
                          style: TextStyle(
                              fontSize: 12, color: CustomColors.blackColor)),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(boxShadow: [
                  // to make elevation
                  BoxShadow(
                    color: Colors.grey[300]!,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                  // to make the coloured border
                  BoxShadow(
                    color: CustomColors.blackColor,
                    offset: Offset(0, 0.5),
                  ),
                ], color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(userdata.read('role'),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.blackColor)),
                      Text("Current position",
                          style: TextStyle(
                              fontSize: 12, color: CustomColors.blackColor)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => EditEmail()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(boxShadow: [
                    // to make elevation
                    BoxShadow(
                      color: Colors.grey[300]!,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                    // to make the coloured border
                    BoxShadow(
                      color: CustomColors.blackColor,
                      offset: Offset(0, 0.5),
                    ),
                  ], color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(userdata.read('email'),
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.blackColor)),
                            Text("Email address",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: CustomColors.blackColor)),
                          ],
                        ),
                        // Icon(Icons.arrow_forward_ios_sharp,
                        //     size: 16, color: CustomColors.blackColor),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  _onWillPop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(boxShadow: [
                    // to make elevation
                    BoxShadow(
                      color: Colors.grey[300]!,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                    // to make the coloured border
                    BoxShadow(
                      color: CustomColors.blackColor,
                      offset: Offset(0, 0.5),
                    ),
                  ], color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text("Logout",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    print("======Logout=======");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('you want to Logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () {
                  prefs.remove("apiToken");
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => AuthPage()),
                      (route) => false);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
