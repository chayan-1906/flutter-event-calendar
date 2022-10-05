class FileDetails {
  // String id;
  String fileName;
  String fileCreationDate;
  String fileSize;
  int pageCount;
  String url;

  FileDetails({
    // this.id,
    this.fileName,
    this.fileCreationDate,
    this.fileSize,
    this.pageCount,
    this.url,
  });

  FileDetails.fromJson(Map<String, dynamic> json) {
    // id = json['_id'];
    fileName = json['fileName'];
    fileCreationDate = json['fileCreationDate'];
    fileSize = json['fileSize'];
    pageCount = json['pageCount'];
    url = json['url'];
  }

  Map<String, dynamic> toMap() {
    return {
      // '_id': id,
      'fileName': fileName,
      'fileCreationDate': fileCreationDate,
      'fileSize': fileSize,
      'pageCount': pageCount,
      'url': url,
    };
  }

  @override
  String toString() {
    return 'FileDetails{fileName: $fileName, fileCreationDate: $fileCreationDate, fileSize: $fileSize, pageCount: $pageCount, url: $url}';
  }
}
