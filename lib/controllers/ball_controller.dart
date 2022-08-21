// import 'package:quantt/services/remote_services.dart';

// import '../models/ball.dart';

// class BallController {
//   // Future<List<Ball>> getSets() async {
//   //   var response = await HTTPRequest.get("/sets");
//   //   // print(" the resonse is actuall: ${response['datat']}");
//   //   // return baFromRequestBody(response["data"]);
//   // }

//   Future<Ball> addBall(){

//     Map<String, String> body = {
//       "uid": uid.toString(),
//       "merchant_id": itemModel.details?.merchantId.toString() ?? "",
//       "item_id": homeController.itemId.value.toString(),
//       "price": itemModel.details?.prices?[groupValue.value].price,
//       "size_words": itemModel.details?.prices?[groupValue.value].size,
//       "size": groupValue.value.toString(),
//       "qty": quantity.value.toString(),
//       "notes": instruction.value.toString(),
//     }
//         // var response = await HTTPRequest.post("/balls");
//        final response = await HTTPRequest.post("/balls", body: {
// 	 	    "point_id" : body.winner
// "winner"
// "spin"
// "from"
// "to"
// "stroke_type"
// "is_service"
// "player_id"
// "updated_at"
// "created_at"
// "id"
//  });
//   }
// }
