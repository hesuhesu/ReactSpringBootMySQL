package com.spring.board_back.common;

public interface ResponseMessage {

    // HTTP Status 200
    String SUCCESS = "Success";

    // HTTP Status 400
    String VALIDATION_FAILED = "Validation Failed";
    String DUPLICATE_EMAIL = "Duplicate Email";
    String DUPLICATE_NICKNAME = "Duplicate Nickname";
    String DUPLICATE_TEL_NUMBER = "Duplicate Tel Number";
    String NOT_EXISTED_USER = "This User Does Not Exist";
    String NOT_EXISTED_BOARD = "This Board Does Not Exist";

    // HTTP Status 401
    String SIGN_IN_FAIL = "Login Information Missmatch";
    String AUTHORIZATION_FAIL = "Authorization Failed";

    // HTTP Status 403
    String NO_PERMISSION = "Do Not Have Permission";

    // HTTP Status 500
    String DATABASE_ERROR = "DB Error";
}
