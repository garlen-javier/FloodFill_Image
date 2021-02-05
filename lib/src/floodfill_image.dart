import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;
import 'floodfill_painter.dart';

class FloodFillImage extends StatefulWidget {
  /// The image to display via [ImageProvider].
  /// <br>You can use [AssetImage] or [NetworkImage].
  final ImageProvider imageProvider;

  /// [Color] use for filling the area.
  final Color fillColor;

  /// Set [false] if you want to disable on touch fill function.
  /// <br>Default value is [true].
  final bool isFillActive;

  /// List of color that determines to which [Color]
  /// is/are needed to be avoided upon touch.
  /// <br>**Note:** Nearest color shade is applied.
  final List<Color> avoidColor;

  /// Set fill value [tolerance] that ranges from 0 to 100.
  /// <br>Default value is 8.
  final int tolerance;

  /// Width of the image.
  /// Parent widget width will be prioritize if it's provided and less than the image width.
  final int width;

  /// Height of the image.
  /// Parent widget height will be prioritize if it's provided and less than the image height.
  final int height;

  /// Alignment of the image.
  final AlignmentGeometry alignment;

  /// [Widget] to show while the image is being processed on initialization.
  /// <br>It uses [CircularProgressIndicator] by default.
  final Widget loadingWidget;

  /// Callback function that returns the touch position and an [Image] from *dart:ui* when flood fill starts.
  /// <br>**Note:** Touch coordinate is relative to the image dimension.
  final Function(Offset position,ui.Image image) onFloodFillStart;

  /// Callback function that returns an [Image] from *dart:ui* when flood fill ended.
  final Function(ui.Image image) onFloodFillEnd;

  /// Flutter widget that can use paint bucket functionality on the provided image.
  const FloodFillImage(
      {Key key,
      @required this.imageProvider,
      @required this.fillColor,
      this.isFillActive = true,
      this.avoidColor,
      this.tolerance = 8,
      this.width,
      this.height,
      this.alignment,
      this.loadingWidget,
      this.onFloodFillStart,
      this.onFloodFillEnd})
      : assert(imageProvider != null),
        super(key: key);

  @override
  _FloodFillImageState createState() => _FloodFillImageState();
}

class _FloodFillImageState extends State<FloodFillImage> {
  ImageProvider _imageProvider;
  ImageStream _imageStream;
  ImageInfo _imageInfo;
  double _width;
  double _height;
  FloodFillPainter _painter;
  ValueNotifier<Offset> _repainter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resizeImage();
    _getImage();
  }

  @override
  void didUpdateWidget(FloodFillImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageProvider != oldWidget.imageProvider) {
      _resizeImage();
      _getImage();
    }
  }

  void _resizeImage() {
    _imageProvider = widget.imageProvider;
    if (widget.width != null)
      _imageProvider = ResizeImage(widget.imageProvider, width: widget.width);
    if (widget.height != null)
      _imageProvider = ResizeImage(widget.imageProvider, height: widget.height);
  }

  void _getImage() {
    final ImageStream oldImageStream = _imageStream;
    _imageStream =
        _imageProvider.resolve(createLocalImageConfiguration(context));
    if (_imageStream.key != oldImageStream?.key) {
      final ImageStreamListener listener = ImageStreamListener(_updateImage);
      oldImageStream?.removeListener(listener);
      _imageStream.addListener(listener);
    }
  }

  void _updateImage(ImageInfo imageInfo, bool synchronousCall) {
    _imageInfo = imageInfo;
    _width = _imageInfo.image.width.toDouble();
    _height = _imageInfo.image.height.toDouble();
    _repainter = ValueNotifier(Offset(-1, -1));
    _painter = FloodFillPainter(
        image: _imageInfo.image,
        fillColor: widget.fillColor,
        notifier: _repainter,
        onFloodFillStart: widget.onFloodFillStart,
        onFloodFillEnd: widget.onFloodFillEnd,
        onInitialize: () {
          setState(() {
            //make sure painter is properly initialize
          });
        });
  }

  @override
  void dispose() {
    _imageStream.removeListener(ImageStreamListener(_updateImage));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_painter != null) {
      _painter.setFillColor(widget.fillColor); //incase we want to update fillColor
      _painter.setAvoidColor(widget.avoidColor);
      _painter.setTolerance(widget.tolerance);
      _painter.setIsFillActive(widget.isFillActive);
    }
    return (_imageInfo != null)
        ? LayoutBuilder(builder: (context, BoxConstraints constraints) {
            double w = _width;
            double h = _height;
            if (!constraints.maxWidth.isInfinite) {
              if (constraints.maxWidth < _width) {
                w = constraints.maxWidth;
              }
            }

            if (!constraints.maxHeight.isInfinite) {
              if (constraints.maxHeight < _height) {
                h = constraints.maxHeight;
              }
            }

            // print(" constraint max width " + constraints.maxWidth.toString());
            // print(" constraint max height " + constraints.maxHeight.toString());
            // print(" w " + w.toString());
            // print(" h " + h.toString());

            _painter.setSize(Size(w, h));
            return (widget.alignment == null)
                ? CustomPaint(painter: _painter, size: Size(w, h))
                : Align(
                    alignment: widget.alignment,
                    child: CustomPaint(painter: _painter, size: Size(w, h)));
          })
        : (widget.loadingWidget == null)
            ? CircularProgressIndicator()
            : widget.loadingWidget;
  }
}
