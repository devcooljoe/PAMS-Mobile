import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/providers/provider_services.dart';
import 'package:pams/styles/custom_colors.dart';
import 'package:pams/utils/db.dart';
import 'package:pams/views/clients/location/add_location.dart';
import 'package:pams/views/clients/location/edit_location.dart';
import 'package:pams/views/clients/location/offline/add_offline_location.dart';
import 'package:pams/views/field_sampling/result_template_screen.dart';
import 'package:pams/widgets/list_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientLocation extends ConsumerStatefulWidget {
  const ClientLocation({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientLocationState();
}

class _ClientLocationState extends ConsumerState<ClientLocation> {
  var db = PamsDatabase.init();
  @override
  Widget build(BuildContext context) {
    // var _authViewModel = ref.watch(authViewModel);
    // var _clientViewmodel = ref.watch(clientViewModel);
    var _phoneMode = ref.watch(appMode.state);
    var clientData = ModalRoute.of(context)?.settings.arguments as CustomerReturnObject;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddLocation(
                          clientID: clientData.id,
                        )));
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Sample Points", style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      backgroundColor: CustomColors.background,
      body: Stack(
        children: [
          SizedBox(
            height: 30,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                clientData.name!,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: DefaultTabController(
              initialIndex: _phoneMode.state == true ? 0 : 1,
              length: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TabBar(
                          unselectedLabelColor: Colors.grey,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: Colors.black,
                          indicator: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1, color: CustomColors.mainDarkGreen)),
                          ),
                          tabs: [
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Online Points"),
                              ),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Offline Points"),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBarView(children: [
                        //Online Tab
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: clientData.samplePointLocations!.isEmpty == true
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('No Locations yet'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            // _clientViewmodel.getClientLocation(
                                            //     clientId: clientData.id!);
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => AddLocation(
                                                      clientID: clientData.id,
                                                    )));
                                          },
                                          child: Text(
                                            'Create one',
                                            style: TextStyle(color: CustomColors.mainDarkGreen, fontWeight: FontWeight.bold, fontSize: 17.sp),
                                          ))
                                    ],
                                  ),
                                )
                              : ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 20, vertical: 10),
                                    //   child: TextFormField(
                                    //     inputFormatters: [
                                    //       FilteringTextInputFormatter.deny(
                                    //           RegExp('[ ]')),
                                    //     ],
                                    //     decoration: InputDecoration(
                                    //         hintText: 'Sample Points',
                                    //         prefixIcon: Icon(
                                    //           Icons.search,
                                    //           color: Colors.black,
                                    //         ),
                                    //         border: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(
                                    //                     10))),
                                    //   ),
                                    // ),
                                    ListView.builder(
                                        itemCount: clientData.samplePointLocations!.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          var data = clientData.samplePointLocations;

                                          return InkWell(
                                            onTap: () {
                                              Get.to(
                                                  () => ResultTemplatePage(
                                                        samplePointName: data![index].name,
                                                        samplePointIndex: index,
                                                        samplePointId: data[index].sampleLocationId,
                                                      ),
                                                  arguments: clientData);
                                            },
                                            child: ListWidget(
                                              title: data![index].name,
                                              subTitle: data[index].description,
                                              trailing: Padding(
                                                padding: const EdgeInsets.only(right: 10),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => EditLocationPage(
                                                                  clientID: clientData.id,
                                                                  name: data[index].name,
                                                                  description: data[index].description,
                                                                  locatoionId: data[index].sampleLocationId,
                                                                )));
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: CustomColors.mainDarkGreen,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                  ],
                                ),
                        ),

                        //Offline Tab
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: FutureBuilder(
                            future: PamsDatabase.fetch(db, null),
                            builder: ((context, snapshot) {
                              if (snapshot.data == null) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('No Locations yet'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            // _clientViewmodel.getClientLocation(
                                            //     clientId: clientData.id!);
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => AddOfflineLocationScreen(
                                                      clientID: clientData.id,
                                                    )));
                                          },
                                          child: Text(
                                            'Create one',
                                            style: TextStyle(color: CustomColors.mainDarkGreen, fontWeight: FontWeight.bold, fontSize: 17.sp),
                                          ))
                                    ],
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                List<dynamic> _data = json.decode(jsonEncode(snapshot.data));
                                return ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ListView.builder(
                                        itemCount: _data.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          // var data = clientData
                                          //     .samplePointLocations;
                                          String _body = _data[index]['body'];
                                          var data = _body.replaceAll(RegExp(r"\{|\}"), '').split(',');
                                          data.removeWhere((element) => element == '');
                                          return InkWell(
                                            onTap: () {
                                              // Get.to(
                                              //     () =>
                                              //         ResultTemplatePage(
                                              //           samplePointName:
                                              //               data![index]
                                              //                   .name,
                                              //           samplePointIndex:
                                              //               index,
                                              //           samplePointId: data[
                                              //                   index]
                                              //               .sampleLocationId,
                                              //         ),
                                              //     arguments: clientData);
                                            },
                                            child: ListWidget(
                                              title: data[1].split(':')[1],
                                              subTitle: data[2].split(':')[1],
                                              trailing: Padding(
                                                padding: const EdgeInsets.only(right: 10),
                                                child: InkWell(
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder:
                                                    //             (context) =>
                                                    //                 EditLocationPage(
                                                    //                   clientID:
                                                    //                       clientData.id,
                                                    //                   name:
                                                    //                       data[index].name,
                                                    //                   description:
                                                    //                       data[index].description,
                                                    //                   locatoionId:
                                                    //                       data[index].sampleLocationId,
                                                    //                 )));
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: CustomColors.mainDarkGreen,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                  ],
                                );
                              } else {
                                return Center(
                                    child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                ));
                              }
                            }),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool delete = false;

  // void deleteLocationDialog(int id) {
  //   showDialog(
  //     context: context,
  //     builder: (_) {
  //       return StatefulBuilder(builder: (context, setState) {
  //         return AlertDialog(
  //           content: Container(
  //             width: MediaQuery.of(context).size.width,
  //             height: 200.h,
  //             child: delete
  //                 ? Center(
  //                     child: SizedBox(
  //                       height: 20,
  //                       width: 20,
  //                       child: CircularProgressIndicator(
  //                         color: CustomColors.mainDarkGreen,
  //                       ),
  //                     ),
  //                   )
  //                 : Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text('Delete Location'),
  //                       SizedBox(
  //                         height: 20.h,
  //                       ),
  //                       Text(
  //                         'Sure you wanna delete this location?',
  //                       ),
  //                       SizedBox(
  //                         height: 20.h,
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                         children: [
  //                           TextButton(
  //                             onPressed: () => Navigator.pop(context),
  //                             child: Text('Cancel'),
  //                           ),
  //                           TextButton(
  //                             onPressed: () async {
  //                               setState(() {
  //                                 delete = true;
  //                               });
  //                               final result = await LocationImplementation()
  //                                   .deleteClientLocation(id)
  //                                   .catchError((onError) {
  //                                 setState(() {
  //                                   delete = false;
  //                                 });
  //                                 Constants().notify(
  //                                     'Oops...Something went wrong. Try again later');
  //                               });
  //                               if (result!['Status'] == true) {
  //                                 await getLocation();
  //                                 setState(() {
  //                                   delete = false;
  //                                 });
  //                                 Constants().notify(result['message']);
  //                                 Navigator.pop(context);
  //                               } else {
  //                                 setState(() {
  //                                   delete = false;
  //                                 });
  //                                 Constants().notify(result['Message']);
  //                               }
  //                             },
  //                             child: Text('Yes'),
  //                           ),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //           ),
  //         );
  //       });
  //     },
  //   );
  // }

}
