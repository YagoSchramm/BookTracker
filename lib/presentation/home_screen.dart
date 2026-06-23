import 'package:book_tracker/presentation/components/book_card.dart';
import 'package:book_tracker/presentation/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "BookTracker",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  CupertinoIcons.book_fill,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Positioned(
                  right: -4,
                  bottom: -1,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.add,
                      size: 10,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<HomeState>(
        builder: (context, state, child) {
          if (state.isLoading == false) {
            return Column(
              children: [
                SizedBox(height: 15),
                Row(
                  children: [
                         SizedBox(width: 12),
                    Text("Hello, ${state.name}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                   SizedBox(height: 8,),
                 Row(
                  children: [
                         SizedBox(width: 12),
                    Text("Your books:",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),),
                  ],
                ),
                SizedBox(height: 8,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: BookTile(
                          title: "Clean Code",
                          lastPageRead: 120,
                          totalPages: 464,
                          onTap: () {},
                        ),
                      ),
                         Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: BookTile(
                          title: "Clean Code",
                          lastPageRead: 120,
                          totalPages: 464,
                          onTap: () {},
                        ),
                      ),
                           Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: BookTile(
                          title: "Clean Code",
                          lastPageRead: 120,
                          totalPages: 464,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return (Center(child: Text("NENHUMA INFORMACAO")));
        },
      ),
    );
  }
}
