extension IntValidator on int? {
  bool isNotNullOrEmpty() => this != null && this! != 0;
}
