import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/apod_model.dart';
import '../detail/apod_detail.dart';

class ApodListItem extends StatelessWidget {
  final ApodModel item;

  const ApodListItem({Key key, @required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.circular(7.0);

    void _handleItemClick() {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, _, __) => ApodDetailsPage(apod: item),
          transitionsBuilder: (context, anim, a2, child) => FadeTransition(
            opacity: anim,
            child: child,
          ),
          transitionDuration: Duration(milliseconds: 375),
        ),
      );
    }

    return InkWell(
      onTap: _handleItemClick,
      child: Container(
        height: 270,
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        width: double.maxFinite,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: _borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.white30,
              offset: Offset(0, 8),
              blurRadius: 18,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: _borderRadius,
          child: Stack(
            overflow: Overflow.clip,
            children: <Widget>[
              Hero(
                tag: item.url,
                child: Container(
                  width: double.maxFinite,
                  child: CachedNetworkImage(
                    imageUrl: item.url,
                    fit: BoxFit.cover,
                    height: double.maxFinite,
                    alignment: Alignment.center,
                    placeholder: (context, url) =>
                        Center(child: CupertinoActivityIndicator()),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 6.0,
                      sigmaY: 7.0,
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      color: Colors.black54,
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Rubik Regular",
                                fontSize: 20),
                          ),
                          Text(
                            item.date,
                            style: TextStyle(fontFamily: "Rubik Light"),
                          ),
                          Flexible(
                            child: Text(
                              item.explanation,
                              style: TextStyle(
                                fontFamily: "Zilla Slab Light",
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
