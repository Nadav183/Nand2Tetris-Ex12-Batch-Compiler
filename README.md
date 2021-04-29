# Nand2Tetris-Ex12-Batch-Compiler
This is a batch file that helps with testing the Nand2Tetris course ex12, the file calls the Nand2Tetris jack->vm compiler on all the files in the project and places a copy of the compiled file in each test folder.

This helps with the relatively tedious process of making changes and testing your files.
- The user inserts the absolute paths to their ex12 folder and to the Nand2Tetris tools folder, and adds the name to each folder that they put test files in (programs to check if the functionality of their Jack OS)
- Then the user can run the batch file (the file will prompt to make sure the user gave the arguments)
- The program will compile each jack file and display all compilation failures and notes
- The program will place a copy of the compiled file of each jack file in the basic test folder related to it (included in the software suite)
- If the user gave folders for full OS tests, the program will place a copy of each compiled file in every test folder
- The program will remain open so the user can review any compilation bugs for all of his files
- The program will ask if the user wants to run it again, if they do the program will clear the CMD window and run the compilation part again (without the first prompts) so only one click to rerun the compilation
