class ResponseHandler{
  Map<String, dynamic> successPrinter() {
    return {'Err_Flag': false, 'Err_Desc': 'Done!'};
  }

  Map<String, dynamic> errorPrinter(String errorMessage) {
    return {'Err_Flag': true, 'Err_Desc': errorMessage};
  }

  Map<String, dynamic> timeOutPrinter() {
    return {'Err_Flag': true, 'Err_Desc': 'Server Timeout!'};
  }
}