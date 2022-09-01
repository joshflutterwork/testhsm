import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:testhashm/features/home/bloc/location_bloc.dart';
import 'package:testhashm/features/home/widget/button_style.dart';
import 'package:testhashm/features/home/widget/dialog_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? position;
  LocationBloc locationBloc = LocationBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getPosition() async {
    print(position);
    locationBloc.add(GetAbsenLocation());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocConsumer<LocationBloc, LocationState>(
        bloc: locationBloc,
        listener: (context, state) {
          if (state is LocationInitial) {
            getLoading(context);
          }
          // TODO: implement listener
          if (state is AbsenSuccess) {
            Navigator.pop(context);
            print(state.success);
            getDialogSuccess(context, state.success, true);
            Future.delayed(Duration(seconds: 3)).then((value) {
              Navigator.pop(context);
            });
          }
          if (state is AbsenError) {
            Navigator.pop(context);
            getDialogSuccess(context, state.error, false);

            Future.delayed(Duration(seconds: 3)).then((value) {
              Navigator.pop(context);
            });
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 100,
                    height: 100,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 50,
                      ),
                      Text(
                        "Hashmicro office location",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Latitude",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "-6.1762882",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Longtitude",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "106.8171201",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: button(context, onTap: () {
                  getPosition();
                }, text: 'Absen'),
              )
            ],
          );
        },
      )),
    );
  }
}
