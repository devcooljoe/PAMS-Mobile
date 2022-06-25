import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/models/add_location_request_model.dart';
import 'package:pams/models/offline_location_model.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/utils/constants.dart';
import 'package:pams/styles/custom_colors.dart';
import 'package:pams/utils/notify_user.dart';
import 'package:pams/views/clients/location/offline/add_location_database_helper.dart';

class AddOfflineLocationScreen extends ConsumerStatefulWidget {
  final String? clientID;

  const AddOfflineLocationScreen({Key? key, this.clientID}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddOfflineLocationScreenState();
}

class _AddOfflineLocationScreenState
    extends ConsumerState<AddOfflineLocationScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _clientViewmodel = ref.watch(clientViewModel);
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Add Offline Sample Point",
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: name,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: description,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: InkWell(
          onTap: () async {
            addOfflineLocation();
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: CustomColors.mainDarkGreen,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: update
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: CustomColors.background,
                      ),
                    )
                  : Text(
                      'Add Sample Point',
                      style: TextStyle(
                          color: CustomColors.background, fontSize: 18),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  bool update = false;

  Future addOfflineLocationScreen() async {
    var _clientViewmodel = ref.watch(clientViewModel);
    setState(() {
      update = true;
    });

    final form = _formKey.currentState;
    if (!form!.validate()) {
      setState(() {
        update = false;
      });
    } else {
      form.save();
      AddLocationRequestModel model = AddLocationRequestModel(
        clientId: widget.clientID,
        name: name.text,
        description: description.text,
      );
      _clientViewmodel.addClientLocation(model: model);
      await Future.delayed(const Duration(seconds: 3), () async {
        if (_clientViewmodel.addclientLocation.data != null) {
          setState(() {
            update = false;
          });
          _clientViewmodel.getAllClients();
        } else {
          setState(() {
            update = false;
          });
        }
      });
    }
  }

  Future addOfflineLocation() async {
    setState(() {
      update = true;
    });

    final form = _formKey.currentState;
    if (!form!.validate()) {
      setState(() {
        update = false;
      });
    } else {
      form.save();
      AddOfflineLocation model = AddOfflineLocation(
        clientId: widget.clientID,
        name: name.text,
        description: description.text,
      );

       await LocationDataBaseHelper.instance.add(model).then((value) {
        setState(() {
          update = false;
        });
        NotifyUser.showAlert('Test created successfuly');
        // Navigator.pop(context);
      });
    }
  }
}
