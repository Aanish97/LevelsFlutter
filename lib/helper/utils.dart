String insertAuthPath(String path) {
  List<String> pathParts = path.split("/media");
  String modifiedPath = "${pathParts.first}/v1/auth/media${pathParts.last}";
  print(modifiedPath);
  return modifiedPath;
}