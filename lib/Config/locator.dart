import 'package:admin_panal/Services/Api/Attribute/AttributeServices.dart';
import 'package:admin_panal/Services/Api/Auth/AuthServices.dart';
import 'package:admin_panal/Services/Api/Brands/BrandsServices.dart';
import 'package:admin_panal/Services/Api/Category/category_services.dart';
import 'package:admin_panal/Services/Api/Messages/messageServices.dart';
import 'package:admin_panal/Services/Api/Orders/ordersServices.dart';
import 'package:admin_panal/Services/Api/Products/Products_Services.dart';
import 'package:admin_panal/Services/Api/SharedPreference/Storage_Services.dart';
import 'package:admin_panal/Services/Api/Store/storeServices.dart';
import 'package:admin_panal/Services/Navigation/navigation_services.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Navigation());
  locator.registerLazySingleton(() => CategoryServices());
  locator.registerLazySingleton(() => BrandServices());
  locator.registerLazySingleton(() => OrderServices());
  locator.registerLazySingleton(() => StoreServices());
  locator.registerLazySingleton(() => MessageServices());
  locator.registerLazySingleton(() => StorageServices());
  locator.registerLazySingleton(() => AuthServices());
  locator.registerLazySingleton(() => ProductServices());
  locator.registerLazySingleton(() => AttributeService());
}
