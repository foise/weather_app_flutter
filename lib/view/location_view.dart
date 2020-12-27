import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocationView extends StatelessWidget {
  final double longitude;
  final double latitude;
  final String city;
  final DateTime date;

  LocationView(
      {Key key,
      @required this.longitude,
      @required this.latitude,
      @required this.city,
      @required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat formated = DateFormat("MMMM d, HH:m");
    String convertedDate = formated.format(date);
    return Center(
      child: Column(
        children: [
          Text('${city.toUpperCase()}',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: Colors.white, size: 15),
              SizedBox(width: 10),
              Text(this.longitude.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  )),
              Text(' , ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  )),
              Text(this.latitude.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  )),
            ],
          ),
          SizedBox(height: 10),
          Text(
            convertedDate,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
