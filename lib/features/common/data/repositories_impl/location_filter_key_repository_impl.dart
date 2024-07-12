import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/common/data/datasources/location_filter_key_datasource.dart';
import 'package:i_watt_app/features/common/domain/entities/location_filter_key_entity.dart';
import 'package:i_watt_app/features/common/domain/repositories/location_filter_key_repository.dart';

class LocationFilterKeyRepositoryImpl implements LocationFilterKeyRepository {
  final LocationFilterKeyDataSource _dataSource;

  const LocationFilterKeyRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<LocationFilterKeyEntity>>> getLocationFilterKeys() async {
    try {
      final result = await _dataSource.getLocationFilterKeys();
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
