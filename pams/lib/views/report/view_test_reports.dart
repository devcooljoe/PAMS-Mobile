import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pams/providers/category_provider.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/providers/provider_services.dart';
import 'package:pams/styles/custom_colors.dart';
import 'package:pams/utils/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pams/views/report/report_test_details.dart';
import 'package:pams/widgets/custom_drop_down.dart';
import 'package:get/get.dart';

class ReportPage extends ConsumerStatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReportPageState();
}

class _ReportPageState extends ConsumerState<ReportPage> {
  @override
  Widget build(BuildContext context) {
    var _sampleProvider = ref.watch(categoryViewModel);
    var _phoneMode = ref.watch(appMode.state);
    var _clientViewModel = ref.watch(clientViewModel);
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
        title: Text("Result Activities", style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      backgroundColor: CustomColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          children: [
            SizedBox(
              width: 160,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 20, left: 20),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey.withOpacity(0.4)),
                  child: InkWell(
                    onTap: () {
                      _selectTemplateType();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(_sampleProvider.categoryCode), Icon(Icons.arrow_drop_down)],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
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
                                  child: Text("Online Results"),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Offline Results"),
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
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                _clientViewModel.dprResultActivityData.data == null || _clientViewModel.fmenvResultActivityData.data == null || _clientViewModel.nesreaResultActivityData.data == null
                                    ? Center(
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: _sampleProvider.templateIndex == 0
                                            ? _clientViewModel.dprResultActivityData.data!.returnObject!.length
                                            : _sampleProvider.templateIndex == 1
                                                ? _clientViewModel.fmenvResultActivityData.data!.returnObject!.length
                                                : _clientViewModel.nesreaResultActivityData.data!.returnObject!.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          var dprdata = _clientViewModel.dprResultActivityData.data!.returnObject!;
                                          var fmenvdata = _clientViewModel.fmenvResultActivityData.data!.returnObject!;
                                          var nesreadata = _clientViewModel.nesreaResultActivityData.data!.returnObject!;
                                          return dprdata.isEmpty == true || fmenvdata.isEmpty == true || nesreadata.isEmpty == true
                                              ? Center(
                                                  child: Text('No result yet'),
                                                )
                                              : Padding(
                                                  padding: const EdgeInsets.only(top: 20),
                                                  child: CustomDropDown(
                                                      downloadFile: () {},
                                                      title: Row(
                                                        children: [
                                                          Text(
                                                            _sampleProvider.templateIndex == 0
                                                                ? dprdata[index].clientName!
                                                                : _sampleProvider.templateIndex == 1
                                                                    ? fmenvdata[index].clientName!
                                                                    : nesreadata[index].clientName!,
                                                            style: TextStyle(fontWeight: FontWeight.bold, color: CustomColors.mainblueColor.withOpacity(0.8)),
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                            _sampleProvider.templateIndex == 0
                                                                ? dprdata[index].samplePointName!
                                                                : _sampleProvider.templateIndex == 1
                                                                    ? fmenvdata[index].samplePointName!
                                                                    : nesreadata[index].samplePointName!,
                                                          ),
                                                        ],
                                                      ),
                                                      body: Column(
                                                        children: List.generate(
                                                            _sampleProvider.templateIndex == 0
                                                                ? _clientViewModel.dprResultActivityData.data!.returnObject![index].dprSamples!.length
                                                                : _sampleProvider.templateIndex == 1
                                                                    ? _clientViewModel.fmenvResultActivityData.data!.returnObject![index].fmenvSamples!.length
                                                                    : _clientViewModel.nesreaResultActivityData.data!.returnObject![index].nesreaSamples!.length, (myindex) {
                                                          return Column(
                                                            children: [
                                                              ListTile(
                                                                onTap: () {
                                                                  Get.to(() => ViewSubmittedDPRtest(
                                                                      name: _sampleProvider.templateIndex == 0
                                                                          ? dprdata[index].dprSamples![myindex].testName!.toString()
                                                                          : _sampleProvider.templateIndex == 1
                                                                              ? fmenvdata[index].fmenvSamples![myindex].testName!.toString()
                                                                              : nesreadata[index].nesreaSamples![myindex].testName!.toString(),
                                                                      unit: _sampleProvider.templateIndex == 0
                                                                          ? dprdata[index].dprSamples![myindex].testUnit!.toString()
                                                                          : _sampleProvider.templateIndex == 1
                                                                              ? fmenvdata[index].fmenvSamples![myindex].testUnit!.toString()
                                                                              : nesreadata[index].nesreaSamples![myindex].testUnit!.toString(),
                                                                      limit: _sampleProvider.templateIndex == 0
                                                                          ? dprdata[index].dprSamples![myindex].testLimit!.toString()
                                                                          : _sampleProvider.templateIndex == 1
                                                                              ? fmenvdata[index].fmenvSamples![myindex].testLimit!.toString()
                                                                              : nesreadata[index].nesreaSamples![myindex].testLimit!.toString(),
                                                                      result: _sampleProvider.templateIndex == 0
                                                                          ? dprdata[index].dprSamples![myindex].testResult!.toString()
                                                                          : _sampleProvider.templateIndex == 1
                                                                              ? fmenvdata[index].fmenvSamples![myindex].testResult!.toString()
                                                                              : nesreadata[index].nesreaSamples![myindex].testResult!.toString(),
                                                                      testName: 'Result Details'));
                                                                },
                                                                title: Text(
                                                                  _sampleProvider.templateIndex == 0
                                                                      ? dprdata[index].dprSamples![myindex].testName!.toString()
                                                                      : _sampleProvider.templateIndex == 1
                                                                          ? fmenvdata[index].fmenvSamples![myindex].testName!.toString()
                                                                          : nesreadata[index].nesreaSamples![myindex].testName!.toString(),
                                                                ),
                                                                trailing: Text(
                                                                  'Delivered',
                                                                  style: TextStyle(fontSize: 12),
                                                                ),
                                                                subtitle: Row(
                                                                  children: [
                                                                    Text(DateFormat('d MMMM y')
                                                                        .format(
                                                                          _sampleProvider.templateIndex == 0
                                                                              ? dprdata[index].time!
                                                                              : _sampleProvider.templateIndex == 1
                                                                                  ? fmenvdata[index].time!
                                                                                  : nesreadata[index].time!,
                                                                        )
                                                                        .toString()),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(DateFormat('HH:mm:ss a')
                                                                        .format(
                                                                          _sampleProvider.templateIndex == 0
                                                                              ? dprdata[index].time!
                                                                              : _sampleProvider.templateIndex == 1
                                                                                  ? fmenvdata[index].time!
                                                                                  : nesreadata[index].time!,
                                                                        )
                                                                        .toString()),
                                                                  ],
                                                                ),
                                                              ),
                                                              Divider()
                                                            ],
                                                          );
                                                        }),
                                                      )),
                                                );
                                        })
                              ],
                            ),
                          ),

                          //Offline Tab
                          MediaQuery.removePadding(
                            context: context,
                            removeRight: false,
                            removeTop: true,
                            removeLeft: false,
                            child: ListView(
                              children: [],
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
      ),
    );
  }

  void _selectTemplateType() {
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
}
