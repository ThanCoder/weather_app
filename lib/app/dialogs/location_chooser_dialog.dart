import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather/app/components/core/index.dart';
import 'package:weather/app/widgets/index.dart';

class LocationChooserDialog extends StatefulWidget {
  double lat;
  double lon;
  void Function(double lat, double lon) onApply;
  LocationChooserDialog({
    super.key,
    required this.lat,
    required this.lon,
    required this.onApply,
  });

  @override
  State<LocationChooserDialog> createState() => _LocationChooserDialogState();
}

class _LocationChooserDialogState extends State<LocationChooserDialog> {
  bool isLoading = false;
  Location location = Location();
  final latController = TextEditingController();
  final lonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    latController.text = widget.lat.toString();
    lonController.text = widget.lon.toString();
  }

  void _getCurrentLocation() async {
    try {
      setState(() {
        isLoading = true;
      });
      bool serviceEnabled = false;
      PermissionStatus permissionGranted;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      final locationData = await location.getLocation();
      final lat = locationData.latitude ?? 0;
      final lon = locationData.longitude ?? 0;
      if (lat > 0) {
        latController.text = lat.toString();
      }
      if (lon > 0) {
        lonController.text = lon.toString();
      }

      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      showDialogMessage(context, e.toString());
    }
  }

  void _apply() {
    try {
      final lat = double.parse(latController.text);
      final lon = double.parse(lonController.text);
      Navigator.pop(context);
      widget.onApply(lat, lon);
    } catch (e) {
      showDialogMessage(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('တည်နေရာ ရွေးချယ်မယ်'),
      scrollable: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          TTextField(
            controller: latController,
            label: Text('Latitude'),
            textInputType: TextInputType.number,
            isSelectedAll: true,
            maxLines: 1,
          ),
          TTextField(
            controller: lonController,
            label: Text('Longitude'),
            textInputType: TextInputType.number,
            isSelectedAll: true,
            maxLines: 1,
          ),
          isLoading
              ? TLoader(size: 30)
              : TextButton(
                  onPressed: Platform.isLinux ? null : _getCurrentLocation,
                  child: Text('Current Location'),
                ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
        TextButton(
          onPressed: isLoading
              ? null
              : () {
                  _apply();
                },
          child: Text('Apply'),
        ),
      ],
    );
  }
}
