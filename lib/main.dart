
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

//import 'screens/place_form_screen.dart';
import 'package:sell/screens/places_list_screen.dart';
import 'providers/greate_places.dart';
import 'screens/place_form_screen.dart';
import 'utils/app_routes.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  
  @override 
  Widget build(BuildContext context) {
   return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(       
          primarySwatch: Colors.amber,
          accentColor: Colors.black87,
        ),
        home: MyHomePage(),
        routes: {
          AppRoutes.PLACE_LIST: (ctx) => PlaceListScreen(),
          AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
        },
      ),
    );


   
  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  LatLng _initialcameraposition = LatLng(0, 0);
  GoogleMapController _controller;
  Location _location = Location();
  bool isReadonly;
  
   _onMapCreated(GoogleMapController _cntlr)
  {

    _controller = _cntlr;
    _location.onLocationChanged.listen((l) { 
      this.isReadonly = false;
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 17),
          
          ), 
             
      );
      
      
    } 
        
    );
           
  }
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        //height: MediaQuery.of(context).size.height,
        //width: MediaQuery.of(context).size.width,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        
        
        
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        //backgroundColor: const Color
        //mini: true,
        onPressed: (){
          Navigator.of(context).pushNamed(AppRoutes.PLACE_LIST);
        },
             
        label: Text('Produtos'),
        icon: Icon(Icons.star_rate),
        

        
      ),
    );
    
  } 
  
}