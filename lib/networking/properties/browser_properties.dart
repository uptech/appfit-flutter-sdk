class BrowserProperties {
  final String? userAgent;
  final String? name;
  final String? version;

  const BrowserProperties({
    this.userAgent,
    this.name,
    this.version,
  });

  /// Converts the [BrowserProperties] to a JSON object.
  /// This is used to convert an instance of [BrowserProperties] into a JSON object that can be sent to the server.
  Map<String, dynamic> toJson() {
    return {
      'userAgent': userAgent,
      'name': name,
      'version': version,
    };
  }

  /// Creates a new instance of [BrowserProperties] from a JSON object.
  /// This is used to convert a JSON object from the server into an instance of [BrowserProperties].
  factory BrowserProperties.fromJson(Map<String, dynamic> json) {
    return BrowserProperties(
      userAgent: json['userAgent'],
      name: json['name'],
      version: json['version'],
    );
  }
}
