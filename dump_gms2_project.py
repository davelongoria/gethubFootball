#!/usr/bin/env python3
# dump_gms2_project.py
# Place this file in the ROOT of your GameMaker Studio 2.3+ project (next to the .yyp)
# Run: python dump_gms2_project.py
#
# Output: gms2_project_dump.txt containing:
# - Objects with event lists and full event code (from .gml files)
# - Scripts with full .gml contents
#
# This script is read-only and will not modify your project.

import os
import sys
import json
import glob
from datetime import datetime

PROJECT_ROOT = os.path.abspath(os.getcwd())
OUT_PATH = os.path.join(PROJECT_ROOT, "gms2_project_dump.txt")

# --- Helpers -----------------------------------------------------------------

def read_text(path):
    try:
        with open(path, "r", encoding="utf-8", errors="replace") as f:
            return f.read()
    except Exception as e:
        return f"<<ERROR reading {path}: {e}>>"

def read_json(path):
    try:
        with open(path, "r", encoding="utf-8", errors="replace") as f:
            return json.load(f)
    except Exception as e:
        return None

def find_yyp():
    yyps = glob.glob(os.path.join(PROJECT_ROOT, "*.yyp"))
    return yyps[0] if yyps else None

# Event mapping (GMS2 internal numbers -> human labels)
EVT_TYPES = {
    0:  "Create",
    1:  "Destroy",
    2:  "Alarm",
    3:  "Step",
    4:  "Collision",
    5:  "Keyboard",
    6:  "Mouse",
    7:  "Other",
    8:  "Draw",
    9:  "KeyPress",
    10: "KeyRelease",
    11: "Trigger",  # (legacy)
    12: "CleanUp",
    13: "Gesture",
    14: "Async",
}

# Subtype labels for selected event types
STEP_SUB = {0: "Normal", 1: "Begin", 2: "End"}
DRAW_SUB = {
    0: "Draw",
    64: "Draw Begin",
    65: "Draw End",
    66: "Draw GUI",
    67: "Draw GUI Begin",
    68: "Draw GUI End",
    # Other specialized draw subtypes can be added if present
}
ALARM_SUB = {i: f"Alarm {i}" for i in range(12)}

# A best-effort collision name fetch (requires collisionObjectId name in .yy)
def collision_name(sub_json):
    # In 2.3+, collision events include collisionObjectId with {name, path} or null
    if not isinstance(sub_json, dict):
        return None
    co = sub_json.get("collisionObjectId")
    if isinstance(co, dict):
        return co.get("name") or None
    return None

def human_event_name(ev):
    """
    ev is expected to be a dict from an object's .yy eventList entry, e.g.:
    {
      "resourceType": "GMEvent",
      "eventType": 3,
      "eventNum": 0,
      "isDnD": false,
      "collisionObjectId": {...} or null,
      ...
    }
    """
    if not isinstance(ev, dict):
        return None

    et = ev.get("eventType")
    en = ev.get("eventNum")

    base = EVT_TYPES.get(et, f"UnknownType({et})")

    # Per-type sublabeling
    if et == 3:  # Step
        sub = STEP_SUB.get(en, f"Subtype({en})")
        return f"Step – {sub}"
    if et == 8:  # Draw
        sub = DRAW_SUB.get(en, f"Subtype({en})")
        return sub
    if et == 2:  # Alarm
        sub = ALARM_SUB.get(en, f"Alarm {en}")
        return sub
    if et == 4:  # Collision
        # Try to name the collision object
        co_name = collision_name(ev)
        if co_name:
            return f"Collision – {co_name}"
        else:
            return f"Collision – (object id {en})"
    else:
        # For everything else, eventNum often acts like a subtype; include if nonzero
        if isinstance(en, int) and en != 0:
            return f"{base} – Subtype({en})"
        return base

def list_object_dirs():
    base = os.path.join(PROJECT_ROOT, "objects")
    if not os.path.isdir(base):
        return []
    # Object folders typically look like objects/objName/objName.yy (+ .events/*.gml)
    result = []
    for root, dirs, files in os.walk(base):
        for f in files:
            if f.endswith(".yy"):
                # Heuristic: object .yy lives one level down under /objects/<name>/<name>.yy
                # We’ll verify it looks like a GMObject by reading the JSON.
                yy_path = os.path.join(root, f)
                j = read_json(yy_path)
                if j and j.get("resourceType") == "GMObject":
                    result.append((j.get("name") or os.path.splitext(f)[0], yy_path))
    # Remove duplicates (same object could be encountered via deep walk)
    dedup = {}
    for name, path in result:
        dedup[name] = path
    return sorted(dedup.items(), key=lambda x: x[0].lower())

