class Config {
  String apiUrl;
  String storageUrl;

  void debug() {
    apiUrl = "http://uniquote-api.flatpaks.com/api/";
    storageUrl = "http://uniquote-api.flatpaks.com/storage/";
  }

  void prod() {
    apiUrl = "https://uniquote.net/api/";
    storageUrl = "https://data.storage.googleapis.com/uniquote_main/";
  }
}
