# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

function(check_file_hash has_hash hash_is_good)
  if("${has_hash}" STREQUAL "")
    message(FATAL_ERROR "has_hash Can't be empty")
  endif()

  if("${hash_is_good}" STREQUAL "")
    message(FATAL_ERROR "hash_is_good Can't be empty")
  endif()

  if("SHA256" STREQUAL "")
    # No check
    set("${has_hash}" FALSE PARENT_SCOPE)
    set("${hash_is_good}" FALSE PARENT_SCOPE)
    return()
  endif()

  set("${has_hash}" TRUE PARENT_SCOPE)

  message(STATUS "verifying file...
       file='C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget.exe'")

  file("SHA256" "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget.exe" actual_value)

  if(NOT "${actual_value}" STREQUAL "d5fce5185de92b7356ea9264b997a620e35c6f6c3c061e471e0dc3a84b3d74fd")
    set("${hash_is_good}" FALSE PARENT_SCOPE)
    message(STATUS "SHA256 hash of
    C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget.exe
  does not match expected value
    expected: 'd5fce5185de92b7356ea9264b997a620e35c6f6c3c061e471e0dc3a84b3d74fd'
      actual: '${actual_value}'")
  else()
    set("${hash_is_good}" TRUE PARENT_SCOPE)
  endif()
endfunction()

function(sleep_before_download attempt)
  if(attempt EQUAL 0)
    return()
  endif()

  if(attempt EQUAL 1)
    message(STATUS "Retrying...")
    return()
  endif()

  set(sleep_seconds 0)

  if(attempt EQUAL 2)
    set(sleep_seconds 5)
  elseif(attempt EQUAL 3)
    set(sleep_seconds 5)
  elseif(attempt EQUAL 4)
    set(sleep_seconds 15)
  elseif(attempt EQUAL 5)
    set(sleep_seconds 60)
  elseif(attempt EQUAL 6)
    set(sleep_seconds 90)
  elseif(attempt EQUAL 7)
    set(sleep_seconds 300)
  else()
    set(sleep_seconds 1200)
  endif()

  message(STATUS "Retry after ${sleep_seconds} seconds (attempt #${attempt}) ...")

  execute_process(COMMAND "${CMAKE_COMMAND}" -E sleep "${sleep_seconds}")
endfunction()

if("C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget.exe" STREQUAL "")
  message(FATAL_ERROR "LOCAL can't be empty")
endif()

if("https://dist.nuget.org/win-x86-commandline/v6.5.0/nuget.exe" STREQUAL "")
  message(FATAL_ERROR "REMOTE can't be empty")
endif()

if(EXISTS "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget.exe")
  check_file_hash(has_hash hash_is_good)
  if(has_hash)
    if(hash_is_good)
      message(STATUS "File already exists and hash match (skip download):
  file='C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget.exe'
  SHA256='d5fce5185de92b7356ea9264b997a620e35c6f6c3c061e471e0dc3a84b3d74fd'"
      )
      return()
    else()
      message(STATUS "File already exists but hash mismatch. Removing...")
      file(REMOVE "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget.exe")
    endif()
  else()
    message(STATUS "File already exists but no hash specified (use URL_HASH):
  file='C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget.exe'
Old file will be removed and new file downloaded from URL."
    )
    file(REMOVE "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget.exe")
  endif()
endif()

set(retry_number 5)

message(STATUS "Downloading...
   dst='C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget.exe'
   timeout='none'
   inactivity timeout='none'"
)
set(download_retry_codes 7 6 8 15)
set(skip_url_list)
set(status_code)
foreach(i RANGE ${retry_number})
  if(status_code IN_LIST download_retry_codes)
    sleep_before_download(${i})
  endif()
  foreach(url https://dist.nuget.org/win-x86-commandline/v6.5.0/nuget.exe)
    if(NOT url IN_LIST skip_url_list)
      message(STATUS "Using src='${url}'")

      
      
      
      

      file(
        DOWNLOAD
        "${url}" "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget.exe"
        SHOW_PROGRESS
        # no TIMEOUT
        # no INACTIVITY_TIMEOUT
        STATUS status
        LOG log
        
        
        )

      list(GET status 0 status_code)
      list(GET status 1 status_string)

      if(status_code EQUAL 0)
        check_file_hash(has_hash hash_is_good)
        if(has_hash AND NOT hash_is_good)
          message(STATUS "Hash mismatch, removing...")
          file(REMOVE "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget.exe")
        else()
          message(STATUS "Downloading... done")
          return()
        endif()
      else()
        string(APPEND logFailedURLs "error: downloading '${url}' failed
        status_code: ${status_code}
        status_string: ${status_string}
        log:
        --- LOG BEGIN ---
        ${log}
        --- LOG END ---
        "
        )
      if(NOT status_code IN_LIST download_retry_codes)
        list(APPEND skip_url_list "${url}")
        break()
      endif()
    endif()
  endif()
  endforeach()
endforeach()

message(FATAL_ERROR "Each download failed!
  ${logFailedURLs}
  "
)
