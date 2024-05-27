import 'dart:async';

import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/list/data/datasources/charge_locations_data_source.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';
import 'package:i_watt_app/features/list/domain/repositories/charge_locations_repository.dart';

class ChargeLocationsRepositoryImpl implements ChargeLocationsRepository {
  final ChargeLocationsDataSource _datasource;
  final StreamController<ChargeLocationEntity> _chargeLocationController = StreamController.broadcast(sync: true);

  ChargeLocationsRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, GenericPagination<ChargeLocationEntity>>> getChargeLocations({required GetChargeLocationParamEntity paramEntity}) async {
    try {
      final result = await _datasource.getChargeLocations(paramEntity: paramEntity);
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

  @override
  Future<Either<Failure, void>> saveUnSaveChargeLocation({required ChargeLocationEntity location}) async {
    try {
      print('saveUnSaveChargeLocation: ${!location.isFavorite}');
      _chargeLocationController.add(location.copyWith(isFavorite: !location.isFavorite));
      final result = await _datasource.saveUnSaveChargeLocation(id: location.id);
      return Right(result);
    } on ServerException catch (e) {
      _chargeLocationController.add(location.copyWith(isFavorite: location.isFavorite));
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on CustomDioException catch (e) {
      _chargeLocationController.add(location.copyWith(isFavorite: location.isFavorite));
      final message = e.type.message;
      return Left(DioFailure(errorMessage: message));
    } on ParsingException catch (e) {
      _chargeLocationController.add(location.copyWith(isFavorite: location.isFavorite));
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    }
  }

  @override
  Stream<ChargeLocationEntity> saveUnSaveChargeLocationStream() async* {
    yield* _chargeLocationController.stream;
  }
}
