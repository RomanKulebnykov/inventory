import 'guard_exception.dart';

class Guard {
  static T _againstFrame<T>(
    T val, {
    required bool Function(T val) checker,
    required GuardException exception,
    T? setIfIncorrect,
  }) {
    if (checker(val)) {
      return val;
    } else {
      if (setIfIncorrect != null) {
        return setIfIncorrect;
      } else {
        throw exception;
      }
    }
  }

  static num againstZero(
    num val, {
    num? setIfIncorrect,
    String? fieldName,
    String errorStr = 'value is zero',
  }) {
    return _againstFrame<num>(
      val,
      checker: (v) => v == 0,
      exception: ZeroGuardException(
        fieldName: fieldName,
        errorDescription: errorStr,
      ),
      setIfIncorrect: setIfIncorrect,
    );
  }

  static num againstNegative(
    num val, {
    num? setIfIncorrect,
    String? fieldName,
    String errorStr = 'value is negative',
  }) {
    return _againstFrame<num>(
      val,
      checker: (v) => v >= 0,
      exception: NegativeGuardException(
        fieldName: fieldName,
        errorDescription: errorStr,
      ),
      setIfIncorrect: setIfIncorrect,
    );
  }
}
