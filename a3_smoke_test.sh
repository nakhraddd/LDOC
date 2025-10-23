#!/bin/bash

APT_PACKAGES=("git" "python3" "python3-pip" "python3-venv" "nginx" "ufw" "net-tools")
PIP_PACKAGES=("requests" "flask" "pytest")

FAIL=0

echo "===== Smoke Test: Package Verification ====="
echo ""

# --- Check APT packages ---
echo "🔹 Checking APT packages..."
for pkg in "${APT_PACKAGES[@]}"; do
    if dpkg -s "$pkg" >/dev/null 2>&1; then
        echo "$pkg is installed"
    else
        echo "$pkg is NOT installed"
        FAIL=1
    fi
done

echo ""
# --- Check PIP packages ---
echo "🔹 Checking Python (pip) packages..."
for pkg in "${PIP_PACKAGES[@]}"; do
    if python3 -m pip show "$pkg" >/dev/null 2>&1; then
        echo "Python package '$pkg' is installed"
    else
        echo "Python package '$pkg' is NOT installed"
        FAIL=1
    fi
done

echo ""
echo "===== Smoke Test Completed ====="

# --- Final exit code ---
if [ $FAIL -eq 0 ]; then
    echo "All checks passed."
    exit 0
else
    echo "Some checks failed."
    exit 1
fi
