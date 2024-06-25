import 'package:dio/dio.dart';

class IpAddress {
  final String? address;
  final DateTime lastUpdatedAt;

  const IpAddress({
    this.address,
    required this.lastUpdatedAt,
  });

  bool get isExpired {
    // Determine if the IP address is expired
    // If the lastUpdatedAt is greater than 1 hour, then it's expired
    return address == null ||
        lastUpdatedAt.difference(DateTime.now()).inSeconds > 3600;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IpAddress &&
          runtimeType == other.runtimeType &&
          address == other.address;

  @override
  int get hashCode => address.hashCode;

  @override
  String toString() {
    return "IpAddress(address: $address, lastUpdatedAt: $lastUpdatedAt)";
  }

  static Future<IpAddress> fetchIpAddress() async {
    final response = await Dio().get("https://api.ipgeolocation.io/getip");
    if (response.statusCode == null) {
      return IpAddress(
        address: null,
        lastUpdatedAt: DateTime.now(),
      );
    }
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return IpAddress(
        address: response.data['ip'],
        lastUpdatedAt: DateTime.now(),
      );
    }
    return IpAddress(
      address: null,
      lastUpdatedAt: DateTime.now(),
    );
  }
}
