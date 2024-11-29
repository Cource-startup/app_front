enum ErrorType { userNotification, networkError, validationError }

class ErrorState {
  final String message;
  final ErrorType type;

  ErrorState(this.message, this.type);
}
