import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/presentation/widgets/history/history_look.dart';
import 'package:qr_code_scanner/presentation/widgets/shimmer/history_shimmer.dart';
import 'package:qr_code_scanner/presentation/widgets/tab/history_tab.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

import '../SharedPreference/user_id_services.dart';

class QrCodeHistory extends StatefulWidget {
  const QrCodeHistory({super.key});

  @override
  State<QrCodeHistory> createState() => _QrCodeHistoryState();
}

class _QrCodeHistoryState extends State<QrCodeHistory> {
  final databaseReference = FirebaseDatabase.instance.ref("ScannedData");
  late final Future<String?> deviceIdFuture;
  final firebaseDatabaseReference = FirebaseDatabase.instance.ref(
    "CreateQrCode",
  );

  @override
  void initState() {
    super.initState();
    deviceIdFuture = getDeviceId();
  }

  Future<String> getDeviceId() async {
    return await PrefUtils.getOrCreateUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(height: AppSize.h7),
            Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("History", style: textStyle(fontSize: 30)),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          RoutesName.settingScreen,
                        ),

                        child: Icon(
                          Icons.settings,
                          color: Colors.amber.shade700,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: AppSize.h3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                child: HistoryTab(),
              ),
            ),
            SizedBox(height: AppSize.h1),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder(
                    future: deviceIdFuture,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      final String deviceId = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: StreamBuilder(
                          stream: databaseReference.child(deviceId).onValue,
                          builder:
                              (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return HistoryShimmer();
                                }
                                if (!snapshot.hasData &&
                                    snapshot.data!.snapshot.children.isEmpty) {
                                  return Center(
                                    child: Text(
                                      "No data available",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }
                                final data =
                                    snapshot.data!.snapshot.value
                                        as Map<dynamic, dynamic>?;
                                if (data == null) {
                                  return const Center(
                                    child: Text(
                                      "No data available",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }
                                final List list = data.values.toList();
                                return ListView.builder(
                                  itemCount: list.length,

                                  physics: BouncingScrollPhysics(),
                                  primary: false,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(4.0),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          RoutesName.resultScreen,
                                          arguments:
                                              list[index]["scanResult"] ?? " ",
                                        );
                                      },
                                      child: HistoryLook(
                                        dateTime: list[index]["dateTime"] ?? '',
                                        scanResult:
                                            list[index]["scanResult"] ?? '',
                                        onDeleteIconClick: () async {
                                          await databaseReference
                                              .child(deviceId)
                                              .child(list[index]["id"])
                                              .remove();
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                        ),
                      );
                    },
                  ),
                  FutureBuilder(
                    future: deviceIdFuture,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      final String deviceId = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: StreamBuilder(
                          stream: firebaseDatabaseReference
                              .child(deviceId)
                              .onValue,
                          builder:
                              (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return ListView.separated(
                                    itemCount: 4,
                                    primary: false,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(4.0),
                                    itemBuilder: (context, index) {
                                      return HistoryShimmer();
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                          return SizedBox(height: 10);
                                        },
                                  );
                                }
                                if (!snapshot.hasData &&
                                    snapshot.data!.snapshot.children.isEmpty) {
                                  return Center(
                                    child: Text(
                                      "No data available",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }
                                final data =
                                    snapshot.data!.snapshot.value
                                        as Map<dynamic, dynamic>?;
                                if (data == null) {
                                  return const Center(
                                    child: Text(
                                      "No data available",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }
                                final List list = data.values.toList();
                                return ListView.builder(
                                  itemCount: list.length,
                                  primary: false,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(4.0),
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          RoutesName.qrCodeScreen,
                                          arguments:
                                              list[index]["scanResult"] ?? " ",
                                        );
                                      },
                                      child: HistoryLook(
                                        dateTime: list[index]["dateTime"] ?? '',
                                        scanResult:
                                            list[index]["scanResult"] ?? '',
                                        onDeleteIconClick: () async {
                                          await firebaseDatabaseReference
                                              .child(deviceId)
                                              .child(list[index]["id"])
                                              .remove();
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
