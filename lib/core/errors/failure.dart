abstract class Failure {
    final String message;
    const Failure(this.message);
}

class ServerFailure extends Failure {
    final int? statusCode;
    const ServerFailure(super.message, {this.statusCode});
}

class CacheFailure extends Failure {
    const CacheFailure(super.message);
}

class UnknownFailure extends Failure {
    const UnknownFailure(super.message);
}
