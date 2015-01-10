# CppContestHelper
Shell script for fast building and launching single source file c++ application.

###Usage

| **Option** | **Explanation** 
|:----------:|:------------- 
|-create     | creates I\O files (input.txt, output.txt) and source file main.cpp 
|-clear      | removes created files 
|-run        | build main.cpp and launch binary in case of successful build. stdin redirected to input.txt, stdout to output.txt 
|-reset      | clear & create 

