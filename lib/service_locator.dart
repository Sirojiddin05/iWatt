import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/network/dio_settings.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/features/authorization/data/datasources/authentication_datasource.dart';
import 'package:i_watt_app/features/authorization/data/datasources/sign_in_datasource.dart';
import 'package:i_watt_app/features/authorization/data/repositories_impl/authentication_repository_impl.dart';
import 'package:i_watt_app/features/authorization/data/repositories_impl/sign_in_repository_impl.dart';
import 'package:i_watt_app/features/charge_location_single/data/datasources/appeal_datasource.dart';
import 'package:i_watt_app/features/charge_location_single/data/datasources/charge_location_single_datasource.dart';
import 'package:i_watt_app/features/charge_location_single/data/repository_imlp/appeal_repository_impl.dart';
import 'package:i_watt_app/features/charge_location_single/data/repository_imlp/charge_location_single_repository_impl.dart';
import 'package:i_watt_app/features/charging_processes/data/datasource/charging_process_datasource.dart';
import 'package:i_watt_app/features/charging_processes/data/datasource/transaction_history_datasource.dart';
import 'package:i_watt_app/features/charging_processes/data/repositories_impl/charging_process_repository_impl.dart';
import 'package:i_watt_app/features/charging_processes/data/repositories_impl/transaction_history_repository_impl.dart';
import 'package:i_watt_app/features/common/data/datasources/about_us_datasource.dart';
import 'package:i_watt_app/features/common/data/datasources/change_language_datasource.dart';
import 'package:i_watt_app/features/common/data/datasources/connector_types_datasource.dart';
import 'package:i_watt_app/features/common/data/datasources/notifications_datasource.dart';
import 'package:i_watt_app/features/common/data/datasources/power_groups_datasource.dart';
import 'package:i_watt_app/features/common/data/datasources/search_history_datasource.dart';
import 'package:i_watt_app/features/common/data/datasources/socket_datasource.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/about_us_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/connector_types_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/notifications_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/power_groups_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/search_history_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/socket_repository_impl.dart';
import 'package:i_watt_app/features/list/data/datasources/charge_locations_data_source.dart';
import 'package:i_watt_app/features/list/data/repository_impl/charge_locations_repository_impl.dart';
import 'package:i_watt_app/features/navigation/data/datasources/instructions_datasource.dart';
import 'package:i_watt_app/features/navigation/data/datasources/version_check_datasource.dart';
import 'package:i_watt_app/features/navigation/data/repositories_impl/instructions_repository_impl.dart';
import 'package:i_watt_app/features/navigation/data/repositories_impl/version_check_repository_impl.dart';
import 'package:i_watt_app/features/profile/data/datasources/car_brands_datasource.dart';
import 'package:i_watt_app/features/profile/data/datasources/cars_datasource.dart';
import 'package:i_watt_app/features/profile/data/datasources/payments_data_source.dart';
import 'package:i_watt_app/features/profile/data/datasources/profile_datasource.dart';
import 'package:i_watt_app/features/profile/data/repositories_impl/car_brands_repository_impl.dart';
import 'package:i_watt_app/features/profile/data/repositories_impl/cars_repository_impl.dart';
import 'package:i_watt_app/features/profile/data/repositories_impl/change_language_repository_impl.dart';
import 'package:i_watt_app/features/profile/data/repositories_impl/payments_repository_impl.dart';
import 'package:i_watt_app/features/profile/data/repositories_impl/profile_repository_impl.dart';

final serviceLocator = GetIt.I;
const secureStorage = FlutterSecureStorage();

Future<void> setupLocator() async {
  await StorageRepository.getInstance();
  await dotenv.load(fileName: ".env");
  await secureStorage.write(
    key: StorageKeys.encryptionKey,
    value: dotenv.env[StorageKeys.encryptionKey] ?? '',
  );

  serviceLocator.registerLazySingleton(() => DioSettings());
  serviceLocator.registerFactory(() => AuthenticationDatasourceImpl(dio: serviceLocator<DioSettings>().dio));
  serviceLocator.registerFactory(() => AuthenticationRepositoryImpl(serviceLocator<AuthenticationDatasourceImpl>()));
  serviceLocator.registerLazySingleton(() => SignInDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => SignInRepositoryImpl(serviceLocator<SignInDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => ProfileDatasourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => ProfileRepositoryImpl(serviceLocator<ProfileDatasourceImpl>()));
  serviceLocator.registerLazySingleton(() => ChargeLocationsDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => ChargeLocationsRepositoryImpl(serviceLocator<ChargeLocationsDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => ConnectorTypesDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => ConnectorTypesRepositoryImpl(serviceLocator<ConnectorTypesDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => PowerTypesDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => PowerTypesRepositoryImpl(serviceLocator<PowerTypesDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => VersionCheckDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => InstructionsDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => VersionCheckRepositoryImpl(serviceLocator<VersionCheckDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => InstructionsRepositoryImpl(serviceLocator<InstructionsDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => SearchHistoryDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => SearchHistoryRepositoryImpl(serviceLocator<SearchHistoryDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => AboutUsDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => AboutUsRepositoryImpl(serviceLocator<AboutUsDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => NotificationDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => NotificationsRepositoryImpl(serviceLocator<NotificationDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => ChangeLanguageDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => ChangeLanguageRepositoryImpl(serviceLocator<ChangeLanguageDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => CarsDatasourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => CarsRepositoryImpl(serviceLocator<CarsDatasourceImpl>()));
  serviceLocator.registerLazySingleton(() => CarBrandsDatasourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => CarBrandsRepositoryImpl(serviceLocator<CarBrandsDatasourceImpl>()));
  serviceLocator.registerLazySingleton(() => ChargeLocationSingleDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => ChargeLocationSingleRepositoryImpl(serviceLocator<ChargeLocationSingleDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => AppealDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => AppealRepositoryImpl(serviceLocator<AppealDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => SocketDataSourceImpl());
  serviceLocator.registerLazySingleton(() => SocketRepositoryImpl(serviceLocator<SocketDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => ChargingProcessDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => ChargingProcessRepositoryImpl(serviceLocator<ChargingProcessDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => PaymentsDataSourceImpl(dio: serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => PaymentsRepositoryImpl(dataSource: serviceLocator<PaymentsDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => TransactionHistoryDatasourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => TransactionHistoryRepositoryImpl(serviceLocator<TransactionHistoryDatasourceImpl>()));
  // serviceLocator.registerLazySingleton(() => AppealDataSourceImpl(dio: serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => AppealRepositoryImpl(dataSource: serviceLocator<AppealDataSourceImpl>()));
  // serviceLocator.registerLazySingleton(() => InstructionDataSourceImpl(serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => InstructionRepositoryImpl(serviceLocator<InstructionDataSourceImpl>()));
  // serviceLocator.registerLazySingleton(() => MyStationsDataSourceImpl(dio: serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => MyStationsRepositoryImpl(dataSource: serviceLocator<MyStationsDataSourceImpl>()));
  // serviceLocator.registerLazySingleton(() => ReservationDataSourceImpl(serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => ReservationRepositoryImpl(serviceLocator<ReservationDataSourceImpl>()));
  // serviceLocator.registerLazySingleton(() => ChangeLanguageDataSourceImpl(serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => ChangeLanguageRepositoryImpl(serviceLocator<ChangeLanguageDataSourceImpl>()));
}

Future resetLocator() async {
  await serviceLocator.reset();
  await setupLocator();
}
