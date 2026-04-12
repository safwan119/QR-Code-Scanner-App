import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/app_size.dart';

import '../../../constants/text_style.dart';
import '../image/image_path.dart';

class HistoryLook extends StatelessWidget {
  final String scanResult;
  final VoidCallback onDeleteIconClick;
  final String dateTime;

  const HistoryLook({
    super.key,
    required this.dateTime,
    required this.scanResult,
    required this.onDeleteIconClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          SizedBox(width: AppSize.h1),
          Image.asset(AppImages.qrCodeDataImage),
          SizedBox(width: AppSize.getHeight(1.5)),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: AppSize.h1),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        scanResult,
                        style: textStyle(fontSize: 18),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: onDeleteIconClick,
                        child: Image.asset(AppImages.deleteButtonImage),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Data", style: textStyle(fontSize: 14)),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(dateTime, style: textStyle(fontSize: 14)),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.h1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
