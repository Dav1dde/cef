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
// Structure used to create and/or parse command line arguments. Arguments with
// '--', '-' and, on Windows, '/' prefixes are considered switches. Switches
// will always precede any arguments without switch prefixes. Switches can
// optionally have a value specified using the '=' delimiter (e.g.
// "-switch=value"). An argument of "--" will terminate switch parsing with all
// subsequent tokens, regardless of prefix, being interpreted as non-switch
// arguments. Switch names are considered case-insensitive. This structure can
// be used before cef_initialize() is called.
///
struct cef_command_line_t {
  ///
  // Base structure.
  ///
  cef_base_t base;

  ///
  // Returns true (1) if this object is valid. Do not call any other functions
  // if this function returns false (0).
  ///
  extern(System) int function(cef_command_line_t* self) is_valid;

  ///
  // Returns true (1) if the values of this object are read-only. Some APIs may
  // expose read-only objects.
  ///
  extern(System) int function(cef_command_line_t* self) is_read_only;

  ///
  // Returns a writable copy of this object.
  ///
  extern(System) cef_command_line_t* function(cef_command_line_t* self) copy;

  ///
  // Initialize the command line with the specified |argc| and |argv| values.
  // The first argument must be the name of the program. This function is only
  // supported on non-Windows platforms.
  ///
  extern(System) void function(cef_command_line_t* self, int argc, const(char)* const* argv) init_from_argv;

  ///
  // Initialize the command line with the string returned by calling
  // GetCommandLineW(). This function is only supported on Windows.
  ///
  extern(System) void function(cef_command_line_t* self, const(cef_string_t)* command_line) init_from_string;

  ///
  // Reset the command-line switches and arguments but leave the program
  // component unchanged.
  ///
  extern(System) void function(cef_command_line_t* self) reset;

  ///
  // Retrieve the original command line string as a vector of strings. The argv
  // array: { program, [(--|-|/)switch[=value]]*, [--], [argument]* }
  ///
  extern(System) void function(cef_command_line_t* self, cef_string_list_t argv) get_argv;

  ///
  // Constructs and returns the represented command line string. Use this
  // function cautiously because quoting behavior is unclear.
  ///
  // The resulting string must be freed by calling cef_string_userfree_free().
  extern(System) cef_string_userfree_t function(cef_command_line_t* self) get_command_line_string;

  ///
  // Get the program part of the command line string (the first item).
  ///
  // The resulting string must be freed by calling cef_string_userfree_free().
  extern(System) cef_string_userfree_t function(cef_command_line_t* self) get_program;

  ///
  // Set the program part of the command line string (the first item).
  ///
  extern(System) void function(cef_command_line_t* self, const(cef_string_t)* program) set_program;

  ///
  // Returns true (1) if the command line has switches.
  ///
  extern(System) int function(cef_command_line_t* self) has_switches;

  ///
  // Returns true (1) if the command line contains the given switch.
  ///
  extern(System) int function(cef_command_line_t* self, const(cef_string_t)* name) has_switch;

  ///
  // Returns the value associated with the given switch. If the switch has no
  // value or isn't present this function returns the NULL string.
  ///
  // The resulting string must be freed by calling cef_string_userfree_free().
  extern(System) cef_string_userfree_t function(cef_command_line_t* self, const(cef_string_t)* name) get_switch_value;

  ///
  // Returns the map of switch names and values. If a switch has no value an
  // NULL string is returned.
  ///
  extern(System) void function(cef_command_line_t* self, cef_string_map_t switches) get_switches;

  ///
  // Add a switch to the end of the command line. If the switch has no value
  // pass an NULL value string.
  ///
  extern(System) void function(cef_command_line_t* self, const(cef_string_t)* name) append_switch;

  ///
  // Add a switch with the specified value to the end of the command line.
  ///
  extern(System) void function(cef_command_line_t* self, const(cef_string_t)* name, const(cef_string_t)* value) append_switch_with_value;

  ///
  // True if there are remaining command line arguments.
  ///
  extern(System) int function(cef_command_line_t* self) has_arguments;

  ///
  // Get the remaining command line arguments.
  ///
  extern(System) void function(cef_command_line_t* self, cef_string_list_t arguments) get_arguments;

  ///
  // Add an argument to the end of the command line.
  ///
  extern(System) void function(cef_command_line_t* self, const(cef_string_t)* argument) append_argument;

  ///
  // Insert a command before the current command. Common for debuggers, like
  // "valgrind" or "gdb --args".
  ///
  extern(System) void function(cef_command_line_t* self, const(cef_string_t)* wrapper) prepend_wrapper;
}


///
// Create a new cef_command_line_t instance.
///
cef_command_line_t* cef_command_line_create();

///
// Returns the singleton global cef_command_line_t object. The returned object
// will be read-only.
///
cef_command_line_t* cef_command_line_get_global();
}