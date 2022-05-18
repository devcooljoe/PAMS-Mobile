import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/providers/auth_provider.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/utils/constants.dart';
import 'package:pams/styles/custom_colors.dart';
import 'package:pams/views/clients/location/add_location.dart';
import 'package:pams/views/clients/location/edit_location.dart';
import 'package:pams/views/clients/select_sample_type.dart';
import 'package:pams/widgets/list_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientLocation extends ConsumerStatefulWidget {
  const ClientLocation({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientLocationState();
}

class _ClientLocationState extends ConsumerState<ClientLocation> {
  @override
  Widget build(BuildContext context) {
    var _authViewModel = ref.watch(authViewModel);
    var _clientViewmodel = ref.watch(clientViewModel);
    var clientData =
        ModalRoute.of(context)?.settings.arguments as CustomerDataList;
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
        title: Text("Sample Points",
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      backgroundColor: CustomColors.background,
      body: _clientViewmodel.clientLocation.data == null
          ? Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    color: CustomColors.mainDarkGreen),
              ),
            )
          : _clientViewmodel.clientLocation.data!.returnObject!.isEmpty == true
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
                            style: TextStyle(
                                color: CustomColors.mainDarkGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp),
                          ))
                    ],
                  ),
                )
              : ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 20, vertical: 10),
                    //   child: TextFormField(
                    //     inputFormatters: [
                    //       FilteringTextInputFormatter.deny(RegExp('[ ]')),
                    //     ],
                    //     decoration: InputDecoration(
                    //         hintText: 'Search Locations',
                    //         prefixIcon: Icon(
                    //           Icons.search,
                    //           color: Colors.black,
                    //         ),
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10))),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    ListView.builder(
                        itemCount: _clientViewmodel
                            .clientLocation.data!.returnObject!.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data = _clientViewmodel.clientLocation.data;
                          return InkWell(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => SelectSampleType(
                              //           locationId: myLocations!
                              //               .returnObject![index]
                              //               .sampleLocationId!,
                              //           clientId: widget.clientId,
                              //           clientName: widget.clientName,
                              //         )));
                            },
                            child: ListWidget(
                              title: data!.returnObject![index].name,
                              subTitle: data.returnObject![index].description,
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () async {
                                    var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditLocation(
                                                  clientID: '',
                                                  name: data
                                                      .returnObject![index]
                                                      .name,
                                                  description: data
                                                      .returnObject![index]
                                                      .description,
                                                  locatoionId: data
                                                      .returnObject![index]
                                                      .sampleLocationId,
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
