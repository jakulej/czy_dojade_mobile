import 'package:google_maps_flutter/google_maps_flutter.dart';

enum TransportStatus {
  inTransitTo,
  stoppedAt;

  static TransportStatus fromString(String str) {
    switch (str) {
      case 'IN_TRANSIT_TO':
        return TransportStatus.inTransitTo;
      case 'STOPPED_AT':
        return TransportStatus.stoppedAt;
      default:
        return TransportStatus.inTransitTo;
    }
  }
}

class Transport {
  String id;
  int type;
  String vehicleNo;
  String routeId;
  String tripId;
  int timestamp;
  LatLng latLng;
  String tripHeadsign;
  String stopId;
  TransportStatus currentStatus;
  Marker mapMarker;

  Transport._(
      {required this.id,
      required this.type,
      required this.vehicleNo,
      required this.routeId,
      required this.tripId,
      required this.timestamp,
      required this.latLng,
      required this.tripHeadsign,
      required this.stopId,
      required this.currentStatus,
      required this.mapMarker});

  static Transport fromJson(dynamic json) {
    double lat = ensureDouble(json['lat']);
    double lon = ensureDouble(json['lon']);
    LatLng latLng = LatLng(lat, lon);
    String id = json['id'];
    bool isBus = json['type'] == '3';
    return Transport._(
      id: id,
      type: isBus ? 3 : 0,
      vehicleNo: json['vehicleNo'],
      routeId: json['route_id'],
      tripId: json['trip_id'] ?? '',
      timestamp: json['timestamp'],
      latLng: latLng,
      tripHeadsign: json['trip_headsign'] ?? '',
      stopId: json['stop_id'] ?? '',
      currentStatus: TransportStatus.fromString(json['currentStatus'] ?? ''),
      mapMarker: Marker(
        markerId: MarkerId(id),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(
            isBus ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueBlue),
      ),
    );
  }

  static double ensureDouble(dynamic field) {
    if (field is int) {
      return field.toDouble();
    } else {
      return field;
    }
  }
}
