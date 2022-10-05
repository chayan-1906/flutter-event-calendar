import '../utils/get_full_name.dart';
import '../utils/is_string_invalid.dart';
import 'dependent.dart';
import 'file_details.dart';

class QueueReservation {
  String userId;
  DateTime reservationStartTime;
  DateTime reservationEndTime;
  String reservationID;
  String businessId;
  String fullName;
  String memberState;
  String latitude;
  String longitude;
  String qJoinTime;
  String originalETA;
  String latestETA;
  String memberQueuePosition;
  String lastReportedLocationTimeStamp;
  String lastReportedLocationAccuracy;
  String noShowCount;
  DateTime memberStateUpdateTimeStamp;
  String waitTime;
  String reservationType;
  String phoneNumber;
  String numberOfPeopleOnReservation;
  DateTime reservationCreatedTimeStamp;
  DateTime reservationUpdatedTimeStamp;
  String companyName;
  String locationName;
  String address;
  String companyLogoURL;
  String qName;
  List<dynamic> authorizedUsers;
  DateTime arrivedTimeStamp;
  DateTime calledToEnterTimeStamp;
  DateTime inFacilityTimeStamp;
  DateTime completedTimeStamp;
  String dateOfBirth;
  String station;
  List<dynamic> linkedFiles;
  String runningLate;
  bool availableEarly;
  String distanceFromBusinessInMiles;
  SlotBookingDetails slotBookingDetails;
  String appointmentTypeId;
  String appointmentTypeName;
  String reasonForVisit;
  String notes;
  List<Dependent> dependents;
  Map<String, dynamic> profileFormResponse;

  QueueReservation({
    this.userId,
    this.reservationStartTime,
    this.reservationEndTime,
    this.reservationID,
    this.businessId,
    this.fullName,
    this.memberState,
    this.latitude,
    this.longitude,
    this.qJoinTime,
    this.originalETA,
    this.latestETA,
    this.memberQueuePosition,
    this.lastReportedLocationTimeStamp,
    this.lastReportedLocationAccuracy,
    this.noShowCount,
    this.memberStateUpdateTimeStamp,
    this.waitTime,
    this.reservationType,
    this.phoneNumber,
    this.numberOfPeopleOnReservation,
    this.reservationCreatedTimeStamp,
    this.reservationUpdatedTimeStamp,
    this.companyName,
    this.locationName,
    this.address,
    this.companyLogoURL,
    this.qName,
    this.authorizedUsers,
    this.arrivedTimeStamp,
    this.calledToEnterTimeStamp,
    this.inFacilityTimeStamp,
    this.completedTimeStamp,
    this.dateOfBirth,
    this.station,
    this.linkedFiles,
    this.runningLate,
    this.availableEarly,
    this.distanceFromBusinessInMiles,
    this.slotBookingDetails,
    this.appointmentTypeId,
    this.appointmentTypeName,
    this.reasonForVisit,
    this.notes,
    this.dependents,
    this.profileFormResponse,
  });

