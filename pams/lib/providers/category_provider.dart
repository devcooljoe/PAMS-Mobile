import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/view_models/sample_template_category_vm.dart';

final categoryViewModel = ChangeNotifierProvider<CategoryViewModel>(
    (ref) => CategoryViewModel(ref.read));