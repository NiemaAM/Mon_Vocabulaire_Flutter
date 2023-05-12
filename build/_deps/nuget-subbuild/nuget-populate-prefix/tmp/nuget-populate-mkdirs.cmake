# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-src"
  "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-build"
  "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix"
  "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/tmp"
  "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget-populate-stamp"
  "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src"
  "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget-populate-stamp"
)

set(configSubDirs Debug)
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "C:/Users/pc/Desktop/Mon_Vocabulaire_Flutter/build/_deps/nuget-subbuild/nuget-populate-prefix/src/nuget-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
