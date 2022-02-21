import 'package:flutter/material.dart';
import 'package:pk_wallets/consts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color_blue,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 1),
          Flexible(
            child: RawMaterialButton(
              onPressed: () {},
              elevation: 2.0,
              fillColor: const Color(0xFFF5F6F9),
              child: Icon(
                Icons.person,
                color: color_blue,
                size: 40,
              ),
              shape: const CircleBorder(),
            ),
            flex: 1,
          ),
          Flexible(
            child: Image.asset(
              "assets/images/pkwallets.png",
            ),
            flex: 2,
          ),
          const Flexible(
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: 35,
            ),
            flex: 1,
          ),
          const SizedBox(width: 1),
        ],
      ),

    );

  }
}

// class AppbarWidget extends StatelessWidget {
//   const AppbarWidget();
//
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return PreferredSize(
//         preferredSize: const Size.fromHeight(100.0),
//         child:Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const SizedBox(width: 1),
//             Flexible(
//               child: RawMaterialButton(
//                 onPressed: () {},
//                 elevation: 2.0,
//                 fillColor: const Color(0xFFF5F6F9),
//                 child: Icon(
//                   Icons.person,
//                   color: color_blue,
//                   size: 40,
//                 ),
//                 shape: const CircleBorder(),
//               ),
//               flex: 1,
//             ),
//             Flexible(
//               child: Image.asset(
//                 "assets/images/pkwallets.png",
//               ),
//               flex: 2,
//             ),
//             const Flexible(
//               child: Icon(
//                 Icons.settings,
//                 color: Colors.white,
//                 size: 35,
//               ),
//               flex: 1,
//             ),
//             const SizedBox(width: 1),
//           ],
//         ),
//
//     );
//   }
// }