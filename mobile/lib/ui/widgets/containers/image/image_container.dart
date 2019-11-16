import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

//import '../../../util/formatter.dart';

class ImageContainer extends StatelessWidget {
  final String id;
  final String placeholderImage;
  final BorderRadius borderRadius;
  final BoxFit fit;
  final Widget placeholderWidget;

  ImageContainer({this.id, this.fit = BoxFit.cover, this.borderRadius, this.placeholderWidget, this.placeholderImage = 'assets/images/feed.jpg'});
   
  Widget buildEmptyImage(BuildContext context) {
    if (placeholderWidget != null) {
      return placeholderWidget;
    } else {
      return Container(
        child: Image(
          width: MediaQuery.of(context).size.width, 
          height: MediaQuery.of(context).size.height,
          fit: fit,
          image: AssetImage(placeholderImage),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
     if (id != null) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.only(),
        child: CachedNetworkImage( 
          width: MediaQuery.of(context).size.width, 
          height: MediaQuery.of(context).size.height,
          fadeOutDuration: Duration(milliseconds: 100),
          fadeInDuration: Duration(milliseconds: 100),
          imageUrl: 'http://34.90.110.227:3002/images/${id}', //'http://10.84.110.246:3000/images/${id}',
          fit: fit,
          placeholder: (context, url) {
            return buildEmptyImage(context);
          },
          errorWidget: (context, url, error) {
            return buildEmptyImage(context);
          }
        )
      );
    } else {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.only(),
        child: buildEmptyImage(context)
      );
    }
  }
}