import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';
import 'package:i_watt_app/features/map/data/datasource/map_data_source.dart';
import 'package:i_watt_app/features/map/data/datasource/map_local_data_source.dart';
import 'package:i_watt_app/features/map/data/models/cluster_model.dart';
import 'package:i_watt_app/features/map/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource _remoteDataSource;
  final MapLocalDataSource _localDataSource;
  const MapRepositoryImpl(this._remoteDataSource, this._localDataSource);
  @override
  Future<Either<Failure, GenericPagination<ClusterModel>>> getClusters({required GetChargeLocationParamEntity params}) async {
    try {
      final result = await _remoteDataSource.getClusters(params: params);
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
  Future<Either<Failure, ChargeLocationEntity>> getLocation({required String key}) async {
    try {
      final result = await _remoteDataSource.getLocation(key: key);
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
  Future<Either<Failure, List<ChargeLocationEntity>>> getMapLocationsFromRemote() async {
    try {
      final result = await _remoteDataSource.getMapLocations();
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
  Future<Either<Failure, void>> saveLocationList(List<ChargeLocationEntity> locations) async {
    try {
      final result = await _localDataSource.saveLocationList(locations);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChargeLocationEntity>>> getMapLocationsFromLocal() async {
    try {
      final result = await _localDataSource.getMapLocations();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }
}
