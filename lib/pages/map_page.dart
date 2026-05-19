// lib/pages/map_page.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  bool _mapLoaded = false;
  MapType _currentMapType = MapType.satellite; 

  static const LatLng _pantaiPoganda = LatLng(-1.180224, 122.912855);

  final Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId('pantai_utama'),
      position: _pantaiPoganda,
      infoWindow: const InfoWindow(
        title: 'Pantai Poganda',
        snippet: 'Kab. Banggai Kepulauan, Sulawesi Tengah',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ),
  };

  void _toggleMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.satellite 
          ? MapType.normal 
          : MapType.satellite;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() => _mapLoaded = true);
    Future.delayed(const Duration(milliseconds: 500), () {
      controller.showMarkerInfoWindow(const MarkerId('pantai_utama'));
    });
  }

  // FUNGSI NAVIGASI
  Future<void> _openGoogleMapsExternal() async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${_pantaiPoganda.latitude},${_pantaiPoganda.longitude}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
    debugPrint("Tidak bisa membuka Maps");
  }
  }

  void _centerOnPoganda() {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(target: _pantaiPoganda, zoom: 15, tilt: 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Pantai Poganda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.layers_rounded),
            onPressed: _toggleMapType, 
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _pantaiPoganda,
              zoom: 14.5,
            ),
            markers: _markers,
            mapType: _currentMapType, 
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
          ),

          if (!_mapLoaded)
            Container(
              color: AppTheme.primary,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'Memuat peta...',
                      style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

          // Tombol Kontrol Peta (Zoom & Location)
          Positioned(
            right: 12,
            bottom: 130, 
            child: Column(
              children: [
                _MapBtn(icon: Icons.my_location_rounded, onTap: _centerOnPoganda),
                const SizedBox(height: 8),
                _MapBtn(icon: Icons.add_rounded, onTap: () => _mapController?.animateCamera(CameraUpdate.zoomIn())),
                const SizedBox(height: 4),
                _MapBtn(icon: Icons.remove_rounded, onTap: () => _mapController?.animateCamera(CameraUpdate.zoomOut())),
              ],
            ),
          ),
          
          // BOTTOM CARD DENGAN TOMBOL RUTE
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.1),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha:0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.beach_access_rounded, color: AppTheme.primary, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Pantai Poganda',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textDark),
                        ),
                        Text(
                          'Kab. Banggai Kepulauan, Sulteng',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: AppTheme.textGrey),
                        ),
                      ],
                    ),
                  ),
                  
                  
                  ElevatedButton.icon(
                    onPressed: _openGoogleMapsExternal, 
                    icon: const Icon(Icons.navigation_rounded, size: 16),
                    label: const Text(
                      'Rute', 
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w600)
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _MapBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8)],
        ),
        child: Icon(icon, color: AppTheme.textDark, size: 22),
      ),
    );
  }
}