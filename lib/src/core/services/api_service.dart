import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pokedex_app/src/app/config/app_config.dart';

enum HttpMethod { GET, POST, PUT, PATCH, DELETE }

final apiService = ApiService.instance;

class ApiService {
  static Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.getInstance().apiBaseUrl!,
      connectTimeout: 60000,
      receiveTimeout: 60000,
    ),
  );

  static final instance = ApiService._();

  ApiService._();

  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  ///
  /// Requests
  ///

  Future<dynamic> request(
    HttpMethod method,
    String endpoint, {
    Map<String, dynamic>? headers,
    body,
    bool ignoreInterceptor = false,
  }) async {
    dynamic response;

    try {
      if (method == HttpMethod.GET) {
        response = await this._get(
          endpoint,
          headers,
          ignoreInterceptor,
        );
      } else if (method == HttpMethod.POST) {
        response = await this._post(
          endpoint,
          body,
          headers,
          ignoreInterceptor,
        );
      } else if (method == HttpMethod.PUT) {
        response = await this._put(
          endpoint,
          body,
          headers,
          ignoreInterceptor,
        );
      } else if (method == HttpMethod.PATCH) {
        response = await this._patch(
          endpoint,
          body,
          headers,
          ignoreInterceptor,
        );
      } else if (method == HttpMethod.DELETE) {
        response = await this._delete(
          endpoint,
          body,
          headers,
          ignoreInterceptor,
        );
      } else {
        customPrint('HttpMethod desconhecido!');
      }
    } on DioError catch (e) {
      customPrint(
          "Exception Request => ($method) => ${_dio.options.baseUrl}$endpoint");
      if (body != null) customPrint('Exception Body => ${jsonEncode(body)}');
      customPrint('Exception Headers => ${e.response!.headers}');
      customPrint('Exception Response => ${e.response!.data}');
      customPrint('Exception => ${e.toString()}');

      if (e is DioError) {
        var dioError = e;

        customPrint('Exception Dio => ${dioError.message}');

        if (dioError.response!.statusCode == 300) {
          // Multiple Choices
          return dioError.response!.data['data'];
        }

        String message = dioError.response!.data['data']['message'];
        if (message != null) {
          throw new Exception(message);
        } else {
          throw new Exception(
              'Erro desconhecido! Entre em contato com um administrador do sistema.');
        }
      } else {
        throw new Exception(
            'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
      }
    }

    return response;
  }

  Future<dynamic> _get(
    String endpoint,
    Map<String, dynamic>? headers,
    bool ignoreInterceptor,
  ) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.get(
      endpoint,
      options: await this._getCustomConfig(headers, ignoreInterceptor),
    );

    return this._generateResponse(response);
  }

  Future<dynamic> _post(
    String endpoint,
    Map<String, dynamic>? headers,
    body,
    bool ignoreInterceptor,
  ) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.post(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers!, ignoreInterceptor),
    );

    return this._generateResponse(response);
  }

  Future<dynamic> _put(
    String endpoint,
    Map<String, dynamic>? headers,
    body,
    bool ignoreInterceptor,
  ) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.put(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers!, ignoreInterceptor),
    );
    return this._generateResponse(response);
  }

  Future<dynamic> _patch(
    String endpoint,
    Map<String, dynamic>? headers,
    body,
    bool ignoreInterceptor,
  ) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.patch(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers!, ignoreInterceptor),
    );
    return this._generateResponse(response);
  }

  Future<dynamic> _delete(
    String endpoint,
    Map<String, dynamic>? headers,
    body,
    bool ignoreInterceptor,
  ) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Response response = await _dio.delete(
      endpoint,
      data: body,
      options: await this._getCustomConfig(headers!, ignoreInterceptor),
    );
    return this._generateResponse(response);
  }

  /// ==========================================================
  /// Custom
  ///

  Future<dynamic> customPost(
    String endpoint, {
    Map<String, dynamic>? headers,
    body,
  }) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Map<String, dynamic> header = {};
    header.addAll(headers!);

    Options options = Options();
    options.extra = {'ignoreInterceptor': true};
    options.headers = header;

    dynamic response;

    try {
      response = await Dio(
        BaseOptions(
          connectTimeout: 60000,
          receiveTimeout: 60000,
        ),
      ).post(
        endpoint,
        data: body,
        options: options,
      );
    } on DioError catch (e) {
      customPrint("Exception Request => (POST) => $endpoint");
      if (body != null) customPrint('Exception Body => ${jsonEncode(body)}');
      customPrint('Exception Headers => ${e.response!.headers}');
      customPrint('Exception => ${e.response}');

      if (e is DioError) {
        var dioError = e;
        customPrint('Exception Dio => ${dioError.message}');
        String message = dioError.response?.data['message'];
        if (message != null) {
          throw new Exception(message);
        } else {
          throw new Exception(
              'Erro desconhecido! Entre em contato com um administrador do sistema.');
        }
      } else {
        throw new Exception(
            'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
      }
    }

    customPrint('Request Headers => ${response.request.headers}');
    customPrint(
        "Request (${response.request.method}) => ${response.request.uri}");
    if (response.request.data != null)
      customPrint("${jsonEncode(response.request.data)}");
    customPrint(
        "Response (${response.statusCode}) => ${jsonEncode(response.data)}");

    return response.data;
  }

  Future<dynamic> customGet(
    String endpoint, {
    Map<String, dynamic>? headers,
  }) async {
    if (!await this.isConnected()) {
      throw new Exception('Verifique sua conexão!');
    }

    Options options = Options();
    options.extra = {'ignoreInterceptor': true};
    options.headers = headers;

    dynamic response;

    try {
      response = await Dio().get(
        endpoint,
        options: options,
      );
    } on DioError catch (e) {
      // customPrint(e);
      customPrint("Exception Request => (GET) => $endpoint");
      customPrint('Exception Headers => ${e.response!.headers}');
      customPrint('Exception => ${e.response}');

      if (e is DioError) {
        var dioError = e;
        customPrint('Exception Dio => ${dioError.message}');
        String message = dioError.response?.data['message'];
        if (message != null) {
          throw new Exception(message);
        } else {
          throw new Exception(
              'Erro desconhecido! Entre em contato com um administrador do sistema.');
        }
      } else {
        throw new Exception(
            'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
      }
    }

    customPrint('Request Headers => ${response.requestOptions.headers}');
    customPrint(
        "Request (${response.requestOptions.method}) => ${response.requestOptions.uri}");
    if (response.requestOptions.data != null)
      customPrint("${jsonEncode(response.requestOptions.data)}");
    customPrint(
        "Response (${response.statusCode}) => ${jsonEncode(response.data)}");

    return response.data;
  }

  dynamic _generateResponse(Response? response) {
    if (response == null) {
      customPrint('404 - Response null');
      throw new Exception(
          'Não foi possível concluir sua chamada! Tente novamente mais tarde.');
    }

    final int statusCode = response.statusCode!;

    customPrint('Request Headers => ${response.requestOptions.headers}');
    customPrint(
        "Request (${response.requestOptions.extra}) => ${response.requestOptions.uri}");
    if (response.data != null) customPrint("${jsonEncode(response.data)}");
    customPrint("Response ($statusCode) => ${jsonEncode(response.data)}");

    final decoded = response.data;

    if (statusCode < 200 || statusCode > 204) {
      if (decoded != null && decoded["data"] != null) {
        throw new Exception(decoded["data"]);
      }
      throw new Exception(
          'Não foi possivel concluir sua chamada! Tente novamente mais tarde.');
    }

    if (decoded == null)
      return null;
    else if (decoded is List) {
      return decoded;
    } else if (decoded is Map) {
      if (decoded["data"] != null) {
        return decoded["data"];
      } else if (decoded.isNotEmpty) {
        return decoded;
      } else {
        return null;
      }
    } else if (decoded is String && decoded.isEmpty)
      return null;
    else {
      return decoded;
    }
  }

  Future<Options> _getCustomConfig(
    Map<String, dynamic>? customHeader,
    bool ignoreInterceptor,
  ) async {
    var options = Options();
    options.extra = {'ignoreInterceptor': ignoreInterceptor};
    options.headers = await this._getDefaultHeader(customHeader);
    return options;
  }

  Future<Map<String, dynamic>> _getDefaultHeader(
    Map<String, dynamic>? customHeader,
  ) async {
    Map<String, dynamic> header = {"Content-Type": "application/json"};

    if (customHeader != null) {
      header.addAll(customHeader);
    }

    return header;
  }

  ///
  /// Extras
  ///

  Future<bool> isConnected() async {
    return true;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   return false;
    // } else {
    //   return true;
    // }
  }

  void customPrint(String text) {
    final pattern = RegExp('.{1,900}');
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
