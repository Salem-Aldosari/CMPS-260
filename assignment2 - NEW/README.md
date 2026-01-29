# Assignment 2 - Linux Commands and Scripting

**Student:** Salem Al-Dosari
**Course:** CMPS 260 - Introduction to Linux  
**Due Date:** January 21, 2026

---

## Problem 0: Setting Up The Environment

### Questions:

**Q: What does `pwd` do?**

`pwd` stands for "print working directory". It displays the absolute path of the current directory you're in within the filesystem. This command is helpful for knowing your exact location in the directory hierarchy, especially when navigating complex directory structures.

**Example output:** `/home/claude/cmps260/linux_assignment`

**Q: What does `whoami` do?**

`whoami` prints the username of the currently logged-in user. It's useful for confirming which user account you're operating under, which is important when dealing with permissions, file ownership, or when working on shared systems.

**Example output:** `claude` or `root`

---

## Problem 1: UNIX Filesystem + Shell

### Step 2: Command Behavior

**Q: Explain why the two commands in Step 1 behave differently.**

**Command 1:** `ls ; date`
- The semicolon (`;`) is a **command separator** in bash
- This runs **two separate commands** in sequence
- First executes `ls` (lists files in current directory)
- Then executes `date` (displays current date/time)
- Both commands run successfully

**Command 2:** `ls ";" date`
- The semicolon is **inside quotes**, making it a **literal string**
- Bash treats it as an argument to the `ls` command
- This tries to list two files: one named `;` and another named `date`
- Since these files don't exist, it produces an error: "cannot access ';': No such file or directory"

**Key Point:** Unquoted semicolons separate commands; quoted semicolons are treated as literal text.

---

### Step 7: Brace Expansion

**Q: Explain what happens in Step 6.**

The command `mkdir -p data/projects/{raw,processed} data/{notes,archive}` uses **brace expansion**, a powerful shell feature that generates multiple strings from a single pattern.

**How it expands:**
```
mkdir -p data/projects/{raw,processed} data/{notes,archive}
```
Expands to:
```
mkdir -p data/projects/raw data/projects/processed data/notes data/archive
```

**What each part does:**
- `{raw,processed}` creates two versions: one with "raw" and one with "processed"
- `{notes,archive}` creates two versions: one with "notes" and one with "archive"
- `-p` flag creates parent directories if they don't exist

**Result:** Creates the entire directory structure in a single command instead of needing four separate `mkdir` commands.

---

### Step 22: Umask

**Q: Explain what happened from Step 17-21.**

**Step 17:** Checked the current umask (typically `0022` or `022`)

**Step 18:** Created `u_before.txt` with the default umask
- With umask `0022`, new files get permissions `644` (rw-r--r--)
- Owner can read/write, group can read, others can read

**Step 19:** Changed umask to `077`
- This masks out (removes) all permissions for group and others
- More restrictive than the default

**Step 20:** Created `u_after.txt` with the new umask `077`
- With umask `077`, new files get permissions `600` (rw-------)
- Only owner can read/write, group and others have no access

**Step 21:** Compared both files with `ls -l`
- `u_before.txt`: `-rw-r--r--` (644) - readable by everyone
- `u_after.txt`: `-rw-------` (600) - accessible only by owner

**Concept:** Umask controls default permissions for newly created files. A higher umask value means more restrictive (fewer) default permissions. The umask value is subtracted from the maximum permissions (666 for files, 777 for directories) to determine the actual permissions.

---

### Step 25: Hard Links vs Symbolic Links

**Q: Explain what happened in Step 23-24.**

**Step 23 - Creating Links:**

1. **Created original file:** `link_target.txt` with content "link target"

2. **Created hard link:** `ln data/link_target.txt data/hardlink.txt`
   - A hard link points directly to the **file data (inode)** on disk
   - Both `link_target.txt` and `hardlink.txt` point to the same data
   - They are essentially two names for the same file

3. **Created symbolic link:** `ln -s link_target.txt data/symlink.txt`
   - A symbolic link (symlink) is a **pointer to the filename**
   - It's like a shortcut that references the original file by name
   - Depends on the original file existing

**Step 24 - Deleting Original:**

When we deleted `link_target.txt`:

- **Hard link (`hardlink.txt`):** Still works perfectly!
  - The data still exists on disk because at least one link (the hard link) remains
  - Can read the file content without any issues
  - File data is only deleted when the last hard link is removed

- **Symbolic link (`symlink.txt`):** Becomes a **broken link**!
  - Points to a filename that no longer exists
  - Displayed in red in most terminals or with special notation
  - Trying to read it produces "No such file or directory" error

**Key Differences:**
| Feature | Hard Link | Symbolic Link |
|---------|-----------|---------------|
| Points to | File data (inode) | Filename |
| Survives deletion | Yes | No |
| Cross-filesystem | No | Yes |
| Can link directories | No | Yes |

---

### Step 31: Diff vs Cmp

**Q: Explain what happened from Step 29-30.**

**Step 29 - Created two similar files:**
- `a.txt`: apples, oranges, walnuts
- `b.txt`: apples, oranges, grapes

Both files have the same first two lines but differ on the third line.

**Step 30 - Compared files:**

**1. `diff data/a.txt data/b.txt`**
- Shows a **human-readable** comparison of differences
- Output format:
  ```
  3c3
  < walnuts
  ---
  > grapes
  ```
- Meaning: "Line 3 changed (c) from 'walnuts' to 'grapes'"
- `3c3` = line 3 in file 1 changed to line 3 in file 2
- `<` shows line from first file
- `>` shows line from second file

**2. `cmp data/a.txt data/b.txt`**
- Reports the **first byte** where files differ
- Output: `data/a.txt data/b.txt differ: byte 18, line 3`
- More concise; just reports where difference starts
- Stops at first difference (doesn't show all differences)

**When to use each:**
- **diff:** Use for text files when you want to see all differences and potentially create a patch
- **cmp:** Use for quick checks, binary files, or when you just need to know if files differ

**Why they're different:**
- `diff` analyzes line-by-line and shows context
- `cmp` compares byte-by-byte and reports the location
- `diff` is better for understanding changes
- `cmp` is faster for large files when you just need a yes/no answer

---

## Summary

This assignment covered fundamental Linux concepts:

- **File System Navigation:** Understanding paths, directory structures, and brace expansion
- **Shell Behavior:** Command separators, quoting, and argument parsing
- **File Operations:** Creating, viewing, and manipulating files
- **Permissions:** Understanding umask, chmod, and access control
- **Links:** Hard links vs symbolic links and their behavior
- **File Comparison:** Using diff and cmp for finding differences
- **Text Processing:** Cat command variations and their options

These skills form the foundation for effective Linux system administration and scripting.

---

## Deliverables

```
assignment2/
├── README.md                    (this file)
├── outputs/
│   ├── problem0_commands.txt
│   ├── problem1.txt
│   └── problem1_commands.txt
└── data/
    └── [all created files]
```

---

**Completed:** January 29, 2026
