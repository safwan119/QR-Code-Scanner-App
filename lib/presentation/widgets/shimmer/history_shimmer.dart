import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:shimmer/shimmer.dart';

import '../image/image_path.dart';

class HistoryShimmer extends StatelessWidget {
  const HistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.all(4.0),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.white12,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Container(
              child: Row(
                children: [
                  Image.asset(AppImages.qrCodeDataImage, color: Colors.white),
                  SizedBox(width: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: AppSize.h1,
                        width: AppSize.getWidth(50.0),
                        color: Colors.white,
                      ),
                      SizedBox(height: 7),
                      Container(
                        height: AppSize.h1,
                        width: AppSize.w5,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.delete, color: Colors.white),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: AppSize.h2);
      },
    );
  }
}
