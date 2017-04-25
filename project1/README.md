## Tested Environment
  - Ubuntu 16.04.2 LTS
  - flex 2.6.0
  - g++ 5.4.0
  
## Files
  - compile.sh: `$ sh compile.sh` applies flex on korean_automata.l and compiles with korean_chars.cpp to make simple_text_editor.
  - korean_automata.l: Lex file that contains korean automata and main function.
  - korean_chars.cpp: Contains arrays of korean characters.
  - korean_chars.hpp: Header file for korean_chars.cpp.
  - lex.yy.cc: Result c++ file of `$ flex++ korean_automata.l`.
  - simple_text_editor: Executable file.
  
## Description
  - To compile program: `$ sh compile.sh` (It may take some time. Please wait.).
  - To run program: `$ ./simple_text_editor`.
  - Available keys: 
    - [ASCII Code](http://www.asciitable.com/) 0x20 to 0x7F and newline character (pressing enter).
    - Only supports backspace (remove character at left of cursor). Delete (remove character at right of cursor) is not supported.
    - Does not support moving cursor. Only can add/delete at end of line.
  - Behavioral characteristics:
    - Work as chosung-woosun (초성우선).
    - Running this program clears the console screen.
    - Backspace key deletes only one vowel or one consonant at a time. Which means 고기 becomes 고ㄱ, 고, ㄱ, and then empty string for each hit of backspace key.
    - To exit program, hit Ctrl+C.
    - Keys that korean characters are not assigned are treated as itself. For example, 'a' key is assigned to ㅁ so it is treated as ㅁ, but 'A' key is not assigned to any korean character, so 'A' is treated as A.
    
