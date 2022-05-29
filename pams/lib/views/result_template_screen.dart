import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/providers/category_provider.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/styles/custom_colors.dart';
import 'package:pams/utils/strings.dart';
import 'package:pams/views/clients/location/add_location.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultTemplatePage extends ConsumerStatefulWidget {
  String? samplePointName;
  int? samplePointId;
  int? samplePointIndex;
  ResultTemplatePage({
    Key? key,
    required this.samplePointName,
    required this.samplePointIndex,
    required this.samplePointId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResultTemplatePageState();
}

class _ResultTemplatePageState extends ConsumerState<ResultTemplatePage> {
  bool selectedSa = false;
  bool unSelectedSa = true;
  int selected = -0;
  int selectedTemplate = 0;
  String selectedTemplateName = 'DPR';
  bool saveBtn = false;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  takePhoto(ImageSource source, cxt) async {
    final pickedFile = await _picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
    setState(() {
      _image = pickedFile;
    });

    // Navigator.pop(cxt);
  }

  List<TextEditingController> _textResultControllers = [];
  List<TextEditingController> _textLimitControllers = [];

  values(BuildContext context) {
    _textResultControllers.add(TextEditingController());
    _textLimitControllers.add(TextEditingController());
    var clientData =
        ModalRoute.of(context)?.settings.arguments as CustomerReturnObject;
    var mydata = clientData.samplePointLocations!;
    var mylocations = mydata[0].dprSamples!.dprSamples!;
    for (var i = 0; i < mylocations.length; i++) {
      _textResultControllers.add(TextEditingController());
      _textLimitControllers.add(TextEditingController());
      _textLimitControllers[i].text = mylocations[i].testLimit!;
      _textResultControllers[i].text = mylocations[i].testResult!;
    }
    // for (var element in mylocations) {

    // }
  }

  @override
  void didChangeDependencies() {
    values(context);
    //print('hey lenght ${widget.templateIndex}');
    super.didChangeDependencies();
  }

  int update = -1;
  @override
  Widget build(BuildContext context) {
    var clientData =
        ModalRoute.of(context)?.settings.arguments as CustomerReturnObject;
    var _sampleProvider = ref.watch(categoryViewModel);
    var _clientProvider = ref.watch(clientViewModel);
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
        title: Text("Result Templates",
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      backgroundColor: CustomColors.background,
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: InkWell(
              onTap: () {
                _selectSamplePoint();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(widget.samplePointName!),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
            trailing: SizedBox(
              width: 120,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.withOpacity(0.4)),
                  child: InkWell(
                    onTap: () {
                      _selectTemplateType();
                      //  _selectSamplePoint();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_sampleProvider.categoryCode),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //list of sample tests
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: clientData
                  .samplePointLocations![widget.samplePointIndex!]
                  .dprSamples!
                  .dprSamples!
                  .length,
              itemBuilder: ((context, index) {
                var data = clientData
                    .samplePointLocations![widget.samplePointIndex!]
                    .dprSamples!
                    .dprSamples![index];
                // _textResultControllers.add(TextEditingController());
                // _textLimitControllers.add(TextEditingController());
                // _textLimitControllers[index].text = data.testLimit!;
                // _textResultControllers[index].text = data.testResult!;

                return Padding(
                  padding:
                      const EdgeInsets.only(right: 10, left: 10, bottom: 15),
                  child: Card(
                    elevation: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 300,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.testName!),
                                    Text('Test Limit'),
                                    Text('Test Result'),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.testUnit!),
                                    SizedBox(
                                      width: 230,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: TextFormField(
                                              onChanged: (value) {},
                                              controller:
                                                  _textLimitControllers[index],
                                              decoration: InputDecoration(
                                                  hintText: data.testLimit,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 13,
                                                          horizontal: 5),
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide())),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: TextFormField(
                                              controller:
                                                  _textResultControllers[index],
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 13,
                                                          horizontal: 5),
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide())),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                update = index;
                              });
                              _clientProvider.runEachDPRTest(
                                  Id: data.id!,
                                  DPRFieldId: data.dprFieldId!,
                                  TestLimit: _textLimitControllers[index].text,
                                  TestResult:
                                      _textResultControllers[index].text);

                              await Future.delayed(const Duration(seconds: 5),
                                  () async {
                                _clientProvider.getAllClients();
                                if (_clientProvider.runEachDPRData.data !=
                                    null) {
                                  _clientProvider.getAllClients();
                                  setState(() {
                                    update = -1;
                                  });
                                } else {
                                  setState(() {
                                    update = -1;
                                  });
                                }
                              });

                              // print(_textResultControllers[index].text);
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: CustomColors.mainDarkGreen,
                              child: Center(
                                  child: update == index
                                      ? SizedBox(
                                          height: 10,
                                          width: 10,
                                          child: CircularProgressIndicator(
                                            color: CustomColors.background,
                                          ),
                                        )
                                      : Icon(
                                          Icons.check,
                                          color: CustomColors.background,
                                          size: 13,
                                        )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              await takePhoto(ImageSource.camera, context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 130,
                width: 300,
                decoration: BoxDecoration(
                  image: _image == null
                      ? DecorationImage(
                          image: AssetImage('assets/images/field.jpg'),
                          fit: BoxFit.fitWidth)
                      : DecorationImage(
                          image: FileImage(
                            File(_image!.path.toString()),
                          ),
                          fit: BoxFit.fitWidth),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              // await updateLocation();
              // _clientViewmodel.getAllClients();
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                  color: CustomColors.mainDarkGreen,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: saveBtn
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: CustomColors.background,
                        ),
                      )
                    : Text(
                        'Save',
                        style: TextStyle(
                            color: CustomColors.background, fontSize: 18),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectSamplePoint() {
    var clientData =
        ModalRoute.of(context)?.settings.arguments as CustomerReturnObject;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.r),
          ),
        ),
        builder: (builder) {
          return SizedBox(
            height: 500.0,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'DPR Sample Points',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: clientData.samplePointLocations!.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            child: ListTile(
                                onTap: (() {
                                  setState(() {
                                    selectedSa = true;
                                    selected = index;
                                    unSelectedSa = false;
                                  });
                                  setState(() {
                                    widget.samplePointName = clientData
                                        .samplePointLocations![index].name!;
                                    widget.samplePointId = clientData
                                        .samplePointLocations![index]
                                        .sampleLocationId!;
                                  });
                                  Navigator.pop(context);
                                }),
                                title: Text(
                                  clientData.samplePointLocations![index].name!,
                                  style: TextStyle(fontSize: 15),
                                ),
                                subtitle: Text(
                                  clientData.samplePointLocations![index]
                                      .description!,
                                  style: TextStyle(fontSize: 13),
                                ),
                                trailing: Stack(
                                  children: [
                                    Visibility(
                                      visible: unSelectedSa,
                                      child: widget.samplePointId ==
                                              clientData
                                                  .samplePointLocations![index]
                                                  .sampleLocationId!
                                          ? CircleAvatar(
                                              radius: 12,
                                              child: Icon(
                                                Icons.check,
                                                color: CustomColors.background,
                                                size: 13,
                                              ),
                                              backgroundColor:
                                                  CustomColors.mainDarkGreen)
                                          : SizedBox(
                                              height: 1,
                                              width: 1,
                                            ),
                                    ),
                                    Visibility(
                                      visible: selectedSa,
                                      child: selected == index
                                          ? CircleAvatar(
                                              radius: 12,
                                              child: Icon(
                                                Icons.check,
                                                color: CustomColors.background,
                                                size: 13,
                                              ),
                                              backgroundColor:
                                                  CustomColors.mainDarkGreen)
                                          : SizedBox(
                                              height: 1,
                                              width: 1,
                                            ),
                                    )
                                  ],
                                )),
                          );
                        }))
                  ],
                )),
          );
        });
  }

  void _selectTemplateType() {
    var clientData =
        ModalRoute.of(context)?.settings.arguments as CustomerReturnObject;
    var _sampleProvider = ref.watch(categoryViewModel);
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.r),
          ),
        ),
        builder: (builder) {
          return SizedBox(
            height: 500.0,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Sample Templates',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: sampleTemplates.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            child: ListTile(
                              onTap: (() {
                                setState(() {
                                  _sampleProvider.categoryCode =
                                      sampleTemplates[index];
                                  selectedTemplate = index;
                                });
                                Navigator.pop(context);
                              }),
                              title: Text(
                                sampleTemplates[index],
                                style: TextStyle(fontSize: 15),
                              ),
                              subtitle: Text(
                                templateSamples[index],
                                style: TextStyle(fontSize: 13),
                              ),
                              trailing: selectedTemplate == index
                                  ? CircleAvatar(
                                      radius: 12,
                                      child: Icon(
                                        Icons.check,
                                        color: CustomColors.background,
                                        size: 13,
                                      ),
                                      backgroundColor:
                                          CustomColors.mainDarkGreen)
                                  : SizedBox(
                                      height: 1,
                                      width: 1,
                                    ),
                            ),
                          );
                        }))
                  ],
                )),
          );
        });
  }
}
