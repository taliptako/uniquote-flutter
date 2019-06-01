class Config {
  String apiUrl;
  String storageUrl;
  String privacyUrl;

  void debug() {
    apiUrl = "http://uniquote-api.flatpaks.com/api/";
    storageUrl = "http://uniquote-api.flatpaks.com/storage/";
    privacyUrl = "http://uniquote-api.flatpaks.com/privacy_policy.html";
  }

  void prod() {
    apiUrl = "https://uniquote.net/api/";
    storageUrl = "https://storage.googleapis.com/uniquote/";
    privacyUrl = "https://uniquote.net/privacy/privacy_policy.html";
  }
}
