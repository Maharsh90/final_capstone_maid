import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main(){
  runApp(MaterialApp(home: LocationSelectorPage(),));
}

class LocationSelectorPage extends StatefulWidget {
  const LocationSelectorPage({Key? key}) : super(key: key);

  @override
  _LocationSelectorPageState createState() => _LocationSelectorPageState();
}

class _LocationSelectorPageState extends State<LocationSelectorPage> {
  GoogleMapController? _mapController;
  // Marker? _selectedMarker;
  LatLng? _selectedLocation;
  // Marker? _selectedMarker = null;

  // Marker _selectedMarker = Marker(
  //   markerId: MarkerId('default'),
  //   position: LatLng(37.42796133580664, -122.085749655962),
  // );

  Marker _selectedMarker = Marker(
    markerId: MarkerId('marker_id'),
    position: LatLng(0, 0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _mapController = controller;
              });
            },
            onTap: (LatLng location) {
              _mapController?.animateCamera(CameraUpdate.newLatLng(location));
              setState(() {
                _selectedLocation = location;
                _selectedMarker = Marker(
                  markerId: MarkerId(location.toString()),
                  position: location,
                );
              });
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(37.42796133580664, -122.085749655962),
              zoom: 15.0,
            ),
            // markers: _selectedMarker != null ? Set<Marker>.from([_selectedMarker!]) : null,
            // markers: _selectedMarker != null ? <Marker>{_selectedMarker!} : null,
            // markers: _selectedMarker != null ? Set<Marker>.from([_selectedMarker!]) : null,
            // markers: _selectedMarker != null ? <Marker>{_selectedMarker!} : null,
            markers: <Marker>{_selectedMarker},
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedLocation != null) {
                    print('Selected location: ${_selectedLocation!.toString()}');
                    // Here you can store the selected location in a UI widget for later use
                  }
                },
                child: Text('Select Location'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
