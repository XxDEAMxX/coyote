import 'package:coyote/routes/app_router.dart';
import 'package:coyote/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

class SsBottomAppBar extends StatelessWidget {
  const SsBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    appRouter.push(const HomeRoute());
                  },
                  child: const Icon(
                    Icons.home,
                    size: 40,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.add,
                    size: 40,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
