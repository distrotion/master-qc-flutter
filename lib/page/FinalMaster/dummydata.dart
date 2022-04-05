import '../../data/global.dart';

var TypeData = [
  {"TYPE": "Attribute", "masterID": "TYPE-123456789"},
  {"TYPE": "length", "masterID": "TYPE-987654321"}
];

List<dataset> TypeDataDS = [
  dataset(f01: "Attribute", f02: "TYPE-123456789"),
  dataset(f01: "length", f02: "TYPE-987654321")
];

List<dataset> UnitDataDS = [
  dataset(f01: "Attribute", f03: "", f02: "", f04: "TYPE-123456789"),
  dataset(f01: "length", f03: "1", f02: "mm.", f04: "TYPE-987654321"),
  dataset(f01: "length", f03: "1", f02: "cm.", f04: "TYPE-987654321"),
  dataset(f01: "length", f03: "2", f02: "μm.", f04: "TYPE-987654321"),
];

List<dataset> ITEMsDataDS = [
  dataset(
      f01: "Attribute",
      f02: "Appearance for rust",
      f03: "",
      f04: "",
      f05: "",
      f06: "TYPE-123456789"),
  dataset(
      f01: "Attribute",
      f02: "Appearance for scratch",
      f03: "",
      f04: "",
      f05: "",
      f06: "TYPE-123456789"),
];

List<dataset> MachineDataDS = [
  dataset(f01: "Visual", f02: "", f03: "", f04: "", f05: "TYPE-123456789"),
  dataset(f01: "Micrometer", f02: "", f03: "", f04: "", f05: "TYPE-123456789"),
];

List<dataset> MethodeDataDS = [
  dataset(
      f01: "Appearance for rust",
      f02: "Visual",
      f03: "",
      f04: "",
      f05: "TYPE-123456789"),
  dataset(
      f01: "Appearance for scratch",
      f02: "Visual",
      f03: "",
      f04: "",
      f05: "TYPE-123456789"),
];

List<dataset> SPecDataDS = [
  dataset(f01: "Appearance for rust", f02: "No rust", f03: "TYPE-123456789"),
  dataset(
      f01: "Appearance for scratch", f02: "No scratch", f03: "TYPE-123456789"),
];
