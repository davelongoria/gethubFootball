#!/usr/bin/env python3
import os

def list_gml_files(root):
    files_found = []
    for folder, _, files in os.walk(root):
        for f in files:
            if f.lower().endswith(".gml"):
                files_found.append(os.path.join(folder, f))
    return files_found

def scan_file(filepath):
    issues = []
    with open(filepath, "r", encoding="utf-8") as f:
        text = f.read()

    # Check for unclosed block comments
    block_comment_open = text.count("/*")
    block_comment_close = text.count("*/")
    if block_comment_open > block_comment_close:
        issues.append("UNCLOSED_BLOCK_COMMENT")

    # Check for unclosed string literals
    double_quotes = text.count('"')
    if double_quotes % 2 != 0:
        issues.append("UNCLOSED_STRING")

    # Check for huge files
    if len(text) > 50000:
        issues.append(f"HUGE_FILE_{len(text)}_CHARS")

    return issues

def main():
    here = os.path.abspath(os.path.dirname(__file__))
    all_files = list_gml_files(here)

    print(f"Scanning {len(all_files)} .gml files...\n")

    results = {}
    for file_path in all_files:
        rel_path = os.path.relpath(file_path, here)
        print(f"Scanning: {rel_path}")
        try:
            issues = scan_file(file_path)
            if issues:
                results[rel_path] = issues
        except Exception as e:
            print(f"\n❌ ERROR in {rel_path} : {e}")
            break

    print("\n=== Scan Complete ===")
    if results:
        print("Potential issues found:")
        for path, issues in results.items():
            print(f" - {path} : {', '.join(issues)}")
    else:
        print("No obvious syntax issues detected.")

    input("\nPress Enter to close…")

if __name__ == "__main__":
    main()
