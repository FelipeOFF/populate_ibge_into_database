class ParameterIsNullException extends Error {
  final String parameter;

  ParameterIsNullException(this.parameter);

  @override
  String toString() {
    return parameter;
  }
}
