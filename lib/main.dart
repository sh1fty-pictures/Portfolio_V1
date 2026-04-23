import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'dart:ui';

void main() {
  runApp(const MaterialApp(
    home: LinkTreePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class LinkTreePage extends StatelessWidget {
  const LinkTreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0118), // Dark Matrix Purple
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                
                // --- HEADER SECTION ---
                Text(
                  "LINK PAGE", // Page Name
                  style: TextStyle(
                    color: Colors.purpleAccent.withOpacity(0.8),
                    fontSize: 18,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.purpleAccent,
                  backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your image
                ),
                const SizedBox(height: 15),
                const Text(
                  "TIAN ABERCROMBIE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 30),

                // --- ABOUT ME BOX ---
                _buildGlassBox(
                  title: "About Me",
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      '''
-- Adobe Certified Professional --
-- Into Cars, Photography, & Games --
-- Just here to make a life for myself --
                      ''', //Bio
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // --- RESPONSIVE SECTION ---
                LayoutBuilder(builder: (context, constraints) {
                  // Inside your LinkTreePage build method...
                    if (constraints.maxWidth > 600) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildLeftColumn()),
                          const SizedBox(width: 20),
                          Expanded(child: _buildRightColumn(context)), // Pass context here
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          _buildLeftColumn(),
                          const SizedBox(height: 20),
                          _buildRightColumn(context), // Pass context here
                        ],
                      );
                    }
                }),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- COLUMN BUILDERS ---

  Widget _buildLeftColumn() {
    return _buildGlassBox(
      title: "Contact Info",
      child: Column(
        children: [
          _buildListTile(Icons.email, "shift.tianabercrombie@gmail.com"),
          _buildListTile(Icons.phone_android, "+1 (208) 290-0187"),
        ],
      ),
    );
  }

  Widget _buildRightColumn(BuildContext context) {
  return Column(
    children: [
      const PortfolioButton(),
      const SizedBox(height: 20),
      _buildGlassBox(
        title: "Socials",
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialIcon(
                Icons.camera_alt, 
                "https://instagram.com/sh1fty270", // Replace with your link
              ),
              _buildSocialIcon(
                Icons.facebook, 
                "https://facebook.com/sh1fty270", // Replace with your link
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
  
// --- REUSABLE UI COMPONENTS ---

Widget _buildSocialIcon(IconData icon, String url) {
  return IconButton(
    icon: Icon(icon, color: Colors.purpleAccent.withOpacity(0.8)),
    hoverColor: Colors.purpleAccent.withOpacity(0.2),
    splashRadius: 25,
    onPressed: () async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint("Could not launch $url");
      }
    },
  );
}

  Widget _buildGlassBox({Widget? child, String? title}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.purpleAccent.withOpacity(0.3), width: 1.5),
          ),
          child: Column(
            children: [
              if (title != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(title, style: const TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.bold)),
                ),
                const Divider(color: Colors.purpleAccent, indent: 50, endIndent: 50),
              ],
              child ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.purpleAccent, size: 20),
      title: Text(text, style: const TextStyle(color: Colors.white, fontSize: 14)),
    );
  }
}

// |Portfolio Button \\

class PortfolioButton extends StatefulWidget {
  const PortfolioButton({super.key});

  @override
  State<PortfolioButton> createState() => _PortfolioButtonState();
}

