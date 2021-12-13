import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_fuel_app/models/debt.dart';
import 'package:your_fuel_app/utils/app_utils.dart';

class DebtItem extends StatefulWidget {
  const DebtItem({Key? key, required this.onDelete, required this.item})
      : super(key: key);

  final VoidCallback onDelete;
  final Debt item;

  @override
  _DebtItemState createState() => _DebtItemState();
}

class _DebtItemState extends State<DebtItem> {
  TextEditingController debtorNameController = TextEditingController();

  @override
  void initState() {
    debtorNameController.text = widget.item.debtorName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(left: 5, right: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.orange),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: TextField(
              controller: debtorNameController,
              maxLength: 50,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  counter: Offstage(),
                  labelText: "Tên",
                  fillColor: AppColors.primaryColor),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const Expanded(
            flex: 5,
            child: TextField(
              maxLength: 11,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counter: Offstage(),
                  labelText: "Số tiền(lít)",
                  fillColor: AppColors.primaryColor),
            ),
          ),
          const Expanded(flex: 3, child: DropdownType()),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: widget.onDelete,
                child: const Icon(
                  Icons.highlight_remove,
                  color: Colors.red,
                ),
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    debtorNameController.dispose();
    super.dispose();
  }
}

class DropdownType extends StatefulWidget {
  const DropdownType({Key? key}) : super(key: key);

  @override
  _DropdownTypeState createState() => _DropdownTypeState();
}

class _DropdownTypeState extends State<DropdownType> {
  String dropdownValue = 'Đồng';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      isExpanded: true,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Đồng', 'Lít dầu', 'Lít xăng', 'Lít nhớt']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 13),
          ),
        );
      }).toList(),
    );
  }
}
