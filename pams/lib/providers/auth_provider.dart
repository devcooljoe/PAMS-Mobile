import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/services/authentication_services.dart';
import 'package:pams/view_models/authentication_vm.dart';

final authViewModel = ChangeNotifierProvider<AuthViewModel>(
    (ref) => AuthViewModel(ref.read));

final authServiceProvider =
    Provider<AuthServiceImplementation>((ref) => AuthServiceImplementation(ref.read));