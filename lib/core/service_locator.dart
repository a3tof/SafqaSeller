import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/app/view_model/app_view_model.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<CacheHelper>(
    () => CacheHelper(sharedPreferences: sharedPreferences),
  );

  getIt.registerLazySingleton<AppViewModel>(
    () => AppViewModel(),
  );
}
