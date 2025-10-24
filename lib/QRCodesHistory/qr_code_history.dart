import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/Result/QRCodeData/q_r_code.dart';
import 'package:qr_code_scanner/Result/qr_code_result.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/route/routes_name.dart';
import 'package:shimmer/shimmer.dart';


import '../SharedPreference/user_id_services.dart';

class QrCodeHistory extends StatefulWidget {
  const QrCodeHistory({super.key});

  @override
  State<QrCodeHistory> createState() => _QrCodeHistoryState();
}

class _QrCodeHistoryState extends State<QrCodeHistory>{
  final databaseReference=FirebaseDatabase.instance.ref("ScannedData");
    late final Future<String?> deviceIdFuture;
  final firebaseDatabaseReference=FirebaseDatabase.instance.ref("CreateQrCode");
  @override
  void initState() {
    super.initState();
    deviceIdFuture=getDeviceId();
  }
  Future<String> getDeviceId() async {
    final userIdService = UserIdServices();
    return await userIdService.getOrCreateUserId();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .07),
            Builder(
              builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "History",
                      style: textStyle(fontSize: 30),
                    ),
                    InkWell(onTap: ()=>Navigator.pushNamed(context, RoutesName.settingScreen),
                        child: Icon(Icons.settings,color: Colors.amber.shade700,)),
                  ],
                );
              }
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.amber.shade600,
                  ),
                  dividerColor: Colors.black12,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.all(8.0),
                  tabs: [
                    Tab(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Scan",
                          style: textStyle(fontSize: 22)
                        ),
                      ),
                    ),
                    Tab(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Create",
                          style: textStyle(fontSize: 22)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .01),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder(future: deviceIdFuture, builder: (context,snapshot){
                if (!snapshot.hasData) {
                  return  Container();
                }
                    final String deviceId = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: StreamBuilder(stream: databaseReference.child(deviceId).onValue,
                          builder:(context,AsyncSnapshot<DatabaseEvent>snapshot){
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return ListView.separated(itemCount: 4,primary: false,
                                shrinkWrap: true,
                                itemBuilder: (context,index) {
                                  return Shimmer.fromColors(baseColor: Colors.white12,
                                      highlightColor: Colors.grey.shade100,
                                      child: Card(
                                        child: ListTile(
                                          leading: Container(
                                            height: 30,
                                            width: 30,
                                            color: Colors.white12,
                                          ),
                                          title: Container(
                                            height: 15,
                                            color: Colors.white12,
                                          ),
                                          subtitle: Container(
                                            height: 15,
                                            color: Colors.white12,
                                          ),
                                          trailing:Container(
                                            height: 10,
                                            width: 5,
                                            color: Colors.white12,
                                          ),
                                        ),
                                      ));
                                }, separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 10,
                                );
                                },
                              );
                            }
                            if(!snapshot.hasData && snapshot.data!.snapshot.children.isEmpty){
                              return Center(
                                child: Text("No data available",style: TextStyle(color: Colors.white),),
                              );
                            }
                            final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
                            if (data == null) {
                              return const Center(child: Text("No data available", style: TextStyle(color: Colors.white)));
                            }
                            final List list=data.values.toList();
                            return ListView.builder(itemCount: list.length,primary: false,
                                shrinkWrap: true,
                              itemBuilder: (context,index) {
                                return InkWell(onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QrCodeResult(list[index]["scanResult"]??" ")));
                                },
                                  child: Card(
                                    elevation: 4,
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Image.asset("assets/images/QRCodeDataPic.png"),
                                        SizedBox(width: 15),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      list[index]["scanResult"]??'',
                                                      style:textStyle(fontSize: 18)
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                      right: 10,
                                                    ),
                                                    child: InkWell(onTap: () async {
                                                      await databaseReference.child(deviceId).child(list[index]["id"]).remove();
                                                    },
                                                      child: Image.asset(
                                                        "assets/images/DeleteButtonPic.png",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Data",
                                                    style:textStyle(fontSize: 14)
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                      right: 10,
                                                    ),
                                                    child: Text(
                                                      list[index]["dateTime"]??'',
                                                      style:textStyle(fontSize: 14)
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            );
                          }),
                    );
                  }),
                  FutureBuilder(future: deviceIdFuture, builder: (context,snapshot){
                    if(!snapshot.hasData){
                      return Container();
                    }
                    final String deviceId = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: StreamBuilder(stream: firebaseDatabaseReference.child(deviceId).onValue,
                          builder:(context,AsyncSnapshot<DatabaseEvent>snapshot){
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return ListView.separated(itemCount: 4,primary: false,
                                shrinkWrap: true,
                                itemBuilder: (context,index) {
                                  return Shimmer.fromColors(baseColor: Colors.white12,
                                      highlightColor: Colors.grey.shade100,
                                      child: Card(
                                        child: ListTile(
                                          leading: Container(
                                            height: 30,
                                            width: 30,
                                            color: Colors.white12,
                                          ),
                                          title: Container(
                                            height: 15,
                                            color: Colors.white12,
                                          ),
                                          subtitle: Container(
                                            height: 15,
                                            color: Colors.white12,
                                          ),
                                          trailing:Container(
                                            height: 10,
                                            width: 5,
                                            color: Colors.white12,
                                          ),
                                        ),
                                      ));
                                }, separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 10,
                                  );
                                },
                              );
                            }
                            if(!snapshot.hasData && snapshot.data!.snapshot.children.isEmpty){
                              return Center(
                                child: Text("No data available",style: TextStyle(color: Colors.white),),
                              );
                            }
                            final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
                            if (data == null) {
                              return const Center(child: Text("No data available", style: TextStyle(color: Colors.white)));
                            }
                            final List list=data.values.toList();
                            return ListView.builder(itemCount: list.length,primary: false,
                                shrinkWrap: true,
                                itemBuilder: (context,index) {
                                  return InkWell(onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCode(list[index]["scanResult"]??" ")));
                                  },
                                    child: Card(
                                      elevation: 4,
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 10),
                                          Image.asset("assets/images/QRCodeDataPic.png"),
                                          SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        list[index]["scanResult"]??'',

                                                        style:textStyle(fontSize: 18)
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                        right: 10,
                                                      ),
                                                      child: InkWell(onTap: () async {
                                                        await firebaseDatabaseReference.child(deviceId).child(list[index]["id"]).remove();
                                                      },
                                                        child: Image.asset(
                                                          "assets/images/DeleteButtonPic.png",
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Data",
                                                      style:textStyle(fontSize: 14)
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                        right: 10,
                                                      ),
                                                      child: Text(
                                                        list[index]["dateTime"]??'',
                                                        style:textStyle(fontSize: 14)
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );
                          }),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
