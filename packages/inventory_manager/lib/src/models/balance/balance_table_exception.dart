class BalanceTableException implements Exception {}

class RemoveRecordException extends BalanceTableException {}

class AddRecordException extends BalanceTableException {}

class ContainsManyBalanceRowInSameDateException extends AddRecordException {}
