import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';

import '../../api/apod_exception.dart';
import '../../model/apod_model.dart';
import '../home/bloc/home_bloc.dart';
import '../photo/photo_page.dart';

class ApodDetailsPage extends StatelessWidget {
  final ApodModel apod;

  const ApodDetailsPage({Key key, this.apod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF65E87D),
        onPressed: () => _handleDownloadClick(context),
        child: Icon(
          FontAwesomeIcons.download,
          color: Colors.black,
          size: 20,
        ),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 370.0,
            backgroundColor: Colors.black,
            flexibleSpace: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => PhotoViewPage(apod: apod),
                  ),
                );
              },
              child: FlexibleSpaceBar(
                background: Hero(
                  tag: apod.url,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      CachedNetworkImage(imageUrl: apod.url, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                              Colors.grey.withOpacity(0.0),
                              Color(0xFF121212),
                            ],
                                stops: [
                              0.0,
                              1.0
                            ])),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            sliver: DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: true,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 80,
                      child: Divider(
                        thickness: 6,
                        height: 20,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      apod.title,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          fontFamily: "Rubik Regular"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        apod.date,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Rubik Light"),
                      ),
                    ),
                    Text(
                      apod.explanation,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: "Zilla Slab Light"),
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

  Widget _downloadComplete(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.check_circle, color: Colors.green, size: 75.0),
        SizedBox(height: 14),
        Text(
          'Download Complete',
          style:
              Theme.of(context).textTheme.title.copyWith(color: Colors.black),
        ),
        SizedBox(height: 24),
        OutlineButton(
          child: Text('CLOSE'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _downloadError(BuildContext context, String message) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.error_outline, color: Colors.red, size: 75.0),
        SizedBox(height: 14),
        Text(
          'Failed to download the image!',
          style: Theme.of(context).textTheme.title.copyWith(color: Colors.red),
        ),
        SizedBox(height: 24),
        OutlineButton(
          child: Text('CLOSE'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _downloading(BuildContext context, AsyncSnapshot<double> snapshot) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Downloading...',
          style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.black,
                fontFamily: "Rubik Regular",
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 18),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            backgroundColor: Color(0xFF7EBDC3),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4B7175)),
            value: snapshot.data,
            semanticsValue: "${snapshot.data * 100}%",
            semanticsLabel: "Download Progress",
          ),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text(
                'CANCEL',
                style: TextStyle(
                  fontFamily: "Rubik Light",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              color: Colors.grey[350],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                Provider.of<HomeBloc>(context).cancelDownload();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }

  void _handleDownloadClick(BuildContext context) async {
    bool shouldDownload = await showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.8),
          context: context,
          barrierDismissible: true,
          barrierLabel: '',
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.grey,
              title: Text(
                'Download the image?',
                style: TextStyle(
                    fontFamily: "Rubik Regular",
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    'Yes, Download'.toUpperCase(),
                    style: TextStyle(
                        fontFamily: "Rubik Light",
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  color: Colors.grey[350],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                FlatButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'Cancel'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: "Rubik Light",
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
          transitionBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ) ??
        false;
    if (shouldDownload) {
      _initDownload(context);
    }
  }

  void _initDownload(BuildContext context) async {
    final bloc = Provider.of<HomeBloc>(context);
    try {
      bloc.download(apod);
      await showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.8),
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.grey,
            content: StreamBuilder<double>(
              stream: bloc.downloadProgress,
              initialData: 0.01,
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                if (snapshot.data == 1.0) {
                  return _downloadComplete(context);
                }
                return _downloading(context, snapshot);
              },
            ),
          );
        },
        transitionBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    } on ApodException catch (e) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            content: _downloadError(context, e.message),
          );
        },
      );
    }
  }
}
