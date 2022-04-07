// import 'dart:async';
//
// import 'package:camera_platform_interface/camera_platform_interface.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() {
//   runApp(MyAppCamera());
// }
//
// class MyAppCamera extends StatefulWidget {
//   @override
//   State<MyAppCamera> createState() => _MyAppCameraState();
// }
//
// class _MyAppCameraState extends State<MyAppCamera> {
//   String _cameraInfo = 'Unknown';
//   List<CameraDescription> _cameras = <CameraDescription>[];
//   int _cameraIndex = 0;
//   int _cameraId = -1;
//   bool _initialized = false;
//   Size? _previewSize;
//   ResolutionPreset _resolutionPreset = ResolutionPreset.veryHigh;
//   StreamSubscription<CameraErrorEvent>? _errorStreamSubscription;
//   StreamSubscription<CameraClosingEvent>? _cameraClosingStreamSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsFlutterBinding.ensureInitialized();
//     _fetchCameras();
//   }
//
//   @override
//   void dispose() {
//     _disposeCurrentCamera();
//     _errorStreamSubscription?.cancel();
//     _errorStreamSubscription = null;
//     _cameraClosingStreamSubscription?.cancel();
//     _cameraClosingStreamSubscription = null;
//     super.dispose();
//   }
//
//   /// Fetches list of available cameras from camera_windows plugin.
//   Future<void> _fetchCameras() async {
//     String cameraInfo;
//     List<CameraDescription> cameras = <CameraDescription>[];
//
//     int cameraIndex = 0;
//     try {
//       cameras = await CameraPlatform.instance.availableCameras();
//       if (cameras.isEmpty) {
//         cameraInfo = 'No available cameras';
//       } else {
//         cameraIndex = _cameraIndex % cameras.length;
//         cameraInfo = 'Found camera: ${cameras[cameraIndex].name}';
//       }
//     } on PlatformException catch (e) {
//       cameraInfo = 'Failed to get cameras: ${e.code}: ${e.message}';
//     }
//
//     if (mounted) {
//       setState(() {
//         _cameraIndex = cameraIndex;
//         _cameras = cameras;
//         _cameraInfo = cameraInfo;
//       });
//     }
//   }
//
//   /// Initializes the camera on the device.
//   Future<void> _initializeCamera() async {
//     assert(!_initialized);
//
//     if (_cameras.isEmpty) {
//       return;
//     }
//
//     int cameraId = -1;
//     try {
//       final int cameraIndex = _cameraIndex % _cameras.length;
//       final CameraDescription camera = _cameras[cameraIndex];
//
//       cameraId = await CameraPlatform.instance.createCamera(
//         camera,
//         _resolutionPreset,
//       );
//
//       _errorStreamSubscription?.cancel();
//       _errorStreamSubscription = CameraPlatform.instance
//           .onCameraError(cameraId)
//           .listen(_onCameraError);
//
//       _cameraClosingStreamSubscription?.cancel();
//       _cameraClosingStreamSubscription = CameraPlatform.instance
//           .onCameraClosing(cameraId)
//           .listen(_onCameraClosing);
//
//       final Future<CameraInitializedEvent> initialized =
//           CameraPlatform.instance.onCameraInitialized(cameraId).first;
//
//       await CameraPlatform.instance.initializeCamera(
//         cameraId,
//         imageFormatGroup: ImageFormatGroup.unknown,
//       );
//
//       final CameraInitializedEvent event = await initialized;
//       _previewSize = Size(
//         event.previewWidth,
//         event.previewHeight,
//       );
//
//       if (mounted) {
//         setState(() {
//           _initialized = true;
//           _cameraId = cameraId;
//           _cameraIndex = cameraIndex;
//           _cameraInfo = 'Capturing camera: ${camera.name}';
//         });
//       }
//     } on CameraException catch (e) {
//       try {
//         if (cameraId >= 0) {
//           await CameraPlatform.instance.dispose(cameraId);
//         }
//       } on CameraException catch (e) {
//         debugPrint('Failed to dispose camera: ${e.code}: ${e.description}');
//       }
//
//       // Reset state.
//       if (mounted) {
//         setState(() {
//           _initialized = false;
//           _cameraId = -1;
//           _cameraIndex = 0;
//           _previewSize = null;
//           _cameraInfo =
//               'Failed to initialize camera: ${e.code}: ${e.description}';
//         });
//       }
//     }
//   }
//
//   Future<void> _disposeCurrentCamera() async {
//     if (_cameraId >= 0 && _initialized) {
//       try {
//         await CameraPlatform.instance.dispose(_cameraId);
//
//         if (mounted) {
//           setState(() {
//             _initialized = false;
//             _cameraId = -1;
//             _previewSize = null;
//             _cameraInfo = 'Camera disposed';
//           });
//         }
//       } on CameraException catch (e) {
//         if (mounted) {
//           setState(() {
//             _cameraInfo =
//                 'Failed to dispose camera: ${e.code}: ${e.description}';
//           });
//         }
//       }
//     }
//   }
//
//   Widget _buildPreview() {
//     return CameraPlatform.instance.buildPreview(_cameraId);
//   }
//
//   Future<void> _takePicture() async {
//     final XFile _file = await CameraPlatform.instance.takePicture(_cameraId);
//     _showInSnackBar('Picture captured to: ${_file.path}');
//   }
//
//   Future<void> _switchCamera() async {
//     if (_cameras.isNotEmpty) {
//       // select next index;
//       _cameraIndex = (_cameraIndex + 1) % _cameras.length;
//       if (_initialized && _cameraId >= 0) {
//         await _disposeCurrentCamera();
//         await _fetchCameras();
//         if (_cameras.isNotEmpty) {
//           await _initializeCamera();
//         }
//       } else {
//         await _fetchCameras();
//       }
//     }
//   }
//
//   Future<void> _onResolutionChange(ResolutionPreset newValue) async {
//     setState(() {
//       _resolutionPreset = newValue;
//     });
//     if (_initialized && _cameraId >= 0) {
//       // Re-inits camera with new resolution preset.
//       await _disposeCurrentCamera();
//       await _initializeCamera();
//     }
//   }
//
//   void _onCameraError(CameraErrorEvent event) {
//     if (mounted) {
//       _scaffoldMessengerKey.currentState?.showSnackBar(
//           SnackBar(content: Text('Error: ${event.description}')));
//
//       // Dispose camera on camera error as it can not be used anymore.
//       _disposeCurrentCamera();
//       _fetchCameras();
//     }
//   }
//
//   void _onCameraClosing(CameraClosingEvent event) {
//     if (mounted) {
//       _showInSnackBar('Camera is closing');
//     }
//   }
//
//   void _showInSnackBar(String message) {
//     _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       content: Text(message),
//       duration: const Duration(seconds: 1),
//     ));
//   }
//
//   final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
//       GlobalKey<ScaffoldMessengerState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final List<DropdownMenuItem<ResolutionPreset>> resolutionItems =
//         ResolutionPreset.values
//             .map<DropdownMenuItem<ResolutionPreset>>((ResolutionPreset value) {
//       return DropdownMenuItem<ResolutionPreset>(
//         value: value,
//         child: Text(value.toString()),
//       );
//     }).toList();
//
//     return MaterialApp(
//       scaffoldMessengerKey: _scaffoldMessengerKey,
//       home: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(
//             color: Colors.white,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Text('Plugin example app'),
//         ),
//         body: ListView(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 5,
//                 horizontal: 10,
//               ),
//               child: Text(_cameraInfo),
//             ),
//             if (_cameras.isEmpty)
//               ElevatedButton(
//                 onPressed: _fetchCameras,
//                 child: const Text('Re-check available cameras'),
//               ),
//             if (_cameras.isNotEmpty)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   DropdownButton<ResolutionPreset>(
//                     value: _resolutionPreset,
//                     onChanged: (ResolutionPreset? value) {
//                       if (value != null) {
//                         _onResolutionChange(value);
//                       }
//                     },
//                     items: resolutionItems,
//                   ),
//                   const SizedBox(width: 20),
//                   ElevatedButton(
//                     onPressed: _initialized
//                         ? _disposeCurrentCamera
//                         : _initializeCamera,
//                     child:
//                         Text(_initialized ? 'Dispose camera' : 'Create camera'),
//                   ),
//                   const SizedBox(width: 5),
//                   ElevatedButton(
//                     onPressed: _initialized ? _takePicture : null,
//                     child: const Text('Take picture'),
//                   ),
//                   const SizedBox(width: 5),
//                   if (_cameras.length > 1) ...<Widget>[
//                     const SizedBox(width: 5),
//                     ElevatedButton(
//                       onPressed: _switchCamera,
//                       child: const Text(
//                         'Switch camera',
//                       ),
//                     ),
//                   ]
//                 ],
//               ),
//             const SizedBox(height: 5),
//             if (_initialized && _cameraId > 0 && _previewSize != null)
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 10,
//                 ),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Container(
//                     constraints: const BoxConstraints(
//                       maxHeight: 500,
//                     ),
//                     child: AspectRatio(
//                       aspectRatio: _previewSize!.width / _previewSize!.height,
//                       child: _buildPreview(),
//                     ),
//                   ),
//                 ),
//               ),
//             if (_previewSize != null)
//               Center(
//                 child: Text(
//                   'Preview size: ${_previewSize!.width.toStringAsFixed(0)}x${_previewSize!.height.toStringAsFixed(0)}',
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
