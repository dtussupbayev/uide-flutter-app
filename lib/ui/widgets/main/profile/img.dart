import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uide/ui/resources/resources.dart';
import 'package:uide/ui/theme/project_colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uide/ui/widgets/main/profile/profile_screen_model.dart';

class LongPressZoomImage extends StatefulWidget {
  final String imageUrl;
  final double radius;
  final double width;
  final double height;
  final bool isNetworkImage;
  final Function onRetryPressed;
  final UserProfileModel? model;

  const LongPressZoomImage({
    super.key,
    required this.imageUrl,
    this.radius = 100.0,
    this.width = 200.0,
    this.height = 200.0,
    this.isNetworkImage = false,
    required this.onRetryPressed,
    this.model,
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
                  builder: (context) => widget.isNetworkImage
                      ? FullScreenZoomImage(
                          imageUrl: widget.imageUrl,
                          isNetworkImage: true,
                        )
                      : FullScreenZoomImage(
                          imageUrl: widget.imageUrl,
                        ),
                ),
              );
            },
            child: widget.isNetworkImage
                ? FadeImageWidget(
                    model: widget.model,
                    onRetryPressed: widget.onRetryPressed,
                  )
                : FadeImageWidget(
                    model: widget.model,
                    onRetryPressed: widget.onRetryPressed,
                  ),
          ),
        ),
      ),
    );
  }
}

class FullScreenZoomImage extends StatelessWidget {
  final String imageUrl;
  final bool isNetworkImage;

  const FullScreenZoomImage(
      {super.key, required this.imageUrl, this.isNetworkImage = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Hero(
            tag: imageUrl,
            child: Stack(
              children: [
                isNetworkImage
                    ? PhotoView(
                        imageProvider: NetworkImage(imageUrl),
                        backgroundDecoration:
                            const BoxDecoration(color: Colors.transparent),
                        loadingBuilder: (context, event) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : PhotoView(
                        imageProvider: AssetImage(imageUrl),
                        backgroundDecoration:
                            const BoxDecoration(color: Colors.transparent),
                        loadingBuilder: (context, event) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                Positioned(
                  top: 20,
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
      ),
    );
  }
}

class FadeImageWidget extends StatefulWidget {
  final Function onRetryPressed;
  final UserProfileModel? model;

  const FadeImageWidget({
    Key? key,
    required this.model,
    required this.onRetryPressed,
  }) : super(key: key);

  @override
  State<FadeImageWidget> createState() => _FadeImageWidgetState();
}

class _FadeImageWidgetState extends State<FadeImageWidget> {
  Uint8List? _imageBytes;
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadAsync();
  }

  Future<void> _loadAsync() async {
    print(widget.model!.userAvatarUrl);

    try {
      print('dosetstate');
      setState(() {
        _isLoading = true;
        print('insetstate');
      });
      print('poslesetstate');

      print(widget.model!.userAvatarUrl);
      final imageBytes =
          await widget.model!.loadImageBytes(widget.model!.userAvatarUrl);
      print(imageBytes);

      setState(() {
        _imageBytes = imageBytes;
        _isLoading = false;
        _hasError = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 11 / 5,
      child: _isLoading
          ? const ShimmerImageWidget()
          : _hasError
              ? const CircleAvatar(
                  backgroundImage: AssetImage(Images.avatarPlaceholder),
                )
              : Image.memory(
                  _imageBytes ?? kTransparentImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
    );
  }
}

class ShimmerImageWidget extends StatelessWidget {
  const ShimmerImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 11 / 5,
      child: Shimmer.fromColors(
        baseColor: Colors.black.withOpacity(0.3),
        highlightColor: Colors.black.withOpacity(0.1),
        child: Container(
          width: double.maxFinite,
          color: Colors.black.withOpacity(0.1),
        ),
      ),
    );
  }
}
