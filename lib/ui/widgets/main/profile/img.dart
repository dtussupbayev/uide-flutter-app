import 'package:flutter/material.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:photo_view/photo_view.dart';

class LongPressZoomImage extends StatefulWidget {
  final String imageUrl;
  final double radius;
  final double width;
  final double height;

  const LongPressZoomImage({
    super.key,
    required this.imageUrl,
    this.radius = 100.0,
    this.width = 200.0,
    this.height = 200.0,
  });

  @override
  State<LongPressZoomImage> createState() => _LongPressZoomImageState();
}

class _LongPressZoomImageState extends State<LongPressZoomImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Hero(
          tag: widget.imageUrl,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenZoomImage(
                    imageUrl: widget.imageUrl,
                  ),
                ),
              );
            },
            child: CircleAvatar(
              backgroundImage: AssetImage(widget.imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}

class FullScreenZoomImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenZoomImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: Stack(
            children: [
              PhotoView(
                imageProvider: AssetImage(imageUrl),
                backgroundDecoration:
                    const BoxDecoration(color: Colors.transparent),
                loadingBuilder: (context, event) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              Positioned(
                top: 160,
                left: 20,
                child: GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 52.5,
                    width: 52.5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: ProjectColors.kWhite.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: ProjectColors.kDarkGreen,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
