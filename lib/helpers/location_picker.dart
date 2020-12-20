import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FormBuilderLocationPicker extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final LatLng initialValue;
  final InputDecoration decoration;
  final double markerIconSize;

  const FormBuilderLocationPicker({
    Key key,
    @required this.attribute,
    this.validators = const [],
    this.initialValue,
    this.decoration = const InputDecoration(),
    this.markerIconSize = 20,
  }) : super(key: key);

  @override
  _FormBuilderLocationPickerState createState() =>
      _FormBuilderLocationPickerState();
}

class _FormBuilderLocationPickerState extends State<FormBuilderLocationPicker> {
  // AIzaSyDOI61ZLkaXrDM0y3qqoNd2goGWr3ZIkVg //TODO: Store key in .env
  FocusNode _focusNode;
  final _fieldKey = GlobalKey<FormFieldState>();
  TextEditingController _controller;
  bool hadFocus = false;
  final GlobalKey _markerKey = GlobalKey();
  final _controllerCompleter = Completer<GoogleMapController>();
  Position currentPosition;

  bool get hasFocus => _focusNode.hasFocus;

  @override
  void initState() {
    _focusNode = FocusNode()..addListener(_handleFocusChanged);
    _controller = TextEditingController(text: widget.initialValue?.toString());
    _getCurrentPosition();
    super.initState();
  }

  void _getCurrentPosition() async {
    currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: widget.attribute,
      validator: FormBuilderValidators.compose(widget.validators),
      initialValue: widget.initialValue,
      key: _fieldKey,
      builder: (field) {
        return TextField(
            readOnly: true,
            focusNode: _focusNode,
            controller: _controller,
            decoration: widget.decoration.copyWith(
              contentPadding: EdgeInsets.only(
                top: 0,
                right: 0,
                bottom: 0,
                left: 15,
              ),
              suffixIcon: Container(
                height: 25,
                width: 25,
                child: IconButton(
                  icon: Icon(Icons.location_on),
                  color: Colors.white,
                  onPressed: _handleFocusChanged,
                ),
              ),
            ));
      },
    );
  }

  void _handleFocusChanged() {
    if (hasFocus && !hadFocus) {
      hadFocus = hasFocus;
      _showModal();
      FocusScope.of(context).requestFocus(FocusNode());
    } else {
      hadFocus = hasFocus;
    }
  }

  void _showModal() async {
    var position = await showModalBottomSheet(
      context: context,
      builder: (context) {
        LatLng value = _fieldKey.currentState?.value;
        var currentLocation = currentPosition != null
            ? LatLng(currentPosition.latitude, currentPosition.longitude)
            : null;
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.green,
          child: Column(
            children: <Widget>[
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    var maxHeight = constraints.biggest.height;
                    var maxWidth = constraints.biggest.width;
                    return Stack(
                      children: <Widget>[
                        Container(
                          height: maxHeight,
                          width: maxWidth,
                          child: GoogleMap(
                            initialCameraPosition: widget.initialValue ??
                                CameraPosition(
                                  target: value ??
                                      currentLocation ??
                                      LatLng(
                                        37.42796133580664,
                                        -122.085749655962,
                                      ),
                                  zoom: 14.4746,
                                ),
                            onMapCreated: (GoogleMapController controller) {
                              if (!_controllerCompleter.isCompleted) {
                                _controllerCompleter.complete(controller);
                              }
                            },
                            onCameraMove: (CameraPosition newPosition) {
                              value = newPosition.target;
                            },
                          ),
                        ),
                        Positioned(
                          bottom: maxHeight / 2,
                          right: (maxWidth - widget.markerIconSize) / 2,
                          child: Container(
                            key: _markerKey,
                            child: Icon(
                              Icons.location_on,
                              size: widget.markerIconSize,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop(value);
                      },
                    ),
                    RaisedButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
    if (position != null) {
      _controller.text = position.toString();
      _fieldKey.currentState?.didChange(position.toString());
    }
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }
}
