// ignore: file_names
class ApiError {
  final int? statuiscode;
  final String message;
  ApiError({required this.message, this.statuiscode});

  @override
  String toString() {
    return message;
  }
}
