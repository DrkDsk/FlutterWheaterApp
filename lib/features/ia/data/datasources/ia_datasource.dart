abstract interface class IADatasource {
  Future<List<String?>> generateText({required prompt});
}