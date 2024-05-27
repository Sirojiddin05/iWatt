import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';

abstract class ChangeLanguageRepository {
  Future<Either<Failure, void>> changeLanguage({required String languageCode});
}
