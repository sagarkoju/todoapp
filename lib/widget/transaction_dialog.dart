// import 'package:flutter/material.dart';

// import '../model/transaction.dart';

// class TransactionDialog extends StatefulWidget {
//   final Transaction transaction;
//   final Function(String title, String detail, double amount) onClickedDone;

//   const TransactionDialog({
//     Key key,
//     this.transaction,
//     @required this.onClickedDone,
//   }) : super(key: key);

//   @override
//   _TransactionDialogState createState() => _TransactionDialogState();
// }

// class _TransactionDialogState extends State<TransactionDialog> {
//   final formKey = GlobalKey<FormState>();
//   final titleController = TextEditingController();
//   final detailController = TextEditingController();
//   final amountController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     if (widget.transaction != null) {
//       final transaction = widget.transaction;

//       titleController.text = transaction.title;
//       detailController.text = transaction.detail;
//       amountController.text = transaction.amount.toString();
//     }
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     detailController.dispose();
//     amountController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isEditing = widget.transaction != null;
//     final title = isEditing ? 'Edit Transaction' : 'Add Transaction';

//     return AlertDialog(
//       title: Text(title),
//       content: Form(
//         key: formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               SizedBox(height: 8),
//               buildName(),
//               SizedBox(height: 8),
//               buildAmount(),
//             ],
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         buildCancelButton(context),
//         buildAddButton(context, isEditing: isEditing),
//       ],
//     );
//   }

//   Widget buildName() => TextFormField(
//         controller: titleController,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: 'Enter Name',
//         ),
//         validator: (name) =>
//             name != null && name.isEmpty ? 'Enter a name' : null,
//       );

//   Widget buildAmount() => TextFormField(
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           hintText: 'Enter Amount',
//         ),
//         keyboardType: TextInputType.number,
//         validator: (amount) => amount != null && double.tryParse(amount) == null
//             ? 'Enter a valid number'
//             : null,
//         controller: amountController,
//       );

//   Widget buildCancelButton(BuildContext context) => TextButton(
//         child: Text('Cancel'),
//         onPressed: () => Navigator.of(context).pop(),
//       );

//   Widget buildAddButton(BuildContext context, {@required bool isEditing}) {
//     final text = isEditing ? 'Save' : 'Add';

//     return TextButton(
//       child: Text(text),
//       onPressed: () async {
//         final isValid = !formKey.currentState.validate();

//         if (isValid) {
//           final title = titleController.text;
//           final detail = detailController.text;
//           final amount = double.tryParse(amountController.text) ?? 0;

//           widget.onClickedDone(title, detail, amount);

//           Navigator.of(context).pop();
//         }
//       },
//     );
//   }
// }
