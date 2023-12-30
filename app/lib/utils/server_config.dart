class ServerDetail {
  String baseUrl;
  String apiPath;

  ServerDetail({
    required this.baseUrl,
    required this.apiPath,
  });
}

final Map<String, ServerDetail> serverDetails = {
  'prod': ServerDetail(
    baseUrl: 'https://app.hungrybrain.in',
    apiPath: '/api/user/',
  ),
  'dev': ServerDetail(
    baseUrl: 'dev.app.hungrybrain.in',
    apiPath: '/api/user/',
  ),
  'local': ServerDetail(
    baseUrl: 'http://127.0.0.1:8000',
    apiPath: '/api/v1',
  ),
};

