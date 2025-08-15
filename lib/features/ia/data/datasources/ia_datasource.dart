abstract interface class IADatasource {
  Future<String?> generateText({required prompt});
}