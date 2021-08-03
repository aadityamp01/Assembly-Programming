# Assembly-Programming


### What is Assembly Language
- A processor understands only machine language instructions, which are strings of 1's and 0's. However, machine language is too obscure and complex for using in software development. So, the language is designed for a specific family of processors that represents various instructions in symbolic code and a more understandable form.
- An Assembly language is a type of low-level programming language that is intended to communicate directly with a computer's hardware.

### Advantages of Assembly Language
- It requires less memory and execution time;

- It allows hardware-specific complex jobs in an easier way;

- It is suitable for time-critical jobs;

- It is most suitable for writing interrupt service routines and other memory resident programs.


### Compiling and Linking an Assembly Program in NASM

- Make sure you have set the path of nasm and ld binaries in your PATH environment variable. Now, take the following steps for compiling and linking the above program −

- Type the above code using a text editor and save it as file_name.asm.

- Make sure that you are in the same directory as where you saved file_name.asm.

- To assemble the program, type 
```
nasm -f elf64 file_name.asm
```


- If there is any error, you will be prompted about that at this stage. Otherwise, an object file of your program named file_name.o will be created.

- To link the object file and create an executable file named file_name, type 
```
ld -o file_name file_name.o
```
- Execute the program by typing 
```
./file_name
```
### Contributors 
##### If you are interested to contribute on this project, then please raise an issue in appropriate format and send PR. Valid PR will be happily accepted.

### Star and Fork this Repository, if you like
###### You can star ⭐ and fork 🍽️ this repository on GitHub by navigating at the top of this repository.

### Contact
> **_If you face any issue, feel free to contact me: @ [ampicopn@gmail.com]_**
