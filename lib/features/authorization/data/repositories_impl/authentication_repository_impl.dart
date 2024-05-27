import 'dart:async';

import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/enums/authentication_status.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/authorization/data/datasources/authentication_datasource.dart';
import 'package:i_watt_app/features/authorization/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationDatasource datasource;

  AuthenticationRepositoryImpl(this.datasource);

  final StreamController<AuthenticationStatus> _statusController = StreamController.broadcast(sync: true);

  @override
  Stream<AuthenticationStatus> authenticationStatusStream() async* {
    final result = await _validateUser();
    await Future.delayed(const Duration(milliseconds: 2800));
    if (result.isRight) {
      yield AuthenticationStatus.authenticated;
    } else {
      if (result.left is DioFailure && (result.left as DioFailure).type.isConnectionError) {
        yield AuthenticationStatus.unKnown;
      } else {
        yield AuthenticationStatus.unauthenticated;
      }
    }
    yield* _statusController.stream;
  }

  Future<Either<Failure, void>> _validateUser() async {
    try {
      final result = await datasource.validateToken();
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
