class Connection{

  var url = '';

  String getUrl() {
    //url = "10.1.1.70/testApi";                        //Local server
    url = "app-1538168783.000webhostapp.com/testApi";   //Web server
    return url;
  }
}
Connection con = Connection();