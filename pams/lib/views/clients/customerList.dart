import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/providers/category_provider.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/widgets/list_widget.dart';

import 'location/client_location.dart';
import 'package:get/get.dart';

class CustomerList extends ConsumerWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var _clientViewModel = ref.watch(clientViewModel);
    var _sampleProvider = ref.watch(categoryViewModel);
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
        title: Text("Sample Site  List", style: TextStyle(color: Colors.black, fontSize: 20)),
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
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 20,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   child: CustomTextField(),
                // ),
                _clientViewModel.clientData.data!.returnObject!.isEmpty == true
                    ? Center(
                        child: Text('No Sample Site Yet'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _clientViewModel.clientData.data!.returnObject!.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                            onTap: () {
                              // _clientViewModel.getClientLocation(
                              //     clientId: client[index].id!);
                              _sampleProvider.clientIndex = index;
                              Get.to(() => ClientLocation(), arguments: _clientViewModel.clientData.data!.returnObject![index]);
                            },
                            child: ListWidget(
                              title: _clientViewModel.clientData.data!.returnObject![index].name,
                              subTitle: _clientViewModel.clientData.data!.returnObject![index].email,
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
