/// Helper method para envolver queries do Supabase com tratamento de erros
Future<List<T>> executeSupabaseQuery<T>({
  required Future<List<dynamic>> Function() query,
  required T Function(Map<String, dynamic> json) converter,
  String errorMessage = 'Failed to fetch data',
}) async {
  try {
    final response = await query();

    if (response.isEmpty) {
      return [];
    }

    return response
        .map((json) {
          try {
            if (json is! Map<String, dynamic>) {
              throw FormatException('Invalid data format');
            }
            return converter(json);
          } catch (e) {
            throw Exception('$errorMessage: $e');
          }
        })
        .where((item) => item != null)
        .cast<T>()
        .toList();
  } catch (e) {
    throw Exception('$errorMessage: $e');
  }
}
