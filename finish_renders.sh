#!/bin/bash
# Waits for the 28 renders, converts them, rebuilds the site and commits.
IMG=/Users/gbrew/Desktop/faceless-pipeline/projects/lacrima-fici/images
PY=/private/tmp/claude-501/-Users-gbrew-Desktop-fyrup2/bcec3e4e-31aa-4df1-925f-8ba8db483dbb/scratchpad/venv/bin/python
for i in $(seq 1 60); do
  n=$(ls $IMG/*/ 2>/dev/null | grep -c png)
  running=$(pgrep -f "bin/generate.py" | wc -l | tr -d ' ')
  if [ "$n" -ge 28 ] || [ "$running" = "0" ]; then break; fi
  sleep 60
done
echo "renders present: $n"
cd /Users/gbrew/Desktop/fyrup2/campaign && $PY convert_images.py && $PY build.py && cd site && git add -A && git -c user.name="Luca" -c user.email="luca@ideasunion.com" commit -q -m "Add the remaining campaign renders

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>" && git log --oneline | head -1
