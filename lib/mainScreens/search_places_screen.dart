import 'package:flutter/material.dart';
import 'package:untitled/assistants/request_assistant.dart';
import 'package:untitled/global/map_key.dart';
import 'package:untitled/models/predicted_places.dart';
import 'package:untitled/widgets/place_prediction_tile.dart';

class SearchPlacesScreen extends StatefulWidget
{

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen>
{
  List<PredictedPlaces> placesPredictedList =[];

  void findPLaceAutoCompleteSearch(String inputText) async
  {
    if(inputText.length > 1)
      {
        String urlAutoCompleteSearch = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$andKey&components=country:US";

        var responseAutoCompleteSearch = await RequestAssistant.recieveRequest(urlAutoCompleteSearch);

        if(responseAutoCompleteSearch == "Error occured, Failed. No Response.")
          {
            return;
          }
        if(responseAutoCompleteSearch["status"]=="OK")
          {
            var placePredictions = responseAutoCompleteSearch["predictions"];

            var placePredictionsList = (placePredictions as List).map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();


            setState(() {
              placesPredictedList= placePredictionsList;
            });
          }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //search places ui
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Colors.black54,
              boxShadow:
                [
                  BoxShadow(
                    color: Colors.white54,
                    blurRadius: 8,
                    spreadRadius: 0.5,
                    offset: Offset(
                      0.7,
                      0.7,
                    )
                  )
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [

                  const SizedBox(height: 25.0,),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap:()
                        {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),

                      const Center(
                        child: Text(
                          "Search & Set DropOff Location",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16.0),

                  Row(
                    children: [
                      Icon(
                        Icons.adjust_sharp,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 18,),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (valueTyped)
                            {
                              findPLaceAutoCompleteSearch(valueTyped);
                            },
                          decoration: const InputDecoration(
                            hintText: "search here...",
                            fillColor: Colors.white54,
                            filled: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 11.0,
                              top: 8.0,
                              bottom: 8.0,
                          ),
                       ),
                      ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          //display place predictions result
         (placesPredictedList.length > 0)
              ? Expanded(
            child: ListView.separated(
              itemCount: placesPredictedList.length,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index)
              {
                return PlacePredictionTileDesign(
                  predictedPlaces: placesPredictedList [index],
                );
              },
              separatorBuilder: (BuildContext context, int index)
              {
                return const Divider(
                  height: 1,
                  color: Colors.grey,
                  thickness: 1,
                );
              },
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}
