import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsi/models/meal_detailed_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Detailedpage extends StatefulWidget {
  final String? id;
  const Detailedpage({Key? key, required this.id}) : super(key: key);
  @override
  State<Detailedpage> createState() => _DetailedpageState();
}

class _DetailedpageState extends State<Detailedpage> {
  final meals = MealsDetailed();
  Future<List<MealsDetailed>>? mealResults;
  @override
  void initState() {
    mealResults = MealsDetailed.fetchMeals(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsi - Detailed Page'),
      ),
      body: Center(
        child: FutureBuilder(
          future: mealResults,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(5),
                    child: buildCard(
                      snapshot.data?[index].strMeal,
                      snapshot.data?[index].strMealThumb,
                      snapshot.data?[index].strInstructions,
                      snapshot.data?[index].strYoutube,
                      snapshot.data?[index].strCategory,
                      snapshot.data?[index].strArea,
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

  Widget buildCard(String? title, String? image, String? details, String? url,
          String? category, String? area) =>
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: () {
              Uri query = Uri.parse(url ?? "No Data");
              _launch(query);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(2),
                      height: 200,
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
                      category ?? "No title",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      area ?? "No title",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      details ?? "no details",
                      style: const TextStyle(
                        fontSize: 14.0,
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
      );

  Future<void> _launch(Uri url) async {
    String concatenate = url.origin + url.path;
    Uri finalURL = Uri.parse(concatenate);
    try {
      if (await canLaunchUrl(finalURL)) {
        await launchUrl(finalURL);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (kDebugMode) {
        print("error");
      }
    }
  }
}
