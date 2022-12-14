import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/model/utils/requests_model.dart';
import 'package:uni/view/Pages/facility_page_view.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'general_page_view.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:uni/model/entities/facility.dart';
import 'package:uni/view/theme.dart';
import 'package:uni/view/theme_notifier.dart';
import 'form_page_view.dart';

//void main() => runApp(const MyApp());
/*
class FeupQ extends StatelessWidget {
  const FeupQ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FEUPQ',
      home: const HomeView(),
    );
  }
  //HomeView();
}*/
// Filter makes it so the Widget is Stateful
class FeupQ extends StatefulWidget {
  final String authToken;
  const FeupQ({Key key, this.authToken}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends SecondaryPageViewState {
  final List<Facility> __facility = getFacilitiesList();
  List<Facility> facility;
  @override
  void initState() {
    super.initState();
    facility = __facility;
  }

  // var nearestFacility = getNearestFacility();
  // facility.remove(nearestFacility);
  // facility.insert(0, nearestFacility);

  //TORNAR SEARCH Scrollable
  @override
  Widget build(BuildContext context) {
    return getScaffold(
        context,
        ListView(children: [
          FutureBuilder<Facility>(
              future: getNearestFacility(facility),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    Text("Fila mais perto:",
                        style: const TextStyle(height: 3, fontSize: 20)),
                    Card(
                      child: ListTile(
                          title: Text(snapshot.data.name),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FacilityView(
                                      facility: facility[snapshot.data.id],
                                    )));
                          }),
                    )
                  ]);
                } else {
                  return Text("N??o h?? fila mais proxima",
                      style: const TextStyle(height: 3, fontSize: 20),textAlign: TextAlign.center);
                }
              }),
          Text("Todas as Filas: ",
              style: const TextStyle(height: 3, fontSize: 20),textAlign: TextAlign.center),
          IconButton(
            key: const ValueKey('searchIcon'),
            icon: Icon(Icons.search, color: Colors.black87),

            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
          ),
          /*Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextField(
          key: const ValueKey("searchBar"),
          onChanged: (text) {
            setState(() {
              if (text == "") {
                facility = __facility;
              } else {
                facility = __facility
                    .where((facility) => facility.name
                    .toLowerCase()
                    .contains(text.toLowerCase()))
                    .toList();
              }
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Barra de Pesquisa',
          ),
        ),
      ),*/
          ListView.builder(
            key: ValueKey("Lista1"),
            itemCount: facility.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                    title: Text(facility[index].name),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FacilityView(
                                facility: facility[index],
                              )));
                    }),
              );
            },
            shrinkWrap: true,
          ),
        ]));
  }
}

class MySearchDelegate extends SearchDelegate {
  List<Facility> facilities = getFacilitiesList();
  //MySearchDelegate({this.queues})
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
      close(context,query);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Facility> allLocations = facilities
        .where((facility) =>
            facility.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      key: ValueKey("Lista1"),
      itemCount: allLocations.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
              title: Text(allLocations[index].name),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FacilityView(
                      facility: allLocations[index],
                    )));
              }),
        );
      },
      shrinkWrap: true,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Facility> allLocations = facilities
        .where((facility) =>
        facility.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      key: ValueKey("Lista1"),
      itemCount: allLocations.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
              title: Text(allLocations[index].name),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FacilityView(
                      facility: allLocations[index],
                    )));
              }),
        );
      },
      shrinkWrap: true,
    );
  }
}
