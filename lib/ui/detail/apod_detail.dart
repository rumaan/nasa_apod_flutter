import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../model/apod_model.dart';

class ApodDetailsPage extends StatelessWidget {
  final ApodModel apod;

  const ApodDetailsPage({
    Key key,
    @required this.apod,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.file_download),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 370.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: apod.date,
                child:
                    CachedNetworkImage(imageUrl: apod.url, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            sliver: DefaultTextStyle(
              style: TextStyle(color: Colors.black),
              child: SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      apod.title,
                      maxLines: 3,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      apod.date,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      apod.explanation,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 70,
            delegate: SliverChildListDelegate([Container()]),
          )
        ],
      ),
    );
  }
}
