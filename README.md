# extract-strings.sh

A simple Bash script that recursively runs `strings` on every file in a given directory and saves the results to text files.

## Requirements

- **bash** — any modern version should work  
- **strings** — usually included in the `binutils` package  
- **find** and **mkdir** — standard Unix utilities

## Installation

Clone the repository and make the script executable:

```bash
git clone https://github.com/yourusername/extract-strings.git
cd extract-strings
chmod +x extract-strings.sh
```

## Usage

```bash
./extract-strings.sh <base_directory> [-o output_dir_name]
```

Arguments
- `<base_directory>` — directory to scan
- `-o <output_dir_name>` (optional) - name for the output directory. Defaults to `<base_directory>_extracted_strings`


