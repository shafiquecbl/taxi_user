import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomTable extends StatefulWidget {
  final List<CustomDataColumn> columns;
  final List<Map<String, dynamic>> data;
  final Function()? onDelete;
  final Function()? onEdit;
  const CustomTable(
      {required this.columns,
      required this.data,
      this.onDelete,
      this.onEdit,
      Key? key})
      : super(key: key);

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.5,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Row(
              children: [
                for (var column in widget.columns) ...[
                  Expanded(
                    flex: column.flex,
                    child: Text(column.label.toString()),
                  ),
                  SizedBox(width: column.spacing ?? 0),
                ],
                const Expanded(
                  flex: 4,
                  child: Text('Actions'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 15),
              itemCount: widget.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final rowData = widget.data[index];
                return CustomTableRow(
                  columns: widget.columns,
                  rowData: rowData,
                  onDelete: widget.onDelete,
                  onEdit: widget.onEdit,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 5);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTableRow extends StatelessWidget {
  final List<CustomDataColumn> columns;
  final Map<String, dynamic> rowData;
  final Function()? onDelete;
  final Function()? onEdit;
  const CustomTableRow(
      {required this.columns,
      required this.rowData,
      this.onDelete,
      this.onEdit,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            for (var column in columns) ...[
              Expanded(
                flex: column.flex,
                child: Text(
                  rowData[column.label.toString()].toString(),
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(width: 5),
            ],
            Expanded(
              flex: 4,
              child: Wrap(
                spacing: 8,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: onEdit,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: const Icon(
                        Iconsax.edit,
                        size: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: onDelete,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red),
                      ),
                      child: const Icon(
                        Iconsax.trash,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomDataColumn {
  final String label;
  final int flex;
  final double? spacing;
  const CustomDataColumn(
      {required this.label, required this.flex, this.spacing});
}
