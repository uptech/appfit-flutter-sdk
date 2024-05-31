class DeviceProperties {
  /// The Device Manufacturer (Apple)
  final String? manufacturer;

  /// The Device Model (MacBookPro18,4)
  final String? model;

  const DeviceProperties({
    required this.manufacturer,
    required this.model,
  });

  /// Converts the [DeviceProperties] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'manufacturer': manufacturer,
      'model': model,
    };
  }

  /// Creates a new instance of [DeviceProperties] from a JSON object.
  factory DeviceProperties.fromJson(Map<String, dynamic> json) {
    return DeviceProperties(
      manufacturer: json['manufacturer'],
      model: json['model'],
    );
  }
}
