import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:wanda_dairy/models/milk_collection.dart';
import 'package:wanda_dairy/models/user_model.dart';

class PdfInvoiceApi {
  static Future<Uint8List> generate({
    required UserModel user,
    required List<MilkCollection> milkCollections,
    required DateTime monthYear,
  }) async {
    const color = PdfColors.black;
    final pdf = pw.Document();

    final iconImage =
        (await rootBundle.load('images/logo.png')).buffer.asUint8List();

    final tableHeaders = ['Date', 'Volume (L)', 'Unit Price', 'Total', 'Paid'];

    final tableData = [
      for (final collection in milkCollections)
        [
          DateFormat("dd/MM/yyyy").format(collection.collectionDate),
          "${collection.volumeInLitres}L",
          NumberFormat("#,##0.00").format(collection.pricePerLitre),
          NumberFormat("#,##0.00").format(
            collection.pricePerLitre * collection.volumeInLitres,
          ),
          collection.isPaid ? 'Yes' : 'No',
        ],
    ];

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return [
            pw.Row(
              children: [
                pw.Image(
                  pw.MemoryImage(iconImage),
                  height: 72,
                  width: 72,
                ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'INVOICE',
                      style: pw.TextStyle(
                        fontSize: 17.0,
                        fontWeight: pw.FontWeight.bold,
                        color: color,
                      ),
                    ),
                    pw.Text(
                      'Wanda Dairy',
                      style: const pw.TextStyle(
                        fontSize: 15.0,
                        color: color,
                      ),
                    ),
                  ],
                ),
                pw.Spacer(),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      user.name,
                      style: pw.TextStyle(
                        fontSize: 15.5,
                        fontWeight: pw.FontWeight.bold,
                        color: color,
                      ),
                    ),
                    pw.Text(
                      user.email,
                      style: const pw.TextStyle(
                        fontSize: 14.0,
                        color: color,
                      ),
                    ),
                    pw.Text(
                      DateFormat('dd/MM/yyyy h:mm a').format(DateTime.now()),
                      style: const pw.TextStyle(
                        fontSize: 14.0,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              'Dear ${user.name.split(" ")[0]},\n\nThank you for your business. Below is your invoice for ${DateFormat('MMMM').format(monthYear)}, ${monthYear.year}.',
              textAlign: pw.TextAlign.justify,
              style: const pw.TextStyle(
                fontSize: 14.0,
                color: color,
              ),
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            ///
            /// PDF Table Create
            ///
            pw.TableHelper.fromTextArray(
              headers: tableHeaders,
              data: tableData,
              border: null,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 30.0,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerRight,
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerRight,
                4: pw.Alignment.centerRight,
              },
            ),
            pw.Divider(),
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(
                children: [
                  pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Net total',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            pw.Text(
                              "Ksh. ${NumberFormat("#,##0.00").format(milkCollections.fold<double>(0, (previousValue, element) => previousValue + element.pricePerLitre * element.volumeInLitres))}",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                        pw.Divider(),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Total amount due',
                                style: pw.TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: pw.FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                            pw.Text(
                              "Ksh. ${NumberFormat("#,##0.00").format(milkCollections.fold<double>(0, (previousValue, element) => previousValue + (element.isPaid ? 0 : element.pricePerLitre * element.volumeInLitres)))}",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                        pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Divider(),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Text(
                'Wanda Dairy Limited',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: color,
                ),
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Address: ',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: color,
                    ),
                  ),
                  pw.Text(
                    'Nyeri, Kenya',
                    style: const pw.TextStyle(
                      color: color,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Email: ',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: color,
                    ),
                  ),
                  pw.Text(
                    'hello@wandadairy.com',
                    style: pw.TextStyle(color: color, font: pw.Font.courier()),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return Future.value(pdf.save());
  }
}
