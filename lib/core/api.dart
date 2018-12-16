import "dart:convert";
import "package:http/http.dart" as http;

import "package:tmdb_dart/config/account.dart" as accountPath;

class SessionInformation {
  bool isGuest;
  bool isLoggedIn;
  String sessionId;
  String requestToken;
  DateTime expiresAt;

  Map<String, dynamic> get asMap => {
        "isGuest": isGuest,
        "isLoggedIn": isLoggedIn,
        "sessionId": sessionId,
        "requestToken": requestToken,
        "expiresAt": expiresAt
      };

  @override
  String toString() => asMap.toString();

  SessionInformation.createFromMap(Map map) : isLoggedIn = false {
    if (map.containsKey("guest_session_id")) {
      this.isGuest = true;
      this.isLoggedIn = true;
      this.requestToken = map["guest_session_id"];
      this.sessionId = map["guest_session_id"];
    } else {
      this.isGuest = false;
      this.requestToken = map["request_token"];
    }

    this.setExpiresAt(map["expires_at"]);
  }

  void setExpiresAt(String expirationDate) =>
      expiresAt = DateTime.parse(expirationDate.replaceAll("UTC", "Z"));
}

class TmdbApi {
  /// The base URL for this API
  final String _baseUrl;

  /// API Key (in this case v3)
  final String _apiKey;

  /// Do we use HTTPS?
  final bool _useHttps;

  /// The session infromation that holds all the information of the session
  SessionInformation _sessionInformation;

  /// Readonly [SessionInformation] that returns the auth related
  /// tokens for [this]
  Map get sessionInformation => _sessionInformation?.asMap;

  @override
  String toString() => this._sessionInformation.toString();

  TmdbApi(this._apiKey, [this._useHttps = true])
      : _baseUrl = "api.themoviedb.org/3";

  /// Builds a Tmdb URL with API key baked in.
  _buildUrl([path = ""]) =>
      "http${_useHttps ? "s" : ""}://${_baseUrl}${path}?api_key=${_apiKey}";

  /// Performs a [http.get] and returns the response as a dart [Map]
  Future<Map<String, dynamic>> mapFromGet(String path) async {
    var _client = http.Client();
    var response = await _client.get(_buildUrl(path));
    _client.close();

    return jsonDecode(response.body);
  }

  /// Performs a [http.post] and returns the response as a dart [Map]
  Future<Map<String, dynamic>> mapFromPost(
      String path, Map<String, String> payload) async {
    var _client = http.Client();
    var response = await _client.post(_buildUrl(path), body: payload);
    _client.close();

    return jsonDecode(response.body);
  }

  /// Performs a [http.delete] and returns the response as a dart [Map]
  Future<Map<String, dynamic>> mapFromDelete(String path) async {
    var _client = http.Client();
    var response = await _client.delete(_buildUrl(path));
    _client.close();

    return jsonDecode(response.body);
  }

  /// Creates a new unauthorized request token.
  Future<void> _createRequestToken() async {
    _sessionInformation = SessionInformation.createFromMap(
        await mapFromGet(accountPath.createNewToken));
  }

  /// Validates/authorizes a request token from username and password of a user.
  Future<void> _validateWithLogin(String username, String password) async {
    if (_sessionInformation?.requestToken == null) throw "NO_REQUEST_TOKEN";
    var result = await mapFromPost(accountPath.validateWithLogin, {
      "username": username,
      "password": password,
      "request_token": _sessionInformation.requestToken
    });

    if (result.containsKey("success") && result["success"]) {
      _sessionInformation.isLoggedIn = true;
      _sessionInformation.setExpiresAt(result["expires_at"]);
    } else {
      throw "LOGIN_ERROR";
    }
  }

  /// Creates a new session token based off of an authorized request token.
  Future<void> _createNewSession() async {
    var result = await mapFromPost(accountPath.createNewSession,
        {"request_token": _sessionInformation?.requestToken});
    if (result.containsKey("success") && result["success"] == true)
      _sessionInformation.sessionId = result["session_id"];
    else {
      print(result);
      throw "SESSION_FAILED";
    }
  }

  /// Authenticates as guest.
  Future<void> loginAsGuest() async {
    _sessionInformation = SessionInformation.createFromMap(
        await mapFromGet(accountPath.createNewGuestSession));
  }

  /// Performs the login action of a user.
  /// It starts with creating a token, then it authorizes the token
  /// with username/password and finally creates a new session based
  /// on that token. The user has 1 hour to create a session ID from the token.
  Future<void> login(String username, String password) async {
    await _createRequestToken();
    await _validateWithLogin(username, password);
    await _createNewSession();
  }

  /// Logs out deletes the session
  Future<void> logout() async {
    _sessionInformation = null;
    await mapFromDelete(accountPath.sessionRoot);
  }
}
