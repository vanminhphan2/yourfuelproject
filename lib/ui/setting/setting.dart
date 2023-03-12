import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yourfuel/models/fuel_station.dart';
import 'package:yourfuel/provider/main_provider.dart';
import 'package:yourfuel/ui/setting/setting_bloc.dart';
import 'package:yourfuel/utils/app_utils.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final SettingBloc _bloc = SettingBloc();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc.getData();
    });
    // yourStations.add(FuelStation(
    //     type: 2,
    //     numberStation: 1,
    //     fullTypeName: "Diesel 01",
    //     typeName: "DO 01"));
    // yourStations.add(FuelStation(
    //     type: 2,
    //     numberStation: 2,
    //     fullTypeName: "Diesel 01",
    //     typeName: "DO 01"));
    // yourStations.add(FuelStation(
    //     type: 5,
    //     numberStation: 1,
    //     fullTypeName: "Gasoline A95",
    //     typeName: "A95"));

    // _bloc.stations.add(
    //     FuelStation(type: 2, fullTypeName: "Diesel 01", typeName: "DO 01"));
    // _bloc.stations.add(
    //     FuelStation(type: 3, fullTypeName: "Diesel 05", typeName: "DO 05"));
    // _bloc.stations.add(
    //     FuelStation(type: 4, fullTypeName: "Gasoline A92", typeName: "A92"));
    // _bloc.stations.add(
    //     FuelStation(type: 5, fullTypeName: "Gasoline A95", typeName: "A95"));
    // _bloc.stations
    //     .add(FuelStation(type: 6, fullTypeName: "Gasoline E5", typeName: "E5"));

    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLightPurple,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Setting"),
        backgroundColor: AppColors.primaryColor,
        actions: [
          StreamBuilder<bool>(
            stream: _bloc.onVisibleIconToHome.stream,
            initialData: false,
            builder: (context, snapshot) {
              return Visibility(
                visible: snapshot.data!,
                child: TextButton(onPressed: (){
                  context.read<MainProvider>().setHasBeenSet=true;
                }, child: const Icon(Icons.home)),
              );
            }
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<bool>(
            stream: _bloc.onGetData.stream,
            initialData: false,
            builder: (context, snapshot) {
              return (snapshot.data!)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Trụ xăng dầu của bạn:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        Card(
                          elevation: 5,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StreamBuilder<List<FuelStation>>(
                                  stream: _bloc.onYourFuelStationChange.stream,
                                  initialData: _bloc.yourStations,
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null &&
                                        snapshot.data!.isNotEmpty) {
                                      snapshot.data!.sort(
                                          (a, b) => a.type.compareTo(b.type));
                                    }
                                    return (snapshot.data == null ||
                                            snapshot.data!.isEmpty)
                                        ? Container(
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            child: const Text(
                                                "Bạn chưa có trụ nào!"),
                                          )
                                        : Column(children: [
                                            for (int i = 0;
                                                i < snapshot.data!.length;
                                                i++)
                                              YourFuelStationItem(
                                                item: snapshot.data![i],
                                                onRemoveCallback: () =>
                                                    _bloc.removeStation(i),
                                              ),
                                          ]);
                                  })),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Thêm trụ xăng dầu:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        Card(
                          elevation: 5,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StreamBuilder<List<FuelStation>>(
                                  stream: _bloc.onStationsChange.stream,
                                  initialData: _bloc.stations,
                                  builder: (context, snapshot) {
                                    return Column(children: [
                                      for (int i = 0;
                                          i < snapshot.data!.length;
                                          i++)
                                        FuelStationItem(
                                          itemData: snapshot.data![i],
                                          callback: (value) {
                                            print(value.toString());
                                            _bloc.stations[i].totalStation =
                                                value;
                                          },
                                        ),
                                    ]);
                                  })),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => _bloc.addFuelStations(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient: const LinearGradient(
                                        colors: [
                                          AppColors.primaryColor,
                                          AppColors.primaryColorDark
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight)),
                                child: const Text(
                                  "Add Fuel Station",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container();
            }),
      ),
    );
  }
}

String getIcon(int type) {
  if (type <= 4) {
    return "assets/icons/icon_oil_station.svg";
  } else {
    return "assets/icons/icon_gasoline_station.svg";
  }
}

class YourFuelStationItem extends StatelessWidget {
  const YourFuelStationItem(
      {Key? key, required this.item, required this.onRemoveCallback})
      : super(key: key);

  final FuelStation item;
  final VoidCallback onRemoveCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(getIcon(item.type))),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            item.fullTypeName + " Station " + item.numberStation.toString(),
            style: const TextStyle(fontSize: 15, color: AppColors.black),
          ),
        ),
        InkWell(
          onTap: () => onRemoveCallback(),
          child: const Icon(
            Icons.highlight_remove,
            color: Colors.red,
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}

class FuelStationItem extends StatefulWidget {
  FuelStationItem({Key? key, required this.itemData, required this.callback})
      : super(key: key);

  final FuelStation itemData;
  final Function(int) callback;

  @override
  _FuelStationItemState createState() => _FuelStationItemState();
}

class _FuelStationItemState extends State<FuelStationItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(getIcon(widget.itemData.type))),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            widget.itemData.fullTypeName,
            style: const TextStyle(fontSize: 15, color: AppColors.black),
          ),
        ),
        InkWell(
          onTap: () => setState(() {
            if (widget.itemData.totalStation > 0) {
              widget.itemData.totalStation--;
              widget.callback(widget.itemData.totalStation);
            }
          }),
          child: const Icon(
            Icons.remove,
            color: Colors.red,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(widget.itemData.totalStation.toString()),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () => setState(() {
            widget.itemData.totalStation++;
            widget.callback(widget.itemData.totalStation);
          }),
          child: const Icon(
            Icons.add,
            color: Colors.red,
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
