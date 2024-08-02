import 'package:flutter/material.dart';
import 'package:frontend/summary/summary_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';

class ScanScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const ScanScreen({super.key, required this.cameras});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Find the front camera
    CameraDescription? frontCamera;
    for (var camera in widget.cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        frontCamera = camera;
        break;
      }
    }
    if (frontCamera != null) {
      _controller = CameraController(frontCamera, ResolutionPreset.max);
      _initializeControllerFuture = _controller.initialize();
    } else {
      // Handle the case where no front camera is found
      print("No front camera found");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/mainBg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _appBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 400,
                    width: 350,
                    child: FutureBuilder<void>(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: CameraPreview(_controller),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "Please ensure your eyes are visible and your face is framed from the shoulders up",
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Theme.of(context).primaryColor),
                          onPressed: () {
                            _controller.dispose();
                            _controller = CameraController(
                                widget.cameras[0], ResolutionPreset.max);
                            _initializeControllerFuture =
                                _controller.initialize();
                          },
                          child: Text(
                            "Try Again",
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 120,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle the next action here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            "Next",
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(right: 10,bottom: 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200.0),
                        color: const Color(0xFFD9FFF6)),
                    // child:  IconButton(icon: const Icon(Icons.check_rounded),onPressed: (){},focusColor: Theme.of(context).primaryColor,color: Colors.white,)
                  ),
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200.0),
                        color: const Color(0xFFB0FFED)),
                    // child:  IconButton(icon: const Icon(Icons.check_rounded),onPressed: (){},focusColor: Theme.of(context).primaryColor,color: Colors.white,)
                  ),
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200.0),
                        color: const Color(0xFF06DFAD),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.check_rounded),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SummaryScreen()));
                        },
                        focusColor: Theme.of(context).primaryColor,
                        color: Colors.white,
                      )),
                ],
              ),
            )),
      ],
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/student_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Amar G Nath",
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "2347208",
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
