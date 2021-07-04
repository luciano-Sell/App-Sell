import 'package:flutter/material.dart';
import 'package:sell/providers/greate_places.dart';
import 'package:sell/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus produtos'),
        actions:<Widget>[
          IconButton(
            icon: Icon(Icons.add),
             onPressed: (){
               Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
             },
          )
        ]
      ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? Center (child: CircularProgressIndicator())
          : Consumer<GreatPlaces>(
            child:Center(
              child: Text('Sem produtos cadastrados'),
              ), 
              builder: (ctx, greatPlaces,ch) => greatPlaces.itemsCount == 0 
              ? ch : ListView.builder(
                itemCount: greatPlaces.itemsCount, 
                itemBuilder:  (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                      greatPlaces.itemByIndex(i).image
                    ),
                  ),
                  title: Text(greatPlaces.itemByIndex(i).title),
                  onTap: () {},
                ),
                ),
          ),
        ),
    );
  }
}