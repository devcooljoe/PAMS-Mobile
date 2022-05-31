import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/styles/custom_colors.dart';
import 'package:pams/widgets/list_widget.dart';

import 'add_customer.dart';
import 'location/client_location.dart';
import 'package:get/get.dart';

class CustomerList extends ConsumerStatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomerListState();
}

class _CustomerListState extends ConsumerState<CustomerList> {
  @override
  Widget build(BuildContext context) {
    var _clientViewModel = ref.watch(clientViewModel);
    // var client = _clientViewModel.clientData.data!.returnObject!;
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
        title: Text("Sample Site  List",
            style: TextStyle(color: Colors.black, fontSize: 20)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                _clientViewModel.getAllClients();
              },
              child: Icon(
                Icons.sync,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: _clientViewModel.clientData.loading
          ? Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]')),
                    ],
                    decoration: InputDecoration(
                        hintText: 'Sample sites',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                _clientViewModel.clientData.data!.returnObject!.isEmpty == true
                    ? Center(
                        child: Text('No Sample Site Yet'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _clientViewModel
                            .clientData.data!.returnObject!.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                            onTap: () {
                              // _clientViewModel.getClientLocation(
                              //     clientId: client[index].id!);
                              Get.to(() => ClientLocation(),
                                  arguments: _clientViewModel
                                      .clientData.data!.returnObject![index]);
                            },
                            child: ListWidget(
                              title: _clientViewModel
                                  .clientData.data!.returnObject![index].name,
                              subTitle: _clientViewModel
                                  .clientData.data!.returnObject![index].email,
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 17,
                              ),
                            ),
                          );
                        })
              ],
            ),
    );
  }
}