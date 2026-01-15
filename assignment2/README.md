# Assignment 2 - Linux Commands and Scripting

**Student:** [Your Name]  
**Course:** CMPS 260 - Introduction to Linux  
**Due:** January 21, 2026

---

## Problem 0: Environment Setup

### Questions:

**What does `pwd` do?**

`pwd` stands for "print working directory". It displays the absolute path of the current directory you're in. This is useful for knowing your location in the filesystem.

**What does `whoami` do?**

`whoami` prints the username of the current logged-in user. It's helpful for confirming which user account you're using, especially when working with multiple accounts or in scripts.

---

## Problem 1: UNIX Filesystem + Shell

### Step 1-2: Command Behavior

**Explain why the two commands behave differently:**

- `ls ; date` - The semicolon (`;`) is a command separator. This runs two separate commands: first `ls`, then `date`. Both commands execute successfully.

- `ls ";" date` - The semicolon is treated as a literal string enclosed in quotes, making it an argument to `ls`. Linux tries to find a file named `;` and a file named `date`, which don't exist, resulting in an error.

**Key Point:** Unquoted semicolons separate commands, while quoted semicolons are treated as literal text.

---

### Step 6-7: Brace Expansion

**Explain what happens in Step 6:**

The command `mkdir -p data/projects/{raw,processed} data/{notes,archive}` uses brace expansion, which is a powerful shell feature that generates multiple strings from a pattern.

This single command expands to:
- `mkdir -p data/projects/raw`
- `mkdir -p data/projects/processed`
- `mkdir -p data/notes`
- `mkdir -p data/archive`

The `-p` flag creates parent directories as needed, so it creates the entire path even if intermediate directories don't exist. This is much more efficient than running four separate mkdir commands.

---

### Step 17-22: Umask

**Explain what happened from Step 17-21:**

`umask` controls the default permissions for newly created files and directories. It works by "masking out" (removing) permissions.

- **Step 17**: Checked the default umask (typically `0022`)
- **Step 18**: Created `u_before.txt` with default umask, resulting in permissions `rw-r--r--` (644)
- **Step 19**: Changed umask to `077`, which removes all permissions for group and others
- **Step 20**: Created `u_after.txt` with new umask, resulting in permissions `rw-------` (600)
- **Step 21**: Compared both files - `u_before.txt` is readable by everyone, while `u_after.txt` is only accessible by the owner

**Key Point:** A higher umask value = more restrictive default permissions. Umask `077` means "remove all permissions for group and others."

---

### Step 23-25: Hard Links and Symbolic Links

**Explain what happened in Step 23-24:**

**Step 23 - Creating Links:**
- Created `link_target.txt` with content "link target"
- Created a **hard link** `hardlink.txt` pointing to the same inode
- Created a **symbolic link** `symlink.txt` pointing to the filename

**Step 24 - After Deleting Original:**
- Deleted `link_target.txt`
- `hardlink.txt` still works because it points to the actual data (inode)
- `symlink.txt` becomes a "broken link" because it points to a filename that no longer exists

**Key Differences:**
- **Hard Link**: Direct reference to file data; file data persists as long as one hard link remains
- **Symbolic Link**: Reference to filename; breaks if the original file is moved or deleted

---

### Step 29-31: Diff and Cmp

**Explain what happened from Step 29-30:**

**File Contents:**
- `a.txt`: apples, oranges, walnuts
- `b.txt`: apples, oranges, grapes

**Command Outputs:**
- `diff data/a.txt data/b.txt` shows a human-readable comparison:
  - Line 3 differs: "walnuts" vs "grapes"
  - Output: `3c3` means "line 3 changed to line 3"
  
- `cmp data/a.txt data/b.txt` reports the first byte difference:
  - Shows the byte and line number where files first differ
  - More suitable for binary files

**Key Differences:**
- **diff**: Shows all differences in a format suitable for patches; best for text files
- **cmp**: Shows where files first differ; more efficient for binary files or quick comparisons

---

## Problem 2: Processes, Filters and Pipes

### Step 4: Pipelines vs File Approach

**Why are pipelines preferred over the "file approach"?**

Pipelines are preferred because they:

1. **Don't create temporary files** - No disk I/O overhead or cleanup needed
2. **Stream data directly** - Commands process data as it flows, not after everything is written
3. **Save disk space** - No intermediate files consuming storage
4. **Are faster** - Data flows through memory rather than being written to and read from disk
5. **Are cleaner** - No temporary files left behind if the script fails
6. **Enable parallelism** - Commands in a pipeline can run simultaneously

Example: `cat file | command` runs both cat and command at the same time, while `cat file > temp; command < temp; rm temp` requires three sequential operations plus cleanup.

---

## Problem 3: Regular Expressions, grep/egrep/fgrep, tr, sed

### Step 5: Fgrep for Literal Strings

**Why is fgrep useful for fixed strings?**

`fgrep` (or `grep -F`) treats the search pattern as a literal string, not a regular expression. This is useful when:

1. **Searching for special characters** like `*`, `.`, `$`, `^`, `[`, `]` that have special meaning in regex
2. **Performance** - fgrep is faster because it doesn't need to parse regex patterns
3. **Simplicity** - No need to escape special characters

Example: To find the literal string `a*b*`:
- **fgrep**: `fgrep 'a*b*' file` ✓ Works directly
- **grep**: `grep 'a\*b\*' file` ✓ Requires escaping
- **egrep**: `egrep 'a\*b\*' file` ✓ Requires escaping

Without fgrep, you'd need to remember to escape every special character, which is error-prone when dealing with filenames, code, or user input containing regex metacharacters.

---

## Summary

This assignment covered fundamental Linux concepts:

- **File System Navigation**: Understanding paths, creating directory structures
- **Shell Behavior**: Command separators, quoting, brace expansion
- **File Operations**: Permissions, umask, links (hard vs symbolic)
- **Process Management**: Background jobs, PIDs, signals, process monitoring
- **Text Processing**: Filters, pipes, sorting, cutting, pasting
- **Pattern Matching**: Regular expressions, grep family, tr, sed

These skills form the foundation for effective Linux system administration and scripting.

---

## Files Included

```
assignment2/
├── README.md
├── outputs/
│   ├── problem0_commands.txt
│   ├── problem1.txt
│   ├── problem1_lecture2.txt
│   ├── problem1_commands.txt
│   ├── problem2_commands.txt
│   └── problem3_commands.txt
├── scripts/
│   ├── problem2_processes_filters.sh
│   └── problem3_regex_tr_sed.sh
└── data/
    └── [All created files from exercises]
```
