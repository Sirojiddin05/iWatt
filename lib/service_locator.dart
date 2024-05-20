import 'package:get_it/get_it.dart';
import 'package:i_watt_app/core/network/dio_settings.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';

final serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  await StorageRepository.getInstance();

  serviceLocator.registerLazySingleton(() => DioSettings());
  // serviceLocator.registerFactory(() => AuthenticationDatasourceImpl(dio: serviceLocator<DioSettings>().dio));
  // serviceLocator.registerFactory(() => AuthenticationRepositoryImpl(datasource: serviceLocator<AuthenticationDatasourceImpl>()));
  // serviceLocator.registerLazySingleton(() => ChargingProcessDataSourceImpl(serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => ChargingProcessRepositoryImpl(serviceLocator<ChargingProcessDataSourceImpl>()));
  // serviceLocator.registerLazySingleton(() => AddCarDatasourceImpl(dio: serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => AddCarRepositoryImpl(datasource: serviceLocator<AddCarDatasourceImpl>()));
  // serviceLocator.registerLazySingleton(() => ChargeLocationsDataSourceImpl(serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => ChargeLocationsRepositoryImpl(serviceLocator<ChargeLocationsDataSourceImpl>()));
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
  // serviceLocator.registerLazySingleton(() => PromoCodeDataSourceImpl(serviceLocator<DioSettings>().dio));
  // serviceLocator.registerLazySingleton(() => PromocodeRepositoryImpl(serviceLocator<PromoCodeDataSourceImpl>()));
}
