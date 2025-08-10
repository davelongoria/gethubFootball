#!/usr/bin/env python3
# dump_gms2_project.py
# Place in the ROOT of your GameMaker Studio 2.3+ project (next to the .yyp)
# Run: python dump_gms2_project.py
#
# Output:
#   gms2_project_dump.txt
#     - OBJECTS: every object, declared events (pretty names), and FULL event code (all .gml under the object folder)
#     - SCRIPTS: every script with full .gml contents
#     - SPRITES: names only (no metadata)

import os
import sys
import json
import glob
from datetime import datetime

PROJECT_ROOT = os.path.abspath(os.getcwd())
OUT_PATH = os.path.join(PROJECT_ROOT, "gms2_project_dump.txt")

# ----------------- Helpers -----------------

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
    except Exception:
        return None

def find_yyp():
    yyps = glob.glob(os.path.join(PROJECT_ROOT, "*.yyp"))
    return yyps[0] if yyps else None

def banner(ch="=", width=90):
    return ch * width

# ----------------- Event naming -----------------

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
    11: "Trigger",  # legacy
    12: "CleanUp",
    13: "Gesture",
    14: "Async",
}

STEP_SUB = {0: "Normal", 1: "Begin", 2: "End"}
DRAW_SUB = {
    0: "Draw",
    64: "Draw Begin",
    65: "Draw End",
    66: "Draw GUI",
    67: "Draw GUI Begin",
    68: "Draw GUI End",
}
ALARM_SUB = {i: f"Alarm {i}" for i in range(12)}

def collision_target_name(ev_dict):
    if not isinstance(ev_dict, dict):
        return None
    co = ev_dict.get("collisionObjectId")
    if isinstance(co, dict):
        return co.get("name")
    return None

def human_event_name(ev):
    if not isinstance(ev, dict):
        return "Unknown Event"
    et = ev.get("eventType")
    en = ev.get("eventNum")
    base = EVT_TYPES.get(et, f"UnknownType({et})")
    if et == 3:  # Step
        return f"Step – {STEP_SUB.get(en, f'Subtype({en})')}"
    if et == 8:  # Draw
        return DRAW_SUB.get(en, f"Subtype({en})")
    if et == 2:  # Alarm
        return ALARM_SUB.get(en, f"Alarm {en}")
    if et == 4:  # Collision
        co_name = collision_target_name(ev)
        return f"Collision – {co_name}" if co_name else f"Collision – (target id {en})"
    if isinstance(en, int) and en != 0:
        return f"{base} – Subtype({en})"
    return base

# ----------------- Object scanning -----------------

def list_objects():
    base = os.path.join(PROJECT_ROOT, "objects")
    out = []
    if not os.path.isdir(base):
        return out
    for root, dirs, files in os.walk(base):
        for f in files:
            if f.endswith(".yy"):
                yy = os.path.join(root, f)
                j = read_json(yy)
                if j and j.get("resourceType") == "GMObject":
                    out.append((j.get("name") or os.path.splitext(f)[0], yy))
    # dedupe by name
    seen = {}
    for name, yy in out:
        seen[name] = yy
    return sorted(seen.items(), key=lambda t: t[0].lower())

def object_event_labels(obj_yy_path):
    j = read_json(obj_yy_path)
    if not j:
        return []
    events = j.get("eventList") or j.get("events") or []
    return [human_event_name(ev) for ev in events]

def find_object_gml_files(obj_yy_path):
    obj_dir = os.path.dirname(obj_yy_path)
    found = []
    for root, dirs, files in os.walk(obj_dir):
        for f in files:
            if f.endswith(".gml"):
                full = os.path.join(root, f)
                rel = os.path.relpath(full, PROJECT_ROOT)
                found.append((full, rel))
    found.sort(key=lambda t: t[1].lower())
    return found

# ----------------- Script scanning -----------------

