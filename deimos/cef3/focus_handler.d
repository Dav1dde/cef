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

extern(C) {

import deimos.cef3.base;


///
// Implement this structure to handle events related to focus. The functions of
// this structure will be called on the UI thread.
///
struct cef_focus_handler_t {
  ///
  // Base structure.
  ///
  cef_base_t base;

  ///
  // Called when the browser component is about to loose focus. For instance, if
  // focus was on the last HTML element and the user pressed the TAB key. |next|
  // will be true (1) if the browser is giving focus to the next component and
  // false (0) if the browser is giving focus to the previous component.
  ///
  extern(System) void function(cef_focus_handler_t* self, cef_browser_t* browser, int next) on_take_focus;

  ///
  // Called when the browser component is requesting focus. |source| indicates
  // where the focus request is originating from. Return false (0) to allow the
  // focus to be set or true (1) to cancel setting the focus.
  ///
  extern(System) int function(cef_focus_handler_t* self, cef_browser_t* browser,  cef_focus_source_t source) on_set_focus;

  ///
  // Called when the browser component has received focus.
  ///
  extern(System) void function(cef_focus_handler_t* self, cef_browser_t* browser) on_got_focus;
}


}
