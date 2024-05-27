import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/common/data/datasources/change_language_datasource.dart';
import 'package:i_watt_app/features/profile/domain/repositories/change_language_repository.dart';

class ChangeLanguageRepositoryImpl implements ChangeLanguageRepository {
  final ChangeLanguageDataSource _dataSource;

  const ChangeLanguageRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, void>> changeLanguage({required String languageCode}) async {
    try {
      final result = await _dataSource.changeLanguage(languageCode: languageCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on CustomDioException catch (e) {
      final message = e.type.message;
      return Left(DioFailure(errorMessage: message));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    }
  }
}
