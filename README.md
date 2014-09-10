CyData
======

```shell
cy_data file1 file2 file3 ... fileN
```

Output will go to STDOUT with a marker row (e.g., "Output 1:", "Output 2:", "Output 3:") for each type of output.

Assumptions
============
* There is at least 1 input file
* Input files are text files, not binary files.
* Input files are either pipe-delimited, comma-delimited, or space-delimited
* Input file names end with either 'pipe.txt', 'comma.txt', or 'space.txt' (the suffix before '.txt' determines the file delimiter)
* Input files are relatively small (less than 20MB each)
* Delimiters do not appear anywhere in the data values
* Data records must have the following fields present: last name, first name, gender, and a birth date. Otherwise the record will be ignored
* Valid gender values are 'M', 'Male', 'F', 'Female'. Otherwise, the record will be ignored
* The date must be a valid string for Ruby's Date::parse. Otherwise the record will be ignored