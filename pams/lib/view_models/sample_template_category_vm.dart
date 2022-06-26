import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/view_models/base_vm.dart';

class CategoryViewModel extends BaseViewModel {
  int templateIndex = 0;
  String categoryCode = 'DPR';
  int? clientIndex;

  CategoryViewModel(Reader read) : super(read);

  void changeIndex(String category, int templateNumber,
      SampleTemplate templateSampleText, int clienIndexNo) {
    categoryCode = category;
    templateIndex = templateNumber;
    clientIndex = clienIndexNo;
    notifyListeners();
  }
}
