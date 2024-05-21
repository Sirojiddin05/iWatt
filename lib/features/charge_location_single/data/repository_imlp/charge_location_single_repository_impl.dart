import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/charge_location_single/data/datasources/charge_location_single_datasource.dart';
import 'package:i_watt_app/features/charge_location_single/domain/repositories/charge_location_single_repository.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';

class ChargeLocationSingleRepositoryImpl implements ChargeLocationSingleRepository {
  final ChargeLocationSingleDataSource _datasource;

  const ChargeLocationSingleRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, ChargeLocationEntity>> getLocationSingle(int id) async {
    try {
      final result = await _datasource.getLocationSingle(id);
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