  QueueReservation.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    reservationID = json['ReservationID'];
    reservationStartTime = !isStringInvalid(json["ReservationStartTime"])
        ? DateTime.parse(json["ReservationStartTime"]).toLocal()
        : DateTime.now();
    reservationEndTime = !isStringInvalid(json['ReservationEndTime'])
        ? DateTime.parse(json['ReservationEndTime']).toLocal()
        : null;
    businessId = json['QID'];
    memberState = json['MemberState'];
    fullName = getFullName(
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
    );
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    qJoinTime = json['QJoinTime'];
    originalETA = json['OriginalETA'];
    latestETA = json['LatestETA'];
    memberQueuePosition = json['MemberQueuePosition'];
    lastReportedLocationTimeStamp = json['LastReportedLocationTimeStamp'];
    lastReportedLocationAccuracy = json['LastReportedLocationAccuracy'];
    noShowCount = json['NoShowCount'];
    if (!isStringInvalid(json['MemberStateUpdateTimeStamp'])) {
      memberStateUpdateTimeStamp =
          DateTime.parse(json['MemberStateUpdateTimeStamp']).toLocal();
    }
    waitTime = json['WaitTime'];
    reservationType = json['ReservationType'];
    phoneNumber = json['PhoneNumber'];
    numberOfPeopleOnReservation =
        json['NumberOfPeopleOnReservation'].toString();
    if (!isStringInvalid(json['ReservationCreatedTimeStamp'])) {
      reservationCreatedTimeStamp =
          DateTime.parse(json['ReservationCreatedTimeStamp']).toLocal();
    }
    if (!isStringInvalid(json['ReservationUpdatedTimeStamp'])) {
      reservationUpdatedTimeStamp =
          DateTime.parse(json['ReservationUpdatedTimeStamp']).toLocal();
    }
    companyName = json['CompanyName'];
    locationName = json['LocationName'];
    address = json['Address'];
    companyLogoURL = json['CompanyLogoURL'];
    qName = json['QName'];
    if (!isStringInvalid(json['arrivedTimeStamp'])) {
      arrivedTimeStamp = DateTime.parse(json['arrivedTimeStamp']).toLocal();
    }
    if (!isStringInvalid(json['calledToEnterTimeStamp'])) {
      calledToEnterTimeStamp =
          DateTime.parse(json['calledToEnterTimeStamp']).toLocal();
    }
    if (!isStringInvalid(json['inFacilityTimeStamp'])) {
      inFacilityTimeStamp =
          DateTime.parse(json['inFacilityTimeStamp']).toLocal();
    }
    if (!isStringInvalid(json['completedTimeStamp'])) {
      completedTimeStamp = DateTime.parse(json['completedTimeStamp']).toLocal();
    }
    dateOfBirth = json['dateOfBirth'];
    authorizedUsers = json['AuthorizedUsers'];
    dependents = [];
    for (var dependent in json['dependence']) {
      var dependentFromJson = Dependent.fromJson(dependent);
      dependents.add(dependentFromJson);
    }
    station = json['station'];
    linkedFiles = [];
    if (json['linkedFiles'] != 'null') {
      for (var linkedFile in json['linkedFiles']) {
        var linkedFilesFromJson = FileDetails.fromJson(linkedFile);
        linkedFiles.add(linkedFilesFromJson.toMap());
      }
    }
    runningLate = json['runningLate'];
    availableEarly = json['availableEarly'];
    distanceFromBusinessInMiles = json['distanceFromBusinessInMiles'];
    slotBookingDetails =
        SlotBookingDetails.fromJson(json["slotBookingDetails"]);
    appointmentTypeId = json['appointmentTypeId'];
    appointmentTypeName = json['appointmentTypeName'];
    reasonForVisit = json['reasonForVisit'];
    notes = json['notes'];
    profileFormResponse = json['profileFormResponse'] == null ||
            json['profileFormResponse'] == 'null'
        ? {}
        : json['profileFormResponse']['responseData'] ?? {};
  }

  QueueReservation.fromObject(QueueReservation queueReservation) {
    userId = queueReservation.userId;
    reservationID = queueReservation.reservationID;
    reservationStartTime = queueReservation.reservationStartTime;
    reservationEndTime = queueReservation.reservationEndTime;
    businessId = queueReservation.businessId;
    memberState = queueReservation.memberState;
    latitude = queueReservation.latitude;
    longitude = queueReservation.longitude;
    qJoinTime = queueReservation.qJoinTime;
    originalETA = queueReservation.originalETA;
    latestETA = queueReservation.latestETA;
    memberQueuePosition = queueReservation.memberQueuePosition;
    lastReportedLocationTimeStamp =
        queueReservation.lastReportedLocationTimeStamp;
    lastReportedLocationAccuracy =
        queueReservation.lastReportedLocationAccuracy;
    noShowCount = queueReservation.noShowCount;
    memberStateUpdateTimeStamp = queueReservation.memberStateUpdateTimeStamp;
    waitTime = queueReservation.waitTime;
    reservationType = queueReservation.reservationType;
    phoneNumber = queueReservation.phoneNumber;
    numberOfPeopleOnReservation = queueReservation.numberOfPeopleOnReservation;
    reservationCreatedTimeStamp = queueReservation.reservationCreatedTimeStamp;
    reservationUpdatedTimeStamp = queueReservation.reservationUpdatedTimeStamp;
    companyName = queueReservation.companyName;
    locationName = queueReservation.locationName;
    address = queueReservation.address;
    companyLogoURL = queueReservation.companyLogoURL;
    qName = queueReservation.qName;
    arrivedTimeStamp = queueReservation.arrivedTimeStamp;
    calledToEnterTimeStamp = queueReservation.calledToEnterTimeStamp;
    inFacilityTimeStamp = queueReservation.inFacilityTimeStamp;
    completedTimeStamp = queueReservation.completedTimeStamp;
    dateOfBirth = queueReservation.dateOfBirth;
    authorizedUsers = queueReservation.authorizedUsers;
    station = queueReservation.station;
    linkedFiles = queueReservation.linkedFiles;
    runningLate = queueReservation.runningLate;
    availableEarly = queueReservation.availableEarly;
    distanceFromBusinessInMiles = queueReservation.distanceFromBusinessInMiles;
    slotBookingDetails = queueReservation.slotBookingDetails;
    dependents = queueReservation.dependents;
    appointmentTypeId = queueReservation.appointmentTypeId;
    appointmentTypeName = queueReservation.appointmentTypeName;
    reasonForVisit = queueReservation.reasonForVisit;
    notes = queueReservation.notes;
    profileFormResponse = queueReservation.profileFormResponse;
  }
}

class SlotBookingDetails {
  SlotBookingDetails({
    this.isSlot,
    this.date,
    this.startTime,
    this.endTime,
    this.providerId,
    this.appointmentTypeId,
    this.appointmentTypeName,
    this.providerName,
  });

  bool isSlot;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  String providerId;
  String appointmentTypeId;
  String appointmentTypeName;
  String providerName;

  factory SlotBookingDetails.fromJson(Map<String, dynamic> json) =>
      SlotBookingDetails(
        isSlot: json['isSlot'],
        date: !isStringInvalid(json['date'])
            ? DateTime.parse(json['date']).toLocal()
            : null,
        startTime: !isStringInvalid(json['startTime'])
            ? DateTime.parse(json['startTime']).toLocal()
            : null,
        endTime: !isStringInvalid(json['endTime'])
            ? DateTime.parse(json['endTime']).toLocal()
            : null,
        providerId: json['providerId'],
        appointmentTypeId: json['appointmentTypeId'],
        appointmentTypeName: json['appointmentTypeName'],
        providerName: json['providerName'],
      );

  @override
  String toString() {
    return 'SlotBookingDetails{isSlot: $isSlot, date: $date, startTime: $startTime, endTime: $endTime, providerId: $providerId, appointmentTypeId: $appointmentTypeId, appointmentTypeName: $appointmentTypeName, providerName: $providerName}';
  }
}
