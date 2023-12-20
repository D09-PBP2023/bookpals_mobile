// // NOTE: BELOM SELESAI
// import 'package:flutter/material.dart';

// class BookRequestAdminPage extends StatelessWidget{
//   BookRequestAdminPage({Key? key}) : super(key: key);

//   final List<AdminItem> items = [
//     AdminItem("Approve Book Request", Icons.check),
//     AdminItem("Reject Book Request", Icons.close)
//   ];

//   @override
//   Widget build(BuildContext context){
//     if (isAdmin){
//       return Scaffold(
//         appBar: AppBar(
//           title: cons Text('Requests List'),
//         ),
//         body: ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index){
//             return ListTile(
//               title: Text(items[index].title),
//               onTap: (){
//                 // TODO: handle onTap logic
//               },
//             );
//           },
//         ),
//       );
//     }
//     else{
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Not an Admin'),
//         ),
//         body: Center(
//           child: Text('You do not have admin privileges.'),
//         ),
//       );
//     }
//   }
// }