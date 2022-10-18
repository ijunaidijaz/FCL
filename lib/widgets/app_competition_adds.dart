import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fcl/core/datamodels/competition_adds_datamodel.dart';
import 'package:fcl/core/viewmodels/competitionList_viewmodel.dart';
import 'package:fcl/core/viewmodels/generalAdds_viewmodel.dart';

import 'package:fcl/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CompetitionAdssWidget extends StatefulWidget {
  const CompetitionAdssWidget({Key key}) : super(key: key);

  @override
  _CompetitionAdssWidgetState createState() => _CompetitionAdssWidgetState();
}

class _CompetitionAdssWidgetState extends State<CompetitionAdssWidget> {
  Timer timer;
  @override
  void dispose() {
    print("============disposing page=======================");
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final generalAddsViewModel = Provider.of<GeneralAddsViewModel>(context);
    final compeitionListViewModel =
        Provider.of<CompetitionListViewModel>(context);
    return FutureBuilder<CompetitionAddsDatamodel>(
      future: compeitionListViewModel.getCompetitionAddsData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null || !snapshot.hasData) {
            return emptyWidget;
          }
          return snapshot.data.data.length > 0
              ? CarouselSlider(
                  items: List.generate(snapshot.data.data[0].pictures.length,
                      (index) {
                    generalAddsViewModel.validateAndSubmitGeneralAddsStat(
                      isGeneralAdd: false,
                      wasClicked: false,
                      generalAddId: snapshot.data.data[0].id,
                    );
                    return InkWell(
                      onTap: () async {
                        if (await canLaunch(snapshot.data.data[0].url)) {
                          await generalAddsViewModel
                              .validateAndSubmitGeneralAddsStat(
                            isGeneralAdd: false,
                            wasClicked: true,
                            generalAddId: snapshot.data.data[0].id,
                          );
                          await launch(snapshot.data.data[0].url);
                        } else
                          // can't launch url, there is some error
                          throw "Could not launch ${snapshot.data.data[0].url}";
                      },
                      child: Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(
                                "http://fclkw.com/storage/app/public/${snapshot.data.data[0].pictures[index]}"),
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
                )
              : emptyWidget;
        } else {
          return emptyWidget;
        }
      },
    );
  }
}
