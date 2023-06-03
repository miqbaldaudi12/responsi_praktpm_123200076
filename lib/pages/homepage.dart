// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsi/models/free_meal_model.dart';
import 'package:responsi/pages/detailspage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  final categories = Categories();
  Future<List<Categories>>? categoriesResults;

  @override
  void initState() {
    categoriesResults = Categories.fetchCategories(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsi - Homepage'),
      ),
      body: Center(
        child: FutureBuilder(
          future: categoriesResults,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(5),
                    child: buildCard(
                      snapshot.data?[index].strCategory,
                      snapshot.data?[index].strCategoryThumb,
                      snapshot.data?[index].strCategoryDescription,
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('error : ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildCard(String? title, String? image, String? competition) =>
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detailspage(id: title),
                  ),
                );
              },
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(2),
                        height: 120,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(image ??
                                "https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        title ?? "No title",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        competition ?? "no competititon",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
