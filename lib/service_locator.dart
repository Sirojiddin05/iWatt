import 'package:get_it/get_it.dart';
import 'package:i_watt_app/core/network/dio_settings.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/features/authorization/data/datasources/authentication_datasource.dart';
import 'package:i_watt_app/features/authorization/data/repositories_impl/authentication_repository_impl.dart';
import 'package:i_watt_app/features/common/data/datasources/connector_types_datasource.dart';
import 'package:i_watt_app/features/common/data/datasources/power_groups_datasource.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/connector_types_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/power_groups_repository_impl.dart';
import 'package:i_watt_app/features/list/data/datasources/charge_locations_data_source.dart';
import 'package:i_watt_app/features/list/data/repository_impl/charge_locations_repository_impl.dart';
import 'package:i_watt_app/features/navigation/data/datasources/version_check_datasource.dart';
import 'package:i_watt_app/features/navigation/data/repositories_impl/version_check_repository_impl.dart';

final serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  await StorageRepository.getInstance();

  serviceLocator.registerLazySingleton(() => DioSettings());
  serviceLocator.registerFactory(() => AuthenticationDatasourceImpl(dio: serviceLocator<DioSettings>().dio));
  serviceLocator.registerFactory(() => AuthenticationRepositoryImpl(datasource: serviceLocator<AuthenticationDatasourceImpl>()));
  // serviceLocator.registerLazySingleton(() => ChargingProcessDataSourceImpl(serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => ChargingProcessRepositoryImpl(serviceLocator<ChargingProcessDataSourceImpl>()));
  // serviceLocator.registerLazySingleton(() => AddCarDatasourceImpl(dio: serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => AddCarRepositoryImpl(datasource: serviceLocator<AddCarDatasourceImpl>()));
  serviceLocator.registerLazySingleton(() => ChargeLocationsDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => ChargeLocationsRepositoryImpl(serviceLocator<ChargeLocationsDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => ConnectorTypesDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => ConnectorTypesRepositoryImpl(serviceLocator<ConnectorTypesDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => PowerTypesDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => PowerTypesRepositoryImpl(serviceLocator<PowerTypesDataSourceImpl>()));
  serviceLocator.registerLazySingleton(() => VersionCheckDataSourceImpl(serviceLocator<DioSettings>().dio));
  serviceLocator.registerLazySingleton(() => VersionCheckRepositoryImpl(serviceLocator<VersionCheckDataSourceImpl>()));
  // serviceLocator.registerLazySingleton(() => BalanceDataSourceImpl(dio: serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => BalanceRepositoryImplement(dataSource: serviceLocator<BalanceDataSourceImpl>()));
  // serviceLocator.registerLazySingleton(() => NotificationDataSourceImpl(dio: serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => NotificationRepositoryImpl(dataSource: serviceLocator<NotificationDataSourceImpl>()));
  // serviceLocator.registerLazySingleton(() => PaymentsDataSourceImpl(dio: serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => PaymentsRepositoryImpl(dataSource: serviceLocator<PaymentsDataSourceImpl>()));
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