class _PortfolioButtonState extends State<PortfolioButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => isHovered = false), // Slight shrink on tap
        onTapUp: (_) => setState(() => isHovered = true),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PortfolioPage()),
          );
        },
        child: AnimatedScale(
          scale: isHovered ? 1.03 : 1.0, // Slight grow on hover
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // Border glows brighter when hovered
              border: Border.all(
                color: isHovered ? Colors.purpleAccent : Colors.purpleAccent.withOpacity(0.3),
                width: isHovered ? 2.5 : 1.5,
              ),
              boxShadow: [
                if (isHovered)
                  BoxShadow(
                    color: Colors.purpleAccent.withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  color: isHovered 
                      ? Colors.white.withOpacity(0.1) // Brightens background on hover
                      : Colors.white.withOpacity(0.05),
                  child: const Center(
                    child: Text(
                      "VIEW PORTFOLIO",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///////////\\\\\\\\\
// |Photos Button \\
///////////\\\\\\\\\

class PhotographyButton extends StatefulWidget {
  const PhotographyButton({super.key});

  @override
  State<PhotographyButton> createState() => _PhotographyButtonState();
}

class _PhotographyButtonState extends State<PhotographyButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => isHovered = false), // Slight shrink on tap
        onTapUp: (_) => setState(() => isHovered = true),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PhotographyPage()),
          );
        },
        child: AnimatedScale(
          scale: isHovered ? 1.03 : 1.0, // Slight grow on hover
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // Border glows brighter when hovered
              border: Border.all(
                color: isHovered ? Colors.purpleAccent : Colors.purpleAccent.withOpacity(0.3),
                width: isHovered ? 2.5 : 1.5,
              ),
              boxShadow: [
                if (isHovered)
                  BoxShadow(
                    color: Colors.purpleAccent.withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  color: isHovered 
                      ? Colors.white.withOpacity(0.1) // Brightens background on hover
                      : Colors.white.withOpacity(0.05),
                  child: const Center(
                    child: Text(
                      "VIEW PHOTGRAPHY",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// |Videos Button \\

class VideosButton extends StatefulWidget {
  const VideosButton({super.key});

  @override
  State<VideosButton> createState() => _VideosButtonState();
}

class _VideosButtonState extends State<VideosButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => isHovered = false), // Slight shrink on tap
        onTapUp: (_) => setState(() => isHovered = true),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VideographyPage()),
          );
        },
        child: AnimatedScale(
          scale: isHovered ? 1.03 : 1.0, // Slight grow on hover
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // Border glows brighter when hovered
              border: Border.all(
                color: isHovered ? Colors.purpleAccent : Colors.purpleAccent.withOpacity(0.3),
                width: isHovered ? 2.5 : 1.5,
              ),
              boxShadow: [
                if (isHovered)
                  BoxShadow(
                    color: Colors.purpleAccent.withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  color: isHovered 
                      ? Colors.white.withOpacity(0.1) // Brightens background on hover
                      : Colors.white.withOpacity(0.05),
                  child: const Center(
                    child: Text(
                      "VIEW VIDEOGRAPHY",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// |Portfolio Not Done Page \\

class PortfolioPageNotDone extends StatelessWidget {
  const PortfolioPageNotDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0118),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purpleAccent),
          onPressed: () => Navigator.pop(context), // Goes back to Link Tree
        ),
        title: const Text("PORTFOLIO", style: TextStyle(color: Colors.white, letterSpacing: 2)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction, size: 80, color: Colors.purpleAccent),
            const SizedBox(height: 20),
            Text(
              "Portfolio Content Coming Soon",
              style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              "Showcasing Photography, Videography, & Development",
              style: TextStyle(color: Colors.purpleAccent, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// |Portfolio Done Page \\
class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0118),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purpleAccent),
          onPressed: () => Navigator.pop(context), // Goes back to Link Tree
        ),
        title: const Text("PORTFOLIO", style: TextStyle(color: Colors.white, letterSpacing: 2)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const PhotographyButton(),
            const SizedBox(height: 20),
            const VideosButton(),
            const SizedBox(height: 20),
          ]
        ),
      ),
    );
  }
}

// |Photos Page \\

class PhotographyPage extends StatelessWidget {
  const PhotographyPage({super.key});

  final List<String> carPhotos = const [
    'assets/car1.jpg',
    'assets/car2.jpg',
    'assets/car3.jpg',
    'assets/car4.jpg',
    'assets/car5.jpg',
    'assets/car6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0118),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purpleAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("PHOTOGRAPHY", style: TextStyle(color: Colors.white, letterSpacing: 2)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: carPhotos.length,
          itemBuilder: (context, index) {
            return _buildPhotoCard(context, carPhotos[index]); // Pass context here
          },
        ),
      ),
    );
  }

  Widget _buildPhotoCard(BuildContext context, String assetPath) {
    return GestureDetector(
      onTap: () {
        // --- THIS IS YOUR LIGHTBOX ---
        showDialog(
          context: context,
          builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blurs background
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(assetPath, fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("CLOSE", 
                      style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.purpleAccent.withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            assetPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.white.withOpacity(0.05),
                child: const Icon(Icons.broken_image, color: Colors.purpleAccent),
              );
            },
          ),
        ),
      ),
    );
  }
}

// |Videos Page \\

class VideographyPage extends StatelessWidget {
  const VideographyPage({super.key});

  final List<Map<String, String>> videos = const [
    {'title': 'Night Meet 01', 'thumbnail': 'assets/thumb1.jpg', 'url': 'assets/video1.mp4'},
    {'title': 'Subaru Rally Prep', 'thumbnail': 'assets/thumb2.jpg', 'url': 'assets/video2.mp4'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0118),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purpleAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("VIDEOGRAPHY", style: TextStyle(color: Colors.white, letterSpacing: 2)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
            childAspectRatio: 16 / 9,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return _buildVideoCard(context, videos[index]);
          },
        ),
      ),
    );
  }

  Widget _buildVideoCard(BuildContext context, Map<String, String> video) {
    return GestureDetector(
      onTap: () => _playVideo(context, video['url']!),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
        ),
        child: Stack(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(video['thumbnail']!, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
            ),
            // Dark Overlay
            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black.withOpacity(0.24))),
            // Play Button Icon
            const Center(
              child: Icon(Icons.play_circle_fill, color: Colors.purpleAccent, size: 60),
            ),
            // Title Tag
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(video['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _playVideo(BuildContext context, String videoPath) {
    showDialog(
      context: context,
      builder: (context) => VideoPopUp(videoPath: videoPath),
    );
  }
}

// Separate Widget to handle Video State
class VideoPopUp extends StatefulWidget {
  final String videoPath;
  const VideoPopUp({super.key, required this.videoPath});

  @override
  State<VideoPopUp> createState() => _VideoPopUpState();
}

class _VideoPopUpState extends State<VideoPopUp> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _controller,
            autoPlay: true,
            looping: false,
            aspectRatio: _controller.value.aspectRatio,
            materialProgressColors: ChewieProgressColors(
              playedColor: Colors.purpleAccent,
              handleColor: Colors.deepPurple,
            ),
          );
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Chewie(controller: _chewieController!),
            )
          : const Center(child: CircularProgressIndicator(color: Colors.purpleAccent)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}