import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleDownloadClick(context),
        child: Icon(Icons.file_download),
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
                  tag: apod.date,
                  child:
                      CachedNetworkImage(imageUrl: apod.url, fit: BoxFit.cover),
                ),
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
          style:
              Theme.of(context).textTheme.title.copyWith(color: Colors.black),
        ),
        SizedBox(height: 18),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
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
              child: Text('CANCEL'),
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
    bool shouldDownload = await showDialog<bool>(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(
                'Do you want to download the image?',
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.black),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: Text('Yes, Download'.toUpperCase()),
                ),
                FlatButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: Text('Cancel'.toUpperCase()),
                ),
              ],
            );
          },
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
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
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
