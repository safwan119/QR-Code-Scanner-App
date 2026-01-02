import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../image/image_path.dart';

class HistoryShimmer extends StatelessWidget {
  const HistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount:10,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.white12,
          highlightColor: Colors.grey.shade100,
          child: Container(
            child: Row(
              children: [
                Image.asset(
                  AppImages.qrCodeDataImage,
                  color: Colors.white,
                ),
                SizedBox(width: 7),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 120,
                      color: Colors.white,
                    ),
                    SizedBox(height: 7),
                    Container(
                      height: 20,
                      width: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder:
          (BuildContext context, int index) {
        return SizedBox(height: 10);
      },
    );
  }
}