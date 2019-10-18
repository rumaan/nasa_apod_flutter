import 'package:flutter/material.dart';
import 'package:nasa_apod_flutter/widgets/card.dart';

class About extends StatelessWidget {
  CardBuilder contributorsCardBuilder(String name, String profile) {
    return CardBuilder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "Rubik Regular",
                fontWeight: FontWeight.bold),
          ),
          Text(
            profile,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontFamily: "Rubik Regular",
            ),
          ),
        ],
      ),
    );
  }

  Widget apodAPISection(BuildContext context) {
    return CardBuilder(
      child: Row(children: <Widget>[
        SizedBox(
          child: Image.asset(
            'assets/images/nasa_logo.png',
            fit: BoxFit.scaleDown,
          ),
          height: 100,
          width: 100,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width -
              172.0, //132.0 is size of image + padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Office of the Chief Information Officer',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontFamily: "Rubik Regular",
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Open Innovation Team',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: "Rubik Regular",
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                'api.nasa.gov',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: "Rubik Regular",
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget contributorsSection() {
    return Column(children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Contributors',
          textAlign: TextAlign.right,
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontFamily: "Rubik Regular",
              fontWeight: FontWeight.bold),
        ),
      ),
      contributorsCardBuilder('Rumaan Khalander', 'GitHub/rumaan'),
      contributorsCardBuilder('Melwin Lobo', 'GitHub/melwinlobo18'),
    ]);
  }

  Widget librarySection() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Libraries',
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontFamily: "Rubik Regular",
                fontWeight: FontWeight.bold),
          ),
        ),
        contributorsCardBuilder('dio', 'https://pub.dev/packages/dio'),
        contributorsCardBuilder(
            'provider', 'https://pub.dev/packages/provider'),
        contributorsCardBuilder(
            'built_value', 'https://pub.dev/packages/built_value'),
        contributorsCardBuilder('intl', 'https://pub.dev/packages/intl'),
        contributorsCardBuilder('cached_network_image',
            'https://pub.dev/packages/cached_network_image'),
        contributorsCardBuilder(
            'photo_view', 'https://pub.dev/packages/photo_view'),
        contributorsCardBuilder(
            'image_downloader', 'https://pub.dev/packages/image_downloader'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('About'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            apodAPISection(context),
            Divider(
              thickness: 2.0,
              color: Colors.white,
              indent: 12.0,
              endIndent: 12.0,
            ),
            contributorsSection(),
            Divider(
              thickness: 2.0,
              color: Colors.white,
              indent: 12.0,
              endIndent: 12.0,
            ),
            librarySection()
          ],
        ),
      ),
    );
  }
}
