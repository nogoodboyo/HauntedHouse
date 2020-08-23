# Haunted House
An excercise in porting a C64 BASIC adventure to XC=BASIC.

C64 BASIC is based on [Microsoft BASIC](https://en.wikipedia.org/wiki/Microsoft_BASIC). 

[XC=BASIC](https://github.com/neilsf/XC-BASIC) is a dialect of C64 BASIC which cross compiles to 6502 machine code through the [DASM](https://dasm-assembler.github.io/) macro assembler.

The project ports a slighltly modified version of the text adventure "Haunted House", first published in the [Usborne](https://usborne.com/) book [Write Your Own Adventure Programs For Your Microcomputer](https://drive.google.com/file/d/0Bxv0SsvibDMTYkFJbUswOHFQclE/view)(1983). The adventure was written for the VIC 20, but I chose to use it as it is a simple program to understand. If you are curious, there are other books in the series with larger adventure games. [Check 'em out!](https://usborne.com/browse-books/features/computer-and-coding-books/)

## IDE Setup

There are 2 source files of interest in this project. The first is the original C64 BASIC version, the second is the XC=BASIC port. Though not neccessary, each uses a different IDE to ease development. 

The C64 BASIC IDE is [CBM prg Studio](http://www.ajordison.co.uk/index.html) developed by Arthur Jordison. It is a labour of love, and a most satisfying IDE for this purpose. [Download it](http://www.ajordison.co.uk/download.html) and please consider donating to the project if you find it useful. I know I have!

Use either [VICE](https://vice-emu.sourceforge.io/) or [Hoxs64](https://www.hoxs64.net/) for C64 emulation. Either works well. Many prefer VICE, but I prefer Hox64 as it is more straight forward to use for this purpose.

Configure the path to your preferred emulator. If using Hoxs64, the "Emulator Parameters" setting in CBM prg Studio should be set to:

```
-autoload %prg
```

You can then press F5 to compile the source and build a .prg file which will then open and run it in Hoxs64.

For the XC=BASIC side, I use VSCode with the [XC=BASIC langauge support](https://marketplace.visualstudio.com/items?itemName=viza.xcbasiclanguagevscodeext) plugin. It is rudimentary, but it does give syntax highlighting, snippets and directions on how to add a compile task.


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## License
[MIT](https://choosealicense.com/licenses/mit/)