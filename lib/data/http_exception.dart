import 'package:equatable/equatable.dart';

class HttpException extends Error with EquatableMixinBase, EquatableMixin {
  final String error;
  final int code;

  HttpException(this.error, this.code);

  @override
  List get props => [error];
}

class UnAuthorised extends HttpException {
  UnAuthorised() : super("UnAuthorised user", 401);
}

class UnAuthenticated extends HttpException {
  UnAuthenticated() : super("invalid username or password", 404);
}
