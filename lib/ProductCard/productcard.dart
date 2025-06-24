import 'package:flutter/material.dart';
import 'package:rest_api_crud_operation/Model/ProductModel.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_crud_operation/Home.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ProductCard extends StatefulWidget {
  final dynamic product;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProductCard({
    Key? key,
    required this.product,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late bool _isVideo;
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _isVideo = _checkIfVideo(widget.product.img.toString());

    if (_isVideo) {
      _videoController = VideoPlayerController.network(
          widget.product.img.toString(),
        )
        ..initialize()
            .then((_) {
              setState(() {
                _isVideoInitialized = true;
                _videoController?.setLooping(true);
                _videoController?.play();
              });
            })
            .catchError((error) {
              setState(() {
                _isVideoInitialized = false;
              });
            });
    }
  }

  bool _checkIfVideo(String url) {
    return url.toLowerCase().endsWith('.mp4') ||
        url.toLowerCase().contains('video');
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 120,

                color: Colors.blueAccent,
                child:
                    _isVideo
                        ? _isVideoInitialized
                            ? AspectRatio(
                              aspectRatio: _videoController!.value.aspectRatio,
                              child: VideoPlayer(_videoController!),
                            )
                            : Center(child: CircularProgressIndicator())
                        : Image.network(
                          widget.product.img.toString(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              'https://www.shutterstock.com/image-illustration/parcel-box-exclamation-mark-about-260nw-2377273621.jpg',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    widget.product.productName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Price: ${widget.product.unitPrice ?? 0} | QTY : ${widget.product.qty ?? 0}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: widget.onEdit,
                    icon: Icon(Icons.edit, color: Colors.orange),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
