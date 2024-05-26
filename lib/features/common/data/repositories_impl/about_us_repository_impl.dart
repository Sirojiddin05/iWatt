import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/common/data/datasources/about_us_datasource.dart';
import 'package:i_watt_app/features/common/domain/entities/about_us_entity.dart';
import 'package:i_watt_app/features/common/domain/repositories/about_us_repository.dart';

class AboutUsRepositoryImpl implements AboutUsRepository {
  final AboutUsDataSource dataSource;

  const AboutUsRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, AboutUsEntity>> getAbout() async {
    try {
      final result = await dataSource.getAbout();
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
