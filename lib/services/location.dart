import 'package:geolocator/geolocator.dart';

class LocationService {

  Future<Position> getCurrentLocation() async {
    Position geolocatedPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

        return geolocatedPosition;
  }
}