def find_object_gmls(obj_yy_path):
    """
    Return list of (.gml_path, rel_display_name) within the object folder.
    We’ll scan for any .gml files beneath the object's directory.
    """
    obj_dir = os.path.dirname(obj_yy_path)
    gmls = []
    for root, dirs, files in os.walk(obj_dir):
        for f in files:
            if f.endswith(".gml"):
                full = os.path.join(root, f)
                rel = os.path.relpath(full, PROJECT_ROOT)
                gmls.append((full, rel))
    # Stable sort by relative path
    gmls.sort(key=lambda t: t[1].lower())
    return gmls

def get_object_events_from_yy(obj_yy_path):
    j = read_json(obj_yy_path)
    if not j:
        return []
    events = j.get("eventList") or []
    # Some projects may use "events" instead; handle both
    if not events and "events" in j and isinstance(j["events"], list):
        events = j["events"]
    out = []
    for ev in events:
        label = human_event_name(ev) or "Unknown Event"
        out.append(label)
    return out

def list_scripts():
    """
    Returns list of (script_name, gml_path, rel_display_path)
    Expected structure: scripts/<ScriptName>/<ScriptName>.gml (2.3+)
    """
    base = os.path.join(PROJECT_ROOT, "scripts")
    results = []
    if not os.path.isdir(base):
        return results

    for root, dirs, files in os.walk(base):
        for f in files:
            if f.endswith(".gml"):
                full = os.path.join(root, f)
                rel = os.path.relpath(full, PROJECT_ROOT)
                # script name = folder name or file stem (prefer folder)
                parent = os.path.basename(os.path.dirname(full))
                stem = os.path.splitext(f)[0]
                name = parent if parent.lower() == stem.lower() else stem
                results.append((name, full, rel))

    # Deduplicate by (name, path)
    seen = set()
    uniq = []
    for name, full, rel in results:
        key = (name, rel.lower())
        if key not in seen:
            seen.add(key)
            uniq.append((name, full, rel))
    # Sort nicely
    uniq.sort(key=lambda t: (t[0].lower(), t[2].lower()))
    return uniq

def banner_line(ch="=", width=80):
    return ch * width

# --- Main dump ---------------------------------------------------------------

def main():
    yyp = find_yyp()
    project_name = os.path.splitext(os.path.basename(yyp))[0] if yyp else os.path.basename(PROJECT_ROOT)

    objects = list_object_dirs()
    scripts = list_scripts()

    # Build an index first
    lines = []
    lines.append(banner_line("="))
    lines.append(f"GMS2 PROJECT DUMP: {project_name}")
    lines.append(f"Generated: {datetime.now().isoformat(timespec='seconds')}")
    lines.append(f"Project root: {PROJECT_ROOT}")
    if yyp:
        lines.append(f"Project file: {os.path.relpath(yyp, PROJECT_ROOT)}")
    else:
        lines.append("Project file: (no .yyp found; proceeding by folder scan)")
    lines.append(banner_line("-"))
    lines.append("INDEX")
    lines.append(f"  Objects found: {len(objects)}")
    for name, yy in objects:
        lines.append(f"    - {name}  [{os.path.relpath(yy, PROJECT_ROOT)}]")
    lines.append(f"  Scripts found: {len(scripts)}")
    for name, _, rel in scripts:
        lines.append(f"    - {name}  [{rel}]")
    lines.append(banner_line("="))
    lines.append("")

    # Dump Objects
    lines.append(banner_line("#"))
    lines.append("OBJECTS")
    lines.append(banner_line("#"))
    lines.append("")
    for name, yy in objects:
        lines.append(banner_line())
        lines.append(f"OBJECT: {name}")
        lines.append(f"YY: {os.path.relpath(yy, PROJECT_ROOT)}")
        # Events from .yy (pretty labels)
        ev_labels = get_object_events_from_yy(yy)
        if ev_labels:
            lines.append("Declared Events (from .yy):")
            for lbl in ev_labels:
                lines.append(f"  - {lbl}")
        else:
            lines.append("Declared Events (from .yy): (none or unavailable)")

        # Pull any .gml files under the object folder
        gmls = find_object_gmls(yy)
        if gmls:
            lines.append("")
            lines.append("EVENT CODE FILES:")
            for full, rel in gmls:
                lines.append(banner_line("-"))
                lines.append(f"{rel}")
                lines.append(banner_line("-"))
                lines.append(read_text(full))
                lines.append("")  # spacer
        else:
            lines.append("")
            lines.append("(No .gml files found under this object.)")
        lines.append("")  # spacer between objects

    # Dump Scripts
    lines.append(banner_line("#"))
    lines.append("SCRIPTS")
    lines.append(banner_line("#"))
    lines.append("")
    for name, full, rel in scripts:
        lines.append(banner_line())
        lines.append(f"SCRIPT: {name}")
        lines.append(f"File: {rel}")
        lines.append(banner_line("-"))
        lines.append(read_text(full))
        lines.append("")

    # Write out
    try:
        with open(OUT_PATH, "w", encoding="utf-8") as f:
            f.write("\n".join(lines))
        print(f"Done! Wrote: {OUT_PATH}")
    except Exception as e:
        print(f"ERROR: Could not write output file: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
