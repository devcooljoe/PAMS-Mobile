import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pams/providers/auth_provider.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/providers/provider_services.dart';
import 'package:pams/styles/custom_colors.dart';
import 'package:pams/utils/images.dart';
import 'package:pams/views/clients/customerList.dart';
import 'package:pams/views/profile/profile.dart';
import 'package:pams/views/report/select_report_template_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var _clientViewModel = ref.watch(clientViewModel);
    _clientViewModel.getAllClients();
    //  values(context);
    super.didChangeDependencies();
  }

  GetStorage userdata = GetStorage();
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  bool check = false;
  @override
  Widget build(BuildContext context) {
    var _authViewModel = ref.watch(authViewModel);
    var _clientViewModel = ref.watch(clientViewModel);
    var _phoneMode = ref.watch(appMode.state);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _clientViewModel.clientData.data == null
            ? Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.0,
                    decoration: BoxDecoration(
                        color: CustomColors.mainDarkGreen,
                        image: DecorationImage(
                            fit: BoxFit.fill, image: AssetImage(homeViewIcon)),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                  onPressed: () {
                                    Get.to(() => ProfilePage());
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    size: 40,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Hello',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 20)),
                                    Text(userdata.read('name'),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17))
                                  ],
                                ),
                                SizedBox(width: 10.w),
                                Container(
                                  height: 80.w,
                                  width: 60.w,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(userAvatar)),
                                      border: Border.all(
                                        color: Colors.white,
                                        style: BorderStyle.solid,
                                        width: 4.0,
                                      ),
                                      shape: BoxShape.circle),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Tasks',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 0.3,
                                      offset: Offset(0.4, 0.6),
                                      blurRadius: 1,
                                      color: CustomColors.grey.withOpacity(0.5))
                                ],
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(7)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 0, bottom: 0),
                              child: Switch(
                                  activeColor: CustomColors.mainDarkGreen,
                                  value: _phoneMode.state,
                                  onChanged: (value) {
                                    final isObs = ref
                                        .watch(passwordObscureProvider.state);
                                    setState(() {
                                      _phoneMode.state = !_phoneMode.state;
                                    });
                                  }),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  myTaskWidget(
                    'Pending',
                    Icons.timelapse_outlined,
                    '3 tasks pending',
                    Colors.orange,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  myTaskWidget(
                    'Delivered',
                    Icons.done,
                    '9 tasks delivered',
                    Colors.green,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'What do you want to do today?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            //  _clientViewModel.getAllClients();
                            Get.to(() => CustomerList());
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: Offset(
                                        0, 0.5), // changes position of shadow
                                  ),
                                ],
                                color: CustomColors.Darkblue,
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/svgs/sampling.svg'),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Center(
                                      child: Text(
                                    'Sampling',
                                    style: TextStyle(
                                        color: CustomColors.background,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500),
                                  ))
                                ]),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _clientViewModel.getDPRResultActivityData();
                            _clientViewModel.getFMENVResultActivityData();
                            _clientViewModel.getNESREAResultActivityData();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ReportPage()));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: Offset(
                                        0, 0.5), // changes position of shadow
                                  ),
                                ],
                                color: CustomColors.mainDarkOrange,
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/svgs/report.svg'),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Center(
                                      child: Text('Report',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500)))
                                ]),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget myTaskWidget(
      String title, IconData icon, String subTitle, Color iconBGColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
              height: 20.w,
              width: 20.w,
              decoration:
                  BoxDecoration(color: iconBGColor, shape: BoxShape.circle),
              child: Icon(
                icon,
                color: Colors.white,
                size: 17,
              )),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
              Text(
                subTitle,
                style: TextStyle(fontSize: 12, color: Colors.black45),
              )
            ],
          )
        ],
      ),
    );
  }
}
