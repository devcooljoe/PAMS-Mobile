// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:pams/samples/data/microbial/data_models.dart';
// import 'package:pams/samples/data/microbial/database_helper.dart';
// import 'package:pams/samples/data/physioco/data_models.dart';
// import 'package:pams/samples/submit_result.dart';
// import 'package:pams/utils/custom_colors.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'data/physioco/database_helper.dart';

// class UpdateTest extends StatefulWidget {
//   final String? testName;
//   String? limt;
//   String? unit;
//   String? method;
//   String? uc;
//   String? result;
//   int? id;
//   final String? sampleName;
//   final String? test_Performed_And_Unit;

//   UpdateTest(
//       {Key? key,
//       this.testName,
//       this.limt,
//       this.unit,
//       this.method,
//       this.uc,
//       this.sampleName,
//       this.result,
//       this.id,
//       this.test_Performed_And_Unit})
//       : super(key: key);
//   @override
//   _UpdateTestState createState() => _UpdateTestState();
// }

// class _UpdateTestState extends State<UpdateTest> {
//   bool isLoading = false;
//   PickedFile? _imageFile;
//   final ImagePicker _picker = ImagePicker();
//   final _formKey = GlobalKey<FormState>();
//   bool autovalidate = false;

//   Future<bool> _onBackPressed() {
//     Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => SubmitResult()),
//         (route) => false);

//     return Future.delayed(Duration(seconds: 2));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: BackButton(
//           color: Colors.black,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(widget.sampleName!,
//             style: TextStyle(color: Colors.black, fontSize: 18)),
//       ),
//       backgroundColor: Colors.white,
//       body: Container(
//         margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
//         child: Form(
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           key: _formKey,
//           child: ListView(
//             children: [
//               widget.sampleName == 'physicoParameters'
//                   ? Text('Test Name & Unit')
//                   : Text('Test Name'),
//               SizedBox(
//                 height: 10,
//               ),
//               widget.sampleName == 'physicoParameters'
//                   ? TextFormField(
//                       readOnly: true,
//                       initialValue: widget.test_Performed_And_Unit,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(6))),
//                     )
//                   : TextFormField(
//                       readOnly: true,
//                       initialValue: widget.testName,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(6))),
//                     ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text('Test Result'),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 validator: (value) {
//                   if (value!.isEmpty == true) {
//                     return 'Field is required';
//                   }
//                 },
//                 initialValue: widget.result,
//                 onChanged: (value) {
//                   setState(() {
//                     widget.result = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                     hintText: widget.result,
//                     border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(6))),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               widget.sampleName == 'physicoParameters'
//                   ? TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty == true) {
//                           return 'Field is required';
//                         }
//                       },
//                       onChanged: (value) {
//                         setState(() {
//                           widget.uc = value;
//                         });
//                       },
//                       initialValue: widget.uc,
//                       decoration: InputDecoration(
//                           hintText: 'Test UC',
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(6))),
//                     )
//                   : TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty == true) {
//                           return 'Field is required';
//                         }
//                       },
//                       initialValue: widget.unit,
//                       onChanged: (value) {
//                         widget.unit = value;
//                       },
//                       decoration: InputDecoration(
//                           hintText: 'Test Unit',
//                           border: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(6))),
//                     ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextFormField(
//                 validator: (value) {
//                   if (value!.isEmpty == true) {
//                     return 'Field is required';
//                   }
//                 },
//                 initialValue: widget.limt,
//                 onChanged: (value) {
//                   setState(() {
//                     widget.limt = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                     hintText: 'Test Limit',
//                     border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(6))),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextFormField(
//                 validator: (value) {
//                   if (value!.isEmpty == true) {
//                     return 'Field is required';
//                   }
//                 },
//                 initialValue: widget.method,
//                 onChanged: (value) {
//                   setState(() {
//                     widget.method = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                     hintText: 'Test Method',
//                     border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(6))),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         elevation: 0,
//         color: CustomColors.background,
//         child: InkWell(
//           onTap: () {
//             widget.sampleName == 'physicoParameters'
//                 ? _validatePhysioCo()
//                 : _validateMicroInputs();
//           },
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             height: 50,
//             decoration: BoxDecoration(
//               color: CustomColors.mainDarkGreen,
//               borderRadius: BorderRadius.circular(5),
//             ),
//             child: Center(
//               child: isLoading
//                   ? SizedBox(
//                       height: 20,
//                       width: 20,
//                       child: CircularProgressIndicator(
//                         color: Colors.white,
//                       ),
//                     )
//                   : Text('Update',
//                       style: TextStyle(color: Colors.white, fontSize: 18)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   //check for microbia
//   _validateMicroInputs() async {
//     setState(() {
//       isLoading = true;
//     });
//     var form = _formKey.currentState;
//     if (!form!.validate()) {
//       setState(() {
//         autovalidate = true;
//         isLoading = false;
//       });
//     } else {
//       form.save();
//       var data = await DataBaseHelper.instance
//           .updateItem(MicroBial(
//               id: widget.id,
//               name: widget.testName,
//               result: widget.result,
//               unit: widget.unit,
//               testlimit: widget.limt,
//               method: widget.method))
//           .then((value) {
//         Fluttertoast.showToast(
//             msg: "Test Updated successfuly",
//             toastLength: Toast.LENGTH_LONG,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.black,
//             textColor: Colors.white,
//             fontSize: 16.0);
//         setState(() {
//           isLoading = false;
//         });
//         Navigator.pop(context);
//       });
//       print(data);
//     }
//   }

//   //check for physioCo
//   _validatePhysioCo() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isLoading = true;
//     });
//     var form = _formKey.currentState;
//     if (!form!.validate()) {
//       setState(() {
//         autovalidate = true;
//         isLoading = false;
//       });
//     } else {
//       form.save();
//        var data = await PhysicoDataBaseHelper.instance
//           .updateItem(PhysiCo(
//               id: widget.id,
//               name: widget.test_Performed_And_Unit,
//               result: widget.result,
//               uc: widget.uc,
//               testlimit: widget.limt,
//               method: widget.method))
//           .then((value) {
//         Fluttertoast.showToast(
//             msg: "Test Updated successfuly",
//             toastLength: Toast.LENGTH_LONG,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.black,
//             textColor: Colors.white,
//             fontSize: 16.0);
//         setState(() {
//           isLoading = false;
//         });
//         Navigator.pop(context);
//       });
//       print(data);
//     }
//   }
// }