def list_scripts():
    base = os.path.join(PROJECT_ROOT, "scripts")
    out = []
    if not os.path.isdir(base):
        return out
    for root, dirs, files in os.walk(base):
        for f in files:
            if f.endswith(".gml"):
                full = os.path.join(root, f)
                rel = os.path.relpath(full, PROJECT_ROOT)
                parent = os.path.basename(os.path.dirname(full))
                stem = os.path.splitext(f)[0]
                name = parent if parent.lower() == stem.lower() else stem
                out.append((name, full, rel))
    # dedupe & sort
    seen = set()
    uniq = []
    for name, full, rel in out:
        key = (name.lower(), rel.lower())
        if key not in seen:
            seen.add(key)
            uniq.append((name, full, rel))
    uniq.sort(key=lambda t: (t[0].lower(), t[2].lower()))
    return uniq

# ----------------- Sprite names only -----------------

def list_sprite_names():
    base = os.path.join(PROJECT_ROOT, "sprites")
    names = []
    if not os.path.isdir(base):
        return names
    for root, dirs, files in os.walk(base):
        for f in files:
            if f.endswith(".yy"):
                full = os.path.join(root, f)
                j = read_json(full)
                if j and j.get("resourceType") == "GMSprite":
                    names.append(j.get("name") or os.path.splitext(f)[0])
    names = sorted(set(names), key=lambda s: s.lower())
    return names

# ----------------- Main dump -----------------

def main():
    yyp = find_yyp()
    project_name = os.path.splitext(os.path.basename(yyp))[0] if yyp else os.path.basename(PROJECT_ROOT)

    objects = list_objects()
    scripts = list_scripts()
    sprite_names = list_sprite_names()

    out = []
    out.append(banner("="))
    out.append(f"GMS2 PROJECT DUMP: {project_name}")
    out.append(f"Generated: {datetime.now().isoformat(timespec='seconds')}")
    out.append(f"Project root: {PROJECT_ROOT}")
    out.append(f"Project file: {os.path.relpath(yyp, PROJECT_ROOT) if yyp else '(no .yyp found)'}")
    out.append(banner("-"))
    out.append("INDEX")
    out.append(f"  Objects: {len(objects)}")
    for name, yy in objects:
        out.append(f"    - {name}  [{os.path.relpath(yy, PROJECT_ROOT)}]")
    out.append(f"  Scripts: {len(scripts)}")
    for name, _, rel in scripts:
        out.append(f"    - {name}  [{rel}]")
    out.append(f"  Sprites (names only): {len(sprite_names)}")
    for nm in sprite_names:
        out.append(f"    - {nm}")
    out.append(banner("="))
    out.append("")

    # ------------ OBJECTS ------------
    out.append(banner("#"))
    out.append("OBJECTS")
    out.append(banner("#"))
    out.append("")
    for name, yy in objects:
        out.append(banner())
        out.append(f"OBJECT: {name}")
        out.append(f"YY: {os.path.relpath(yy, PROJECT_ROOT)}")

        labels = object_event_labels(yy)
        if labels:
            out.append("Declared Events:")
            for lbl in labels:
                out.append(f"  - {lbl}")
        else:
            out.append("Declared Events: (none listed in .yy)")

        # Dump EVERY .gml under object folder
        gmls = find_object_gml_files(yy)
        if gmls:
            out.append("")
            out.append("EVENT CODE FILES:")
            for full, rel in gmls:
                out.append(banner("-"))
                out.append(rel)
                out.append(banner("-"))
                out.append(read_text(full))
                out.append("")  # spacer
        else:
            out.append("")
            out.append("(No .gml files found under this object.)")

        out.append("")  # spacer

    # ------------ SCRIPTS ------------
    out.append(banner("#"))
    out.append("SCRIPTS")
    out.append(banner("#"))
    out.append("")
    for name, full, rel in scripts:
        out.append(banner())
        out.append(f"SCRIPT: {name}")
        out.append(f"File: {rel}")
        out.append(banner("-"))
        out.append(read_text(full))
        out.append("")

    # ------------ SPRITES (names only) ------------
    out.append(banner("#"))
    out.append("SPRITES (names only)")
    out.append(banner("#"))
    out.append("")
    for nm in sprite_names:
        out.append(f"- {nm}")

    # Write file
    try:
        with open(OUT_PATH, "w", encoding="utf-8") as f:
            f.write("\n".join(out))
        print(f"Done! Wrote: {OUT_PATH}")
    except Exception as e:
        print(f"ERROR: Could not write output file: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
