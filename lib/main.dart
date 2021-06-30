import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(SfDataGridDemo());
}

class SfDataGridDemo extends StatefulWidget {
  SfDataGridDemo({Key? key}) : super(key: key);

  @override
  _SfDataGridDemoState createState() => _SfDataGridDemoState();
}

class _SfDataGridDemoState extends State<SfDataGridDemo> {
  late EmployeeDataSource employeeDataSource;
  late CustomColumnSizer _customColumnSizer;

  @override
  void initState() {
    super.initState();
    employeeDataSource = EmployeeDataSource(employees: populateData());
    _customColumnSizer = CustomColumnSizer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Syncfusion Flutter DataGrid'),
          ),
          body: SfDataGrid(
            source: employeeDataSource,
            columnSizer: _customColumnSizer,
            onQueryRowHeight: (RowHeightDetails details) {
              return details.getIntrinsicRowHeight(details.rowIndex);
            },
            columns: <GridColumn>[
              GridColumn(
                columnName: 'ID',
                autoFitPadding: EdgeInsets.all(16.0),
                label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ID',
                    softWrap: true,
                  ),
                ),
              ),
              GridColumn(
                columnName: 'Contact Name',
                autoFitPadding: EdgeInsets.all(16.0),
                label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contact Name',
                    softWrap: true,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              GridColumn(
                columnName: 'Company Name',
                width: 95.0,
                autoFitPadding: EdgeInsets.all(16.0),
                label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Company Name',
                    softWrap: true,
                  ),
                ),
              ),
              GridColumn(
                columnName: 'City',
                autoFitPadding: EdgeInsets.all(16.0),
                label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'City',
                    softWrap: true,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class Employee {
  Employee(this.id, this.contactName, this.companyName, this.city);
  final int id;
  final String contactName;
  final String companyName;
  final String city;
}

List<Employee> populateData() {
  return [
    Employee(1671, 'Maria Anders', 'Alfreds Futterkiste', 'Berlin'),
    Employee(1672, 'Ana Trujillo', 'Ana Trujillo Emparedados', 'México D.F.'),
    Employee(1673, 'Antonio Moreno', 'Antonio Moreno Taquería', 'México D.F'),
    Employee(1674, 'Thomas Hardy', 'Around the Horn', 'London'),
    Employee(1675, 'Christina Berglund', 'Berglunds snabbköp', 'Luleå'),
    Employee(1676, 'Hanna Moos', 'Blauer See Delikatessen', 'Mannheim'),
    Employee(1677, 'Frédérique Citeaux', 'Blondel père et fils', 'Strasbourg'),
    Employee(1678, 'Martín Sommer', 'Bólido Comidas preparadas', 'Madrid'),
    Employee(1679, 'Laurence Lebihan', ''' Bon app' ''', 'Marseille'),
    Employee(1610, 'Elizabeth Lincoln', 'Bottom-Dollar Markets', 'Tsawassen'),
    Employee(1611, 'Victoria Ashworth', '''B's Beverages''', 'London'),
    Employee(
        1612, 'Patricio Simpson', 'Cactus Comidas para llevar', 'Buenos Aires'),
    Employee(
        1613, 'Francisco Chang', 'Centro comercial Moctezuma', 'México D.F.'),
    Employee(1614, 'Yang Wang', 'Chop-suey Chinese', 'Bern'),
    Employee(1615, 'Pedro Afonso', 'Comércio Mineiro', 'São Paulo'),
    Employee(1616, 'Elizabeth Brown', 'Consolidated Holdings', 'London'),
    Employee(1617, 'Sven Ottlieb', 'Drachenblut Delikatessen', 'Aachen'),
    Employee(1618, 'Janine Labrune', 'Du monde entier', 'Nantes'),
    Employee(1619, 'Ann Devon', 'Eastern Connection', 'London'),
    Employee(1620, 'Roland Mendel', 'Ernst Handel', 'Graz')
  ];
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    dataGridRows = employees.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'ID', value: dataGridRow.id),
        DataGridCell<String>(
            columnName: 'Contact Name', value: dataGridRow.contactName),
        DataGridCell<String>(
            columnName: 'Company Name', value: dataGridRow.companyName),
        DataGridCell<String>(columnName: 'City', value: dataGridRow.city),
      ]);
    }).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataCell) {
      return Container(
        padding: EdgeInsets.all(16.0),
        alignment: dataCell.columnName == 'ID'
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Text(
          dataCell.value.toString(),
          style: (dataCell.columnName == 'City' ||
                  dataCell.columnName == 'Contact Name')
              ? TextStyle(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
              : null,
        ),
      );
    }).toList());
  }
}

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeHeaderCellHeight(GridColumn column, TextStyle textStyle) {
    if (column.columnName == 'Contact Name' || column.columnName == 'City') {
      textStyle =
          TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
    }
    return super.computeHeaderCellHeight(column, textStyle);
  }

  @override
  double computeCellHeight(GridColumn column, DataGridRow row,
      Object? cellValue, TextStyle textStyle) {
    if (column.columnName == 'Contact Name' || column.columnName == 'City') {
      textStyle =
          TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
    }
    return super.computeCellHeight(column, row, cellValue, textStyle);
  }
}
