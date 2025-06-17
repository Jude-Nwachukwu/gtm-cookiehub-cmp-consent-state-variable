___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "DD CookieHub CMP Consent State (Unofficial)",
  "categories": [
    "UTILITY"
  ],
  "description": "Use with the CookieHub CMP to identify the individual website user\u0027s consent state and configure when tags should execute.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "cookieHubConsentStateCheckType",
    "displayName": "Select Consent State Check Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "cookieHubAllConsentState",
        "displayValue": "All Consent State Check"
      },
      {
        "value": "cookieHubSpecificConsentState",
        "displayValue": "Specific Consent State"
      }
    ],
    "simpleValueType": true,
    "help": "Select the type of consent state check you want to perform—either a specific consent category or all consent categories, based on CookieFirst."
  },
  {
    "type": "RADIO",
    "name": "cookieHubConsentCategoryCheck",
    "displayName": "Select Consent Category",
    "radioItems": [
      {
        "value": "cookieHubNecessary",
        "displayValue": "Necessary"
      },
      {
        "value": "cookieHubPreferences",
        "displayValue": "Preferences"
      },
      {
        "value": "cookieHubAnalytics",
        "displayValue": "Analytics"
      },
      {
        "value": "cookieHubMarketing",
        "displayValue": "Marketing"
      }
    ],
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "cookieHubConsentStateCheckType",
        "paramValue": "cookieHubSpecificConsentState",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "cookieHubEnableOptionalConfig",
    "checkboxText": "Enable Optional Output Transformation",
    "simpleValueType": true
  },
  {
    "type": "GROUP",
    "name": "cookieHubOptionalConfig",
    "displayName": "CookieHub Consent State Value Transformation",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SELECT",
        "name": "cookieHubTrue",
        "displayName": "Transform \"True\"",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "cookieHubTrueGranted",
            "displayValue": "granted"
          },
          {
            "value": "cookieHubTrueAccept",
            "displayValue": "accept"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "SELECT",
        "name": "cookieHubFalse",
        "displayName": "Transform \"False\"",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "cookieHubFalseDenied",
            "displayValue": "denied"
          },
          {
            "value": "cookieHubFalseDeny",
            "displayValue": "deny"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "cookieHubUndefined",
        "checkboxText": "Also transform \"undefined\" to \"denied\"",
        "simpleValueType": true
      }
    ],
    "enablingConditions": [
      {
        "paramName": "cookieHubEnableOptionalConfig",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const callInWindow = require('callInWindow');
const getType = require('getType');

const checkType = data.cookieHubConsentStateCheckType;
const categoryCheck = data.cookieHubConsentCategoryCheck;

const enableTransform = data.cookieHubEnableOptionalConfig;
const transformTrue = data.cookieHubTrue;
const transformFalse = data.cookieHubFalse;
const transformUndefined = data.cookieHubUndefined;

function transformValue(val) {
  if (getType(val) === 'undefined') {
    return transformUndefined ? 'denied' : undefined;
  }

  if (!enableTransform) return val;

  if (val === true) {
    return transformTrue === 'cookieHubTrueGranted' ? 'granted' : 'accept';
  }
  if (val === false) {
    return transformFalse === 'cookieHubFalseDenied' ? 'denied' : 'deny';
  }
  return val;
}

function getConsentValue(category) {
  const result = callInWindow('cookiehub.hasConsented', category);
  return transformValue(result);
}

if (checkType === 'cookieHubAllConsentState') {
  return {
    necessary: getConsentValue('necessary'),
    preferences: getConsentValue('preferences'),
    marketing: getConsentValue('marketing'),
    analytics: getConsentValue('analytics')
  };
}

if (checkType === 'cookieHubSpecificConsentState') {
  let category;
  switch (categoryCheck) {
    case 'cookieHubNecessary':
      category = 'necessary';
      break;
    case 'cookieHubPreferences':
      category = 'preferences';
      break;
    case 'cookieHubMarketing':
      category = 'marketing';
      break;
    case 'cookieHubAnalytics':
      category = 'analytics';
      break;
    default:
      return undefined;
  }
  return getConsentValue(category);
}

return undefined;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "cookiehub.hasConsented"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 5/20/2025, 4:34:22 PM


