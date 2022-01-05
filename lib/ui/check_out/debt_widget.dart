import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yourfuel/models/debt.dart';
import 'package:yourfuel/models/fuel_price.dart';
import 'package:yourfuel/utils/app_utils.dart';

import 'check_out.dart';

class DebtItem extends StatefulWidget {
    DebtItem({
    Key? key,
    required this.onValueChange,
    required this.onDelete,
    required this.priceType,
    required this.item,
  }) : super(key: key);

  final List<FuelPrice> priceType;
  final VoidCallback onDelete;
  final Function(Debt) onValueChange;
   Debt item;

  @override
  _DebtItemState createState() => _DebtItemState();
}

class _DebtItemState extends State<DebtItem> {

  FuelPrice? dropdownValue;

  final onClickShowOtherFuel = PublishSubject<bool>();

  @override
  void initState() {
    dropdownValue =widget.priceType[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print("rebuild item ${widget.item.toString()}");
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(left: 5, right: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.orange),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 6,
                child: TextField(
                  maxLength: 50,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      counter: Offstage(),
                      labelText: "Tên",
                      fillColor: AppColors.primaryColor),
                  onChanged: (value){
                    widget.item.debtorName=value;
                    widget.onValueChange(widget.item);},
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 5,
                child: MoneyTextField(
                  data: widget.item.value.toString(),maxLength: 11,
                  onDataChange: (value) {
                    widget.item.value=value;
                    widget.onValueChange(widget.item);
                  },
                  labelText: "Số tiền(lít)",
                ),
              ),
              Expanded(flex: 3, child: dropdownType()),
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
          StreamBuilder<bool>(
            stream: onClickShowOtherFuel.stream,
            initialData: false,
            builder: (context, snapshot) {
              return Visibility(
                visible: snapshot.data!,
                child: TextField(
                  maxLength: 100,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      counter: Offstage(),
                      labelText: "Other fuel",
                      fillColor: AppColors.primaryColor),
                  onChanged: (value) {
                    widget.item.engineOilName=value;
                    widget.onValueChange(widget.item);
                  },
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  Widget dropdownType(){
    return
      DropdownButton<FuelPrice>(
        value: dropdownValue,
        isExpanded: true,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (FuelPrice? newValue) {
          setState(() {
            dropdownValue = newValue ?? widget.priceType[0];
            widget.item.fuelType=dropdownValue!;
            if (dropdownValue!.type == 1) {
              onClickShowOtherFuel.add(true);
            }
            else {
              onClickShowOtherFuel.add(false);
            }
          });
        },
        items: widget.priceType
            .map<DropdownMenuItem<FuelPrice>>((FuelPrice value) {
          return DropdownMenuItem<FuelPrice>(
            value: value,
            child: Text(
              value.name,
              style: const TextStyle(fontSize: 13),
            ),
          );
        }).toList(),
      );
  }
}