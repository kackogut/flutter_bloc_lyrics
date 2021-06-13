class SearchResultError {
  final String message;

  const SearchResultError({required this.message});

  static SearchResultError fromJson(dynamic json) {
    return SearchResultError(message: json['message'] as String);
  }
}

class MetaResponse {
  final SearchResultError searchResultError;

  const MetaResponse({required this.searchResultError});

  static MetaResponse fromJson(dynamic json) {
    return MetaResponse(
      searchResultError: SearchResultError.fromJson(json['meta']),
    );
  }
}
