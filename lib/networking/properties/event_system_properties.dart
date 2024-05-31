import 'package:appfit/networking/properties/browser_properties.dart';
import 'package:appfit/networking/properties/device_properties.dart';
import 'package:appfit/networking/properties/operating_system/operating_system.dart';

/// Event System Properties
/// These return all of the system properties we generate based on the device type
/// and data we wish to always include in every event.
class EventSystemProperties {
  /// The version of the parent bundle
  final String? appVersion;

  /// All of the device related properties
  /// These include anything that is specific to the physical device
  /// such as model, operating system version, platform, etc
  final DeviceProperties? device;

  /// All of the browser properties
  /// These include the browser name, version, and user agent
  final BrowserProperties? browser;

  /// All of the operating system properties
  /// These include the operating system name (i.e. iOS or macOS)
  /// and the version number (i.e. 17.5.1)
  final OperatingSystemProperties? operatingSystem;

  /// Creates a new instance of [EventSystemProperties].
  const EventSystemProperties({
    this.appVersion,
    this.device,
    this.browser,
    this.operatingSystem,
  });

  /// Converts the [EventSystemProperties] to a JSON object.
  /// This is used to convert the object to a JSON object that can be sent to the server.
  Map<String, dynamic> toJson() {
    return {
      'appVersion': appVersion,
      'device': device?.toJson(),
      'os': operatingSystem?.toJson(),
    };
  }

  /// Creates a new instance of [EventSystemProperties] from a JSON object.
  /// This is used to convert a JSON object from the server into an instance of [EventSystemProperties].
  factory EventSystemProperties.fromJson(Map<String, dynamic> json) {
    return EventSystemProperties(
      appVersion: json['appVersion'],
      device: DeviceProperties.fromJson(json['device']),
      operatingSystem: OperatingSystemProperties.fromJson(json['os']),
    );
  }
}
