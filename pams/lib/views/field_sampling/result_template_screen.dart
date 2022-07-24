import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/providers/category_provider.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/styles/custom_colors.dart';
import 'package:pams/utils/controller.dart';
import 'package:pams/utils/notify_user.dart';
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
  ConsumerState<ConsumerStatefulWidget> createState() => _ResultTemplatePageState();
}

class _ResultTemplatePageState extends ConsumerState<ResultTemplatePage> {
  var _controller = Get.put(PamsStateController());
  bool selectedSa = false;
  bool unSelectedSa = true;
  int selected = -0;
  String selectedTemplateName = 'DPR';
  bool saveBtn = false;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  takePhoto(ImageSource source, cxt) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
    setState(() {
      _image = pickedFile;
      // print(_image!.path);
    });

    // Navigator.pop(cxt);
  }

  List<TextEditingController> textResultControllers = [];
  List<TextEditingController> textLimitControllers = [];

  // values(BuildContext context) {
  //   var _sampleProvider = ref.watch(categoryViewModel);
  //   textResultControllers.add(TextEditingController());
  //   textLimitControllers.add(TextEditingController());
  //   var clientData =
  //       ModalRoute.of(context)?.settings.arguments as CustomerReturnObject;
  //   var mydata = clientData.samplePointLocations!;
  //   var mylocations = _sampleProvider.templateIndex == 0
  //       ? mydata[_sampleProvider.templateIndex].dprSamples!.dprSamples!
  //       : _sampleProvider.templateIndex == 1
  //           ? mydata[_sampleProvider.templateIndex].fmenvSamples!.fmenvSamples!
  //           : mydata[_sampleProvider.templateIndex]
  //               .nesreaSamples!
  //               .nesreaSamples!;
  //   for (var i = 0; i < mylocations.length; i++) {
  //     textResultControllers.add(TextEditingController());
  //     textLimitControllers.add(TextEditingController());
  //     textLimitControllers[i].text = mylocations[i].testLimit!;
  //     textResultControllers[i].text = mylocations[i].testResult!;
  //   }
  // }

  @override
  void didChangeDependencies() {
    //  values(context);
    super.didChangeDependencies();
  }

  int update = -1;
  bool changeTemplate = false;
  @override
  Widget build(BuildContext context) {
    var clientData = ModalRoute.of(context)?.settings.arguments as CustomerReturnObject;
    var _sampleProvider = ref.watch(categoryViewModel);

    var length = _sampleProvider.templateIndex == 0
        ? clientData.samplePointLocations![widget.samplePointIndex!].dprSamples!.dprSamples!.length
        : _sampleProvider.templateIndex == 1
            ? clientData.samplePointLocations![widget.samplePointIndex!].fmenvSamples!.fmenvSamples!.length
            : clientData.samplePointLocations![widget.samplePointIndex!].nesreaSamples!.nesreaSamples!.length;

    List<String> textResultValues = List.generate(length, (index) => '');
    List<String> textLimitValues = List.generate(length, (index) => '');

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
        title: _controller.offlinePoint.value
            ? Flex(
                direction: Axis.horizontal,
                children: [
                  Text(
                    "Result Templates",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Colors.black,
                    ),
                    child: Text(
                      'OFFLINE POINT',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ],
              )
            : Text(
                "Result Templates",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
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
                  children: [Text(widget.samplePointName!), Icon(Icons.arrow_drop_down)],
                ),
              ),
            ),
            trailing: SizedBox(
              width: 120,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey.withOpacity(0.4)),
                  child: InkWell(
                    onTap: () {
                      _selectTemplateType();
                      //  _selectSamplePoint();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(_sampleProvider.categoryCode), Icon(Icons.arrow_drop_down)],
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
              itemCount: _sampleProvider.templateIndex == 0
                  ? clientData.samplePointLocations![widget.samplePointIndex!].dprSamples!.dprSamples!.length
                  : _sampleProvider.templateIndex == 1
                      ? clientData.samplePointLocations![widget.samplePointIndex!].fmenvSamples!.fmenvSamples!.length
                      : clientData.samplePointLocations![widget.samplePointIndex!].nesreaSamples!.nesreaSamples!.length,
              itemBuilder: ((context, index) {
                textResultControllers.add(TextEditingController());
                textLimitControllers.add(TextEditingController());
                var data = _sampleProvider.templateIndex == 0
                    ? clientData.samplePointLocations![widget.samplePointIndex!].dprSamples!.dprSamples![index]
                    : _sampleProvider.templateIndex == 1
                        ? clientData.samplePointLocations![widget.samplePointIndex!].fmenvSamples!.fmenvSamples![index]
                        : clientData.samplePointLocations![widget.samplePointIndex!].nesreaSamples!.nesreaSamples![index];

                textLimitControllers[index].text = data.testLimit!;
                textResultControllers[index].text = data.testResult!;

                return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
                  child: Card(
                    elevation: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 300,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.testUnit!),
                                    SizedBox(
                                      width: 230,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: TextField(
                                              onChanged: (value) {
                                                textLimitValues[index] = value;
                                              },
                                              // controller: textLimitControllers[index],
                                              decoration: InputDecoration(hintText: data.testLimit, contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 5), border: OutlineInputBorder(borderSide: BorderSide())),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: TextField(
                                              onChanged: (value) {
                                                textResultValues[index] = value;
                                              },
                                              // controller: textResultControllers[index],
                                              decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 5), border: OutlineInputBorder(borderSide: BorderSide())),
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
                          StatefulBuilder(builder: ((context, setState) {
                            return InkWell(
                              onTap: () async {
                                _sampleProvider.templateIndex == 0
                                    ? runDPRSingles(index: index, Id: data.id!, DPRFieldId: data.dprFieldId!)
                                    : _sampleProvider.templateIndex == 1
                                        ? runFMENVSingles(index: index, Id: data.id!, FMEnvFieldId: data.fmenvFieldId!)
                                        : runNESREASingles(index: index, Id: data.id!, NesreaFieldId: data.nesreaFieldId!);

                                // setState(
                                //   () {
                                //     update = index;
                                //   },
                                // );
                                // int i = index;
                                // print('object');
                                // _clientProvider.runEachDPRTest(
                                //     Id: data.id!,
                                //     DPRFieldId: data.dprFieldId!,
                                //     TestLimit: textLimitControllers[i].text,
                                //     TestResult: textResultControllers[i].text);
                                // setState(
                                //   () {
                                //     update = -1;
                                //   },
                                // );
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
                            );
                          }))
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
                      ? DecorationImage(image: AssetImage('assets/images/field.jpg'), fit: BoxFit.fitWidth)
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
              if (_image != null) {
                _sampleProvider.templateIndex == 0
                    ? subMiteForDPRTemplate()
                    : _sampleProvider.templateIndex == 1
                        ? subMiteForFMENVTemplate()
                        : subMiteForNESREATemplate();
              } else {
                NotifyUser.showAlert('Add picture to proceed');
              }
              // await updateLocation();
              // _clientViewmodel.getAllClients();
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              height: 60,
              width: 300,
              decoration: BoxDecoration(color: CustomColors.mainDarkGreen, borderRadius: BorderRadius.circular(10)),
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
                        style: TextStyle(color: CustomColors.background, fontSize: 18),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectSamplePoint() {
    var clientData = ModalRoute.of(context)?.settings.arguments as CustomerReturnObject;
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
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
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
                      style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
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
                                    widget.samplePointName = clientData.samplePointLocations![index].name!;
                                    widget.samplePointId = clientData.samplePointLocations![index].sampleLocationId!;
                                  });
                                  Navigator.pop(context);
                                }),
                                title: Text(
                                  clientData.samplePointLocations![index].name!,
                                  style: TextStyle(fontSize: 15),
                                ),
                                subtitle: Text(
                                  clientData.samplePointLocations![index].description!,
                                  style: TextStyle(fontSize: 13),
                                ),
                                trailing: Stack(
                                  children: [
                                    Visibility(
                                      visible: unSelectedSa,
                                      child: widget.samplePointId == clientData.samplePointLocations![index].sampleLocationId!
                                          ? CircleAvatar(
                                              radius: 12,
                                              child: Icon(
                                                Icons.check,
                                                color: CustomColors.background,
                                                size: 13,
                                              ),
                                              backgroundColor: CustomColors.mainDarkGreen)
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
                                              backgroundColor: CustomColors.mainDarkGreen)
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
    var clientData = ModalRoute.of(context)?.settings.arguments as CustomerReturnObject;
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
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
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
                      style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
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
                              onTap: (() async {
                                setState(() {
                                  _sampleProvider.categoryCode = sampleTemplates[index];

                                  _sampleProvider.templateIndex = index;
                                });

                                Navigator.of(context).pop();
                              }),
                              title: Text(
                                sampleTemplates[index],
                                style: TextStyle(fontSize: 15),
                              ),
                              subtitle: Text(
                                templateSamples[index],
                                style: TextStyle(fontSize: 13),
                              ),
                              trailing: _sampleProvider.templateIndex == index
                                  ? CircleAvatar(
                                      radius: 12,
                                      child: Icon(
                                        Icons.check,
                                        color: CustomColors.background,
                                        size: 13,
                                      ),
                                      backgroundColor: CustomColors.mainDarkGreen)
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

  //run for dpr
  runDPRSingles({
    required int index,
    required int Id,
    required int DPRFieldId,
  }) async {
    var _clientProvider = ref.watch(clientViewModel);
    setState(() {
      update = index;
    });
    _clientProvider.runEachDPRTest(Id: Id, DPRFieldId: DPRFieldId, TestLimit: textLimitControllers[index], TestResult: textResultControllers[index]);
    await Future.delayed(const Duration(seconds: 5), () async {
      _clientProvider.getAllClients();
      if (_clientProvider.runEachDPRData.data != null) {
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
  }

  //submit for dpr template
  subMiteForDPRTemplate() async {
    setState(() {
      saveBtn = true;
    });
    var _sampleProvider = ref.watch(categoryViewModel);
    var _clientProvider = ref.watch(clientViewModel);
    var data = _clientProvider.clientData.data!.returnObject![_sampleProvider.clientIndex!].samplePointLocations![widget.samplePointIndex!].dprSamples!;

    _clientProvider.submitDPRTemplate(
      samplePtId: data.samplePointLocationId!,
      DPRFieldId: data.id!,
      Latitude: 233,
      Longitude: 332,
      DPRTemplates: data.dprSamples,
      Picture: _image!.path,
    );

    await Future.delayed(const Duration(seconds: 5), () async {
      _clientProvider.getAllClients();
      if (_clientProvider.submitDPRTemplateData.data != null) {
        _clientProvider.getAllClients();
        setState(() {
          saveBtn = false;
        });
      } else {
        setState(() {
          saveBtn = false;
        });
      }
    });
  }

  //run for fmenv
  runFMENVSingles({
    required int index,
    required int Id,
    required int FMEnvFieldId,
  }) async {
    var _clientProvider = ref.watch(clientViewModel);
    setState(() {
      update = index;
    });
    _clientProvider.runEachFMENVTest(Id: Id, FMEnvFieldId: FMEnvFieldId, TestLimit: textLimitControllers[index].text, TestResult: textResultControllers[index].text);

    await Future.delayed(const Duration(seconds: 5), () async {
      _clientProvider.getAllClients();
      if (_clientProvider.runEachFMENVData.data != null) {
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
  }

  //submit for fmenv template
  subMiteForFMENVTemplate() async {
    setState(() {
      saveBtn = true;
    });
    var _sampleProvider = ref.watch(categoryViewModel);
    var _clientProvider = ref.watch(clientViewModel);
    var data = _clientProvider.clientData.data!.returnObject![_sampleProvider.clientIndex!].samplePointLocations![widget.samplePointIndex!].fmenvSamples!;

    _clientProvider.submitFmenvTemplate(
      samplePtId: data.samplePointLocationId!,
      FMEnvFieldId: data.id!,
      Latitude: 233,
      Longitude: 332,
      FMENVTemplates: data.fmenvSamples,
      Picture: _image!.path,
    );

    await Future.delayed(const Duration(seconds: 5), () async {
      _clientProvider.getAllClients();
      if (_clientProvider.submitFMENVTemplateData.data != null) {
        _clientProvider.getAllClients();
        setState(() {
          saveBtn = false;
        });
      } else {
        setState(() {
          saveBtn = false;
        });
      }
    });
  }

  //run for nesrea
  runNESREASingles({
    required int index,
    required int Id,
    required int NesreaFieldId,
  }) async {
    var _clientProvider = ref.watch(clientViewModel);
    setState(() {
      update = index;
    });
    _clientProvider.runEachNESREATest(Id: Id, NesreaFieldId: NesreaFieldId, TestLimit: textLimitControllers[index].text, TestResult: textResultControllers[index].text);

    await Future.delayed(const Duration(seconds: 5), () async {
      _clientProvider.getAllClients();
      if (_clientProvider.runEachNESREAData.data != null) {
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
  }

  //submit for nesrea template
  subMiteForNESREATemplate() async {
    setState(() {
      saveBtn = true;
    });
    var _sampleProvider = ref.watch(categoryViewModel);
    var _clientProvider = ref.watch(clientViewModel);
    var data = _clientProvider.clientData.data!.returnObject![_sampleProvider.clientIndex!].samplePointLocations![widget.samplePointIndex!].nesreaSamples!;

    _clientProvider.submitNesreaTemplate(
      samplePtId: data.samplePointLocationId!,
      NesreaFieldId: data.id!,
      Latitude: 233,
      Longitude: 332,
      NesreaTemplates: data.nesreaSamples,
      Picture: _image!.path,
    );

    await Future.delayed(const Duration(seconds: 5), () async {
      _clientProvider.getAllClients();
      if (_clientProvider.submitNESREATemplateData.data != null) {
        _clientProvider.getAllClients();
        setState(() {
          saveBtn = false;
        });
      } else {
        setState(() {
          saveBtn = false;
        });
      }
    });
  }
}
