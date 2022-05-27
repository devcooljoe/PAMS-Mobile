import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/utils/strings.dart';

final loadingState = StateProvider.autoDispose<bool>((ref) => false);

final contentErrorState = StateProvider.autoDispose<String>((ref) => '');
final errorState = StateProvider.autoDispose<String>((ref) => '');
final pinErrorState = StateProvider.autoDispose<String>((ref) => '');
final passwordObscureProvider = StateProvider.autoDispose<bool>((ref) => true);
final appMode = StateProvider<bool>((ref) => true);
