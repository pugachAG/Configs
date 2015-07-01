# CppContestHelper
Shell script for fast building and launching single source file c++ application.

###Usage

| **Option** | **Explanation** 
|:----------:|:------------- 
|-create     | creates I/O files (input.txt, output.txt) and source file main.cpp 
|-clear      | removes created files 
|-run        | build main.cpp and launch binary in case of successful build, stdin and stdout redirected to input.txt and output.txt 
|-reset      | clear & create 
|-open       | vim -O main.cpp input.txt
