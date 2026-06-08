// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;
import 'dart:typed_data';

/// Triggers the browser's native "Save file" dialog for [bytes].
/// The suggested filename is [filename] (e.g. 'grades.csv').
Future<void> saveFile(Uint8List bytes, String filename) async {
  // Create a Blob from the bytes, which represents the file data.
  final blob = html.Blob([bytes]);
  // Create an object URL for the blob, which can be used as a link href.
  final url = html.Url.createObjectUrlFromBlob(blob);

  // Create a hidden anchor element with the download attribute set to the filename.
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', filename)
    ..style.display = 'none';

  // Append the anchor to the document body and click it to trigger the download.
  html.document.body!.append(anchor);
  anchor.click();

  // Clean up: remove the anchor element and revoke the object URL to free memory.
  anchor.remove();
  html.Url.revokeObjectUrl(url);
}
