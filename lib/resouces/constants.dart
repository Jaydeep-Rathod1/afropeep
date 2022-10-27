import 'package:flutter/foundation.dart';

const BASE_URL ="https://dazzling-gates.62-151-182-243.plesk.page/api/";
// const BASE_URL ="http://127.0.0.1:8000/api/";
const GET_COUNTRY = BASE_URL+"country";
const GET_INTERSET = BASE_URL + "interest";
const ADD_QUESTION = BASE_URL+"addanswer";
const ADD_USER = BASE_URL+"adduser";
const UPDATE_USER = BASE_URL+"updateuser";
const UPDATE_USER1 = BASE_URL+"updateuser1";
const ALL_USER = BASE_URL+"alluser";
const FILTER_USER = BASE_URL+"filteruser";
const GET_USER_BY_ID = BASE_URL +"usedetails";
const EDIT_USER_BY_ID = BASE_URL +"edituser";
const ADD_USER_WITH_EMAIL = BASE_URL +"adduserwithemail";


const SEND_OTP_REQUEST = BASE_URL +"addotp";
const VERIFY_OTP = BASE_URL +"verifyotp";
const GET_MODE = BASE_URL+"mode";
const GET_QUESTIONS = BASE_URL +"questions";
const ADD_IMAGE = BASE_URL +"addphoto";
const SETTING_URL = BASE_URL +"setting";
const SUBSCRITION_URL =BASE_URL +"allsubscription";

const ADD_EVENT = BASE_URL+"addevent";
const ALL_EVENT = BASE_URL+"allevent";
const MY_EVENT = BASE_URL+"myevent";
const MY_EVENT_BY_ID = BASE_URL+"myeventdetails";
const DELETE_EVENT = BASE_URL+"deleteevent";
const EDIT_EVENT = BASE_URL + "editevent";
const JOIN_EVENT = BASE_URL+"joinevent";
const JOIN_EVENT_DETAILS = BASE_URL+"joineventdetails";

const CHANGE_PASSWORD = BASE_URL + "changepass";

const REQUEST_SEND_MATCH = BASE_URL+"requestsend";
const GET_MATCH_LIST = BASE_URL+"receiverequest";
const REQUEST_REJECT_MATCH = BASE_URL+"statusrequest";
const GET_IMAGES_LINK = "https://dazzling-gates.62-151-182-243.plesk.page/uploads/userimages/";
const GET_EVENT_IMAGES_LINK = "https://dazzling-gates.62-151-182-243.plesk.page/uploads/event/";

const DELETE_ACCOUNT = BASE_URL+"deleteaccount";
const BLOCK_LIST = BASE_URL +"blocklist";
const UNBLOCK_USER = BASE_URL +"deleteblock";

const SUBSCRIPTION_URL = BASE_URL+"payment";
const SUBSCRIPTION_INSERT = BASE_URL+"insertpayment";
const NOTIFICATION_LIST = BASE_URL+"getnotification";


String Commonmessage = '';

const APP_ID = 'a375f20082bb431f86784c654a75f8ea';
const Token = '007eJxTYPjxZbl5ybWfYWKvjTYq7DIR+xBsGG6s2j15zyu7CzIu7PEKDInG5qZpRgYGFkZJSSbGhmkWZuYWJslmpiaJQHGL1ESt+wHJ9YGMDMqfSxgYoRDEF2bISy0vy0xJzU9OzMlJzkjMy0vNYWAAAC/gJKQ=';

final kApiUrl = defaultTargetPlatform == TargetPlatform.android
    ? 'http://10.0.2.2:4242'
    : 'http://localhost:4242';