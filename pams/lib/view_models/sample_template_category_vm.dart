import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/view_models/base_vm.dart';

class CategoryViewModel extends BaseViewModel {
  
  String categoryCode = 'DPR';
  CategoryViewModel(Reader read) : super(read);

  void changeIndex( String category) {
    categoryCode = category;
    notifyListeners();
  }
}
