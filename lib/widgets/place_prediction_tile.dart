import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/assistants/request_assistant.dart';
import 'package:untitled/global/map_key.dart';
import 'package:untitled/infoHandler/app_info.dart';
import 'package:untitled/models/directions.dart';
import 'package:untitled/models/predicted_places.dart';
import 'package:untitled/widgets/progress_dialog.dart';


class PlacePredictionTileDesign extends StatelessWidget
{
  final PredictedPlaces? predictedPlaces;

  PlacePredictionTileDesign({this.predictedPlaces});

  getPlaceDirectionDetails(String? placeId, context) async
  {
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        message: "Setting up drop-off please wait...",
      ),
    );
    String placeDirectionDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$andKey";

    var responseApi = await RequestAssistant.recieveRequest(placeDirectionDetailsUrl);

    Navigator.pop(context);

    if (responseApi == "Error Occured, Failed. No Response")
      {
        return;
      }

    if(responseApi["status"]=="OK")
      {
        Directions directions = Directions();
        directions.locationName = responseApi ["result"]["name"];
        directions.locationId = placeId;
        directions.locationLatitude = responseApi["result"]["geometry"]["location"]["lat"];
        directions.locationLongitude = responseApi["result"]["geometry"]["location"]["lng"];

        Provider.of<AppInfo>(context, listen: false).updateDropOffLocationAddress(directions);

        Navigator.pop(context, "obtainedDropoff");

      }
  }

  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
      onPressed: ()
      {
        getPlaceDirectionDetails(predictedPlaces!.place_id,context);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white24,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            const Icon(
              Icons.add_location,
              color: Colors.grey,
            ),
            const SizedBox(width: 14.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0,),
                  Text(
                    predictedPlaces!.main_text!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 2.0,),
                  Text(
                    predictedPlaces!.secondary_text!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
