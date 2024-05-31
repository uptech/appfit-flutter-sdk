import 'package:appfit/networking/properties/operating_system/operating_system_name.dart';

class OperatingSystemProperties {
  /// Operating System Name
  ///
  /// This returns the name of the operating system
  /// Example: iOS, macOS, Windows, etc
  final OperatingSystemName name;

  /// Operating System Version
  ///
  /// This will follow Semantic Versioning
  /// so it will return a string similar to major.minor.path (i.e. 17.5.1)
  final String? version;

  const OperatingSystemProperties({
    required this.name,
    required this.version,
  });

  /// Converts the [OperatingSystemProperties] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'name': name.name,
      'version': version,
    };
  }

  /// Creates a new instance of [OperatingSystemProperties] from a JSON object.
  factory OperatingSystemProperties.fromJson(Map<String, dynamic> json) {
    return OperatingSystemProperties(
      name: json['name'],
      version: json['version'],
    );
  }
}
