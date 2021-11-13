import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras/Controllers/Loading.dart';
import 'package:meras/screen/Admin/widget/BackgroundA.dart';
import 'package:meras/screen/Trainee/TRpages/BackgroundLo22.dart';
import 'package:meras/screen/home/navDrawer.dart';
import 'BackgroundLo2.dart';

import 'DraftF.dart';

class TRexplore2Screen extends StatefulWidget {
  @override
  _TRexplore2ScreenState createState() => _TRexplore2ScreenState();
}

class _TRexplore2ScreenState extends State<TRexplore2Screen> {
  //final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Awesome appbar'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list),
            onSelected: (String result) {
              switch (result) {
                case 'filter1':
                  print('filter 1 clicked');
                  break;
                case 'filter2':
                  print('filter 2 clicked');
                  break;
                case 'clearFilters':
                  print('Clear filters');
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'filter1',
                child: Text('Filter 1'),
              ),
              const PopupMenuItem<String>(
                value: 'filter2',
                child: Text('Filter 2'),
              ),
              const PopupMenuItem<String>(
                value: 'clearFilters',
                child: Text('Clear filters'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
