import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fcl/core/datamodels/generalAdds_datamodel.dart';
import 'package:fcl/core/viewmodels/generalAdds_viewmodel.dart';

import 'package:fcl/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralAdssWidget extends StatefulWidget {
  const GeneralAdssWidget({Key key}) : super(key: key);

  @override
  _GeneralAdssWidgetState createState() => _GeneralAdssWidgetState();
}

class _GeneralAdssWidgetState extends State<GeneralAdssWidget> {
  GeneralAddsViewModel generalAddsViewModel = GeneralAddsViewModel();
  Future<GeneralAddsDatamodel> _generalAddsFuture;
  Timer timer;
  @override
  void dispose() {
    print("============disposing page=======================");
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    getGeneralAdds();
    super.initState();
  }

  getGeneralAdds() {
    _generalAddsFuture = generalAddsViewModel.getGeneralAddsData();
  }

  @override
  Widget build(BuildContext context) {
    final generalAddsViewModel = Provider.of<GeneralAddsViewModel>(context);
    return FutureBuilder<GeneralAddsDatamodel>(
      future: _generalAddsFuture,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null || !snapshot.hasData) {
            return emptyWidget;
          }
          return CarouselSlider(
            items: List.generate(snapshot.data.data.length, (index) {
              generalAddsViewModel.validateAndSubmitGeneralAddsStat(
                isGeneralAdd: true,
                wasClicked: false,
                generalAddId: snapshot.data.data[index].id,
              );
              print("i am here");
              // timer = Timer.periodic(
              //     Duration(seconds: 10),
              //     (Timer t) =>
              //         generalAddsViewModel.validateAndSubmitGeneralAddsStat(
              //           wasClicked: false,
              //           generalAddId: snapshot.data.data[index].id,
              //         ));

              return InkWell(
                onTap: () async {
                  if (await canLaunchUrl(
                      Uri.parse(snapshot.data.data[index].url))) {
                    await launchUrl(Uri.parse(snapshot.data.data[index].url));
                    await generalAddsViewModel.validateAndSubmitGeneralAddsStat(
                      isGeneralAdd: true,
                      wasClicked: true,
                      generalAddId: snapshot.data.data[index].id,
                    );
                  } else
                    // can't launch url, there is some error
                    throw "Could not launch ${snapshot.data.data[index].url}";
                },
                child: Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          "http://fclkw.com/storage/app/public/${snapshot.data.data[index].image}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }),

            //Slider Container properties
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          );
        } else {
          return emptyWidget;
        }
      },
    );
  }
}
