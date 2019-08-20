class SearchResultError {
  final String message;

  const SearchResultError({this.message});

  static SearchResultError fromJson(dynamic json) {
    return SearchResultError(
      message: json['message'] as String
    );
  }
}

class MetaResponse {
  final SearchResultError searchResultError;

  const MetaResponse({this.searchResultError});

  static MetaResponse fromJson(dynamic json){
    return MetaResponse(
      searchResultError: SearchResultError.fromJson(json['meta'])
    );
  }
}