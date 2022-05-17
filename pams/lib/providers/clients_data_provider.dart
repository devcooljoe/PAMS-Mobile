import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/services/client_service.dart';
import 'package:pams/view_models/client_service_vm.dart';

final clientViewModel = ChangeNotifierProvider<ClienServiceViewModel>(
    (ref) => ClienServiceViewModel(ref.read));

final clientServiceProvider =
    Provider<ClientServiceImplementation>((ref) => ClientServiceImplementation(ref.read));