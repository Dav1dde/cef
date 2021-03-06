module deimos.cef1.web_urlrequest;

// Copyright (c) 2012 Marshall A. Greenblatt. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//    * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//    * Neither the name of Google Inc. nor the name Chromium Embedded
// Framework nor the names of its contributors may be used to endorse
// or promote products derived from this software without specific prior
// written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// ---------------------------------------------------------------------------
//
// This file was generated by the CEF translator tool and should not edited
// by hand. See the translator.README.txt file in the tools directory for
// more information.
//

// #ifndef CEF_INCLUDE_CAPI_CEF_WEB_URLREQUEST_CAPI_H_
// #pragma once

// #ifdef __cplusplus
extern(C) {
// #endif

import deimos.cef1.base;


///
// Structure used to make a Web URL request. Web URL requests are not associated
// with a browser instance so no cef_client_t callbacks will be executed. The
// functions of this structure may be called on any thread.
///
struct cef_web_urlrequest_t {
  ///
  // Base structure.
  ///
  cef_base_t base;

  ///
  // Cancels the request.
  ///
  extern(System) void function(cef_web_urlrequest_t* self) cancel;

  ///
  // Returns the current ready state of the request.
  ///
  extern(System) cef_weburlrequest_state_t function(cef_web_urlrequest_t* self) get_state;
}


///
// Create a new CefWebUrlRequest object.
///
cef_web_urlrequest_t* cef_web_urlrequest_create(cef_request_t* request, cef_web_urlrequest_client_t* client);


///
// Structure that should be implemented by the cef_web_urlrequest_t client. The
// functions of this structure will always be called on the UI thread.
///
struct cef_web_urlrequest_client_t {
  ///
  // Base structure.
  ///
  cef_base_t base;

  ///
  // Notifies the client that the request state has changed. State change
  // notifications will always be sent before the below notification functions
  // are called.
  ///
  extern(System) void function(cef_web_urlrequest_client_t* self, cef_web_urlrequest_t* requester, cef_weburlrequest_state_t state) on_state_change;

  ///
  // Notifies the client that the request has been redirected and  provides a
  // chance to change the request parameters.
  ///
  extern(System) void function(cef_web_urlrequest_client_t* self, cef_web_urlrequest_t* requester, cef_request_t* request, cef_response_t* response) on_redirect;

  ///
  // Notifies the client of the response data.
  ///
  extern(System) void function(cef_web_urlrequest_client_t* self, cef_web_urlrequest_t* requester, cef_response_t* response) on_headers_received;

  ///
  // Notifies the client of the upload progress.
  ///
  extern(System) void function(cef_web_urlrequest_client_t* self, cef_web_urlrequest_t* requester, uint64 bytesSent, uint64 totalBytesToBeSent) on_progress;

  ///
  // Notifies the client that content has been received.
  ///
  extern(System) void function(cef_web_urlrequest_client_t* self, cef_web_urlrequest_t* requester, const(void)* data, int dataLength) on_data;

  ///
  // Notifies the client that the request ended with an error.
  ///
  extern(System) void function(cef_web_urlrequest_client_t* self, cef_web_urlrequest_t* requester, cef_handler_errorcode_t errorCode) on_error;
}


// #ifdef __cplusplus
}
// #endif

// #endif CEF_INCLUDE_CAPI_CEF_WEB_URLREQUEST_CAPI_H_
