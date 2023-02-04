import 'dart:core';

/// ---------------------------------------------------- abstract GuardException
abstract class GuardException implements Exception {
  final String? _valueName;
  final String? _errorDescription;

  String get errorMessage {
    return '${_valueName == null ? '' : '$_valueName '}$_errorDescription';
  }

  GuardException({
    String? fieldName,
    String? errorDescription,
  })  : _valueName = fieldName,
        _errorDescription = errorDescription;
}

/// --------------------------------------------------------- ZeroGuardException
class ZeroGuardException extends GuardException {
  ZeroGuardException({super.fieldName, super.errorDescription});
}

/// ----------------------------------------------------- NegativeGuardException
class NegativeGuardException extends GuardException {
  NegativeGuardException({super.fieldName, super.errorDescription});
}
